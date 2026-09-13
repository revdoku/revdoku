#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class RevdokuInstallerIntegrityTest < Minitest::Test
  CLIENT_ROOT = File.expand_path("..", __dir__)
  PUBLIC_PACKAGE = File.directory?(File.join(CLIENT_ROOT, "skills/revdoku"))
  PAYLOADS = {
    "skills/revdoku/SKILL.md" => PUBLIC_PACKAGE ? "skills/revdoku/SKILL.md" : "skill/SKILL.md",
    "skills/revdoku/scripts/revdoku.sh" => PUBLIC_PACKAGE ? "skills/revdoku/scripts/revdoku.sh" : "skill/scripts/revdoku.sh",
    "skills/revdoku/bin/revdoku" => PUBLIC_PACKAGE ? "skills/revdoku/bin/revdoku" : "bin/revdoku"
  }.freeze

  def setup
    @tmp = Dir.mktmpdir("revdoku-installer-test-")
    @commands = File.join(@tmp, "commands")
    @remote = File.join(@tmp, "remote")
    @target = File.join(@tmp, "installed with spaces")
    @scratch = File.join(@tmp, "scratch")
    FileUtils.mkdir_p([@commands, @target, @scratch])
    %w[bash dirname mkdir mktemp sha256sum shasum openssl awk cp chmod mv rm uname tr].each do |name|
      path = ENV.fetch("PATH").split(File::PATH_SEPARATOR).map { |dir| File.join(dir, name) }
        .find { |candidate| File.executable?(candidate) && !File.directory?(candidate) }
      File.symlink(path, File.join(@commands, name)) if path
    end
    @env = {
      "PATH" => @commands, "TMPDIR" => @scratch,
      "REVDOKU_INSTALL_BASE" => nil, "REVDOKU_AGENT" => "both",
      "CODEX_HOME" => File.join(@target, "codex"), "CLAUDE_HOME" => File.join(@target, "claude"),
      "REVDOKU_BIN_DIR" => File.join(@target, "bin"), "REVDOKU_CONFIG_DIR" => File.join(@target, "config"),
      "INSTALL_TEST_REMOTE" => @remote, "INSTALL_TEST_LOG" => File.join(@tmp, "downloads"),
      "INSTALL_TEST_FAIL_PATH" => nil, "INSTALL_TEST_INTERRUPT" => nil
    }
    PAYLOADS.each { |public_path, source| write(File.join(@remote, public_path), File.binread(File.join(CLIENT_ROOT, source))) }
    @installer = File.join(@tmp, "installer/install.sh")
    write(@installer, File.read(File.join(CLIENT_ROOT, "install.sh")))
    write(File.join(@commands, "jq"), "#!/bin/sh\nexit 0\n", mode: 0o755)
    write(File.join(@commands, "curl"), <<~SH, mode: 0o755)
      #!/bin/sh
      set -eu
      [ "$1" = '--proto' ] && [ "$2" = '=https' ] || exit 90
      [ "$3" = '--proto-redir' ] && [ "$4" = '=https' ] || exit 91
      shift 4
      [ "$1" = '-fsSL' ] || exit 92
      url=$2
      [ "$3" = '-o' ] || exit 93
      target=$4
      case "$url" in
        https://raw.githubusercontent.com/revdoku/revdoku/main/*) path=${url#https://raw.githubusercontent.com/revdoku/revdoku/main/} ;;
        https://github.com/jqlang/jq/releases/download/jq-1.8.1/*) path=jq ;;
        *) exit 94 ;;
      esac
      printf '%s\n' "$path" >> "$INSTALL_TEST_LOG"
      if [ "$path" = "${INSTALL_TEST_FAIL_PATH:-}" ]; then
        printf 'partial bytes' > "$target"
        if [ "${INSTALL_TEST_INTERRUPT:-}" = 'true' ]; then
          kill -TERM "$PPID"
        fi
        exit 18
      fi
      cp "$INSTALL_TEST_REMOTE/$path" "$target"
    SH
  end

  def teardown
    FileUtils.remove_entry(@tmp)
  end

  def test_network_install_verifies_and_reuses_payload_for_multiple_agents
    stdout, stderr, status = run_installer({ "REVDOKU_CLIENT_VERSION" => "0.0.0" }, stdin: true)
    assert status.success?, "#{stderr}\n#{stdout}"
    assert_equal PAYLOADS.keys.sort, File.readlines(@env.fetch("INSTALL_TEST_LOG"), chomp: true).sort
    %w[codex claude].each do |agent|
      PAYLOADS.each_key do |path|
        destination = File.join(@target, agent, path)
        assert_equal File.binread(File.join(@remote, path)), File.binread(destination)
        assert_equal(path.end_with?("SKILL.md") ? 0o644 : 0o755, File.stat(destination).mode & 0o777)
      end
    end
    assert_equal File.binread(File.join(@remote, "skills/revdoku/bin/revdoku")), File.binread(File.join(@target, "bin/revdoku"))
    version_file = File.join(CLIENT_ROOT, PUBLIC_PACKAGE ? "VERSION" : "../../../VERSION")
    assert_equal File.read(version_file).strip, File.read(File.join(@target, "config/client_version")).strip
    assert_empty Dir.children(@scratch)
  end

  def test_each_tampered_network_payload_preserves_existing_installation
    seed_existing_installation
    before = installed_snapshot
    PAYLOADS.each_key do |path|
      file = File.join(@remote, path)
      original = File.binread(file)
      write(file, "tampered content\n")
      _, stderr, status = run_installer
      refute status.success?
      assert_includes stderr, "checksum mismatch for #{path}"
      assert_equal before, installed_snapshot
      assert_empty Dir.children(@scratch)
      write(file, original)
    end
  end

  def test_local_payloads_are_verified_in_both_layouts
    %w[source public].each do |layout|
      root = File.join(@tmp, layout)
      installer = File.join(root, "install.sh")
      write(installer, File.read(@installer))
      PAYLOADS.each do |public_path, source_path|
        relative = layout == "public" ? public_path : source_path
        write(File.join(root, relative), File.binread(File.join(@remote, public_path)))
      end
      _, stderr, status = run_installer({}, installer: installer)
      assert status.success?, stderr
      refute File.exist?(@env.fetch("INSTALL_TEST_LOG"))
      before = installed_snapshot
      PAYLOADS.each do |public_path, source_path|
        file = File.join(root, layout == "public" ? public_path : source_path)
        original = File.binread(file)
        write(file, "tampered local file\n")
        _, stderr, status = run_installer({}, installer: installer)
        refute status.success?
        assert_includes stderr, "checksum mismatch for #{public_path}"
        assert_equal before, installed_snapshot
        refute File.exist?(@env.fetch("INSTALL_TEST_LOG"))
        write(file, original)
      end
    end
  end

  def test_source_overrides_fail_before_download_or_installation
    ["https://untrusted.invalid", "file:///tmp/untrusted", ""].each do |base|
      _, stderr, status = run_installer({ "REVDOKU_INSTALL_BASE" => base })
      refute status.success?
      assert_includes stderr, "REVDOKU_INSTALL_BASE is no longer supported"
      assert_empty installed_snapshot
      refute File.exist?(@env.fetch("INSTALL_TEST_LOG"))
    end
  end

  def test_missing_hash_tool_preserves_existing_installation
    seed_existing_installation
    before = installed_snapshot
    %w[sha256sum shasum openssl].each { |name| FileUtils.rm_f(File.join(@commands, name)) }
    _, stderr, status = run_installer
    refute status.success?
    assert_includes stderr, "requires sha256sum, shasum, or openssl"
    assert_equal before, installed_snapshot
    assert_empty Dir.children(@scratch)
  end

  def test_failed_and_interrupted_downloads_preserve_existing_installation
    seed_existing_installation
    before = installed_snapshot
    [nil, "true"].each do |interrupt|
      _, _, status = run_installer({ "INSTALL_TEST_FAIL_PATH" => "skills/revdoku/bin/revdoku", "INSTALL_TEST_INTERRUPT" => interrupt })
      refute status.success?
      assert_equal before, installed_snapshot
      assert_empty Dir.children(@scratch)
    end
  end

  def test_corrupt_jq_is_rejected_before_any_installation
    File.unlink(File.join(@commands, "jq"))
    write(File.join(@remote, "jq"), "corrupt jq")
    seed_existing_installation
    before = installed_snapshot
    _, stderr, status = run_installer
    refute status.success?
    assert_includes stderr, "downloaded jq checksum mismatch"
    assert_equal before, installed_snapshot
    assert_empty Dir.children(@scratch)
  end

  def test_verified_jq_is_downloaded_once_then_reused_from_installation
    File.unlink(File.join(@commands, "jq"))
    bytes = "#!/bin/sh\nexit 0\n"
    write(File.join(@remote, "jq"), bytes)
    # The fixture remains subject to the actual checksum verifier.
    script = File.read(@installer).gsub(/(echo "jq-[^|]+\|)[0-9a-f]{64}/) { "#{$1}#{Digest::SHA256.hexdigest(bytes)}" }
    write(@installer, script)
    2.times do
      _, stderr, status = run_installer
      assert status.success?, stderr
      %w[codex/skills/revdoku/bin/jq claude/skills/revdoku/bin/jq bin/jq].each do |path|
        assert_equal bytes, File.binread(File.join(@target, path))
        assert File.executable?(File.join(@target, path))
      end
    end
    assert_equal 1, File.readlines(@env.fetch("INSTALL_TEST_LOG"), chomp: true).count("jq")
    assert_empty Dir.children(@scratch)
  end

  private

  def write(path, content, mode: 0o644)
    FileUtils.mkdir_p(File.dirname(path))
    File.binwrite(path, content)
    File.chmod(mode, path)
  end

  def run_installer(env = {}, installer: @installer, stdin: false)
    if stdin
      Open3.capture3(@env.merge(env), "/bin/bash", stdin_data: File.read(installer))
    else
      Open3.capture3(@env.merge(env), "/bin/bash", installer)
    end
  end

  def seed_existing_installation
    %w[codex/skills/revdoku/SKILL.md codex/skills/revdoku/bin/revdoku claude/skills/revdoku/bin/revdoku bin/revdoku config/client_version config/credentials].each do |path|
      write(File.join(@target, path), "existing #{path}\n", mode: 0o600)
    end
  end

  def installed_snapshot
    Dir.glob(File.join(@target, "**/*"), File::FNM_DOTMATCH).select { |path| File.file?(path) }
      .to_h { |path| [path, [File.binread(path), File.stat(path).mode & 0o777]] }
  end
end
