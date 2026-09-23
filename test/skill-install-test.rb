#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class RevdokuSkillInstallTest < Minitest::Test
  CLIENT_ROOT = File.expand_path("..", __dir__)
  PUBLIC_PACKAGE = File.directory?(File.join(CLIENT_ROOT, "skills/revdoku"))
  SKILL_ROOT = File.join(CLIENT_ROOT, PUBLIC_PACKAGE ? "skills/revdoku" : "skill")
  WRAPPER = File.join(SKILL_ROOT, "scripts/revdoku.sh")
  CLI = File.join(CLIENT_ROOT, PUBLIC_PACKAGE ? "skills/revdoku/bin/revdoku" : "bin/revdoku")

  def setup
    @tmp = Dir.mktmpdir("revdoku-skill-test-")
    @commands = File.join(@tmp, "commands")
    FileUtils.mkdir_p(@commands)
    %w[sh bash dirname tr uname mkdir mktemp sha256sum shasum awk mv chmod rm cp openssl base64 find cat].each do |name|
      path = ENV.fetch("PATH").split(File::PATH_SEPARATOR).map { |dir| File.join(dir, name) }
        .find { |candidate| File.executable?(candidate) && !File.directory?(candidate) }
      File.symlink(path, File.join(@commands, name)) if path
    end
    @env = {
      "PATH" => @commands,
      "REVDOKU_CREDENTIALS" => File.join(@tmp, "credentials"),
      "REVDOKU_CLIENT_VERSION_FILE" => File.join(@tmp, "client_version"),
      "REVDOKU_INSTALL_BASE" => "https://untrusted.invalid",
      "SKILL_TEST_DOWNLOADS" => File.join(@tmp, "downloads"),
      "SKILL_TEST_DOWNLOAD" => File.join(@tmp, "download"),
      "SKILL_TEST_EXIT" => "0",
      "TMPDIR" => @tmp
    }
    executable(File.join(@commands, "curl"), <<~SH)
      #!/bin/sh
      printf '%s\n' "$*" >> "$SKILL_TEST_DOWNLOADS"
      while [ "$#" -gt 0 ]; do
        if [ "$1" = '-o' ]; then
          shift
          cp "$SKILL_TEST_DOWNLOAD" "$1"
          exit 0
        fi
        shift
      done
      exit 91
    SH
    executable(@env.fetch("SKILL_TEST_DOWNLOAD"), "#!/bin/sh\nprintf 'fixture jq\\n'\n")
  end

  def teardown
    FileUtils.remove_entry(@tmp)
  end

  def test_source_and_standalone_layouts_preserve_arguments_and_exit_status
    system_jq
    %w[source standalone].each do |layout|
      wrapper, = fixture(layout: layout)
      args = ["p", "folder with spaces", "--draft", "literal;$value", ""]
      stdout, stderr, status = run_wrapper(wrapper, *args, env: { "SKILL_TEST_EXIT" => "23" })
      assert_equal 23, status.exitstatus, stderr
      assert_equal args, stdout.split("\0", -1)[0...-1]
      assert_no_download
    end
  end

  def test_symlink_install_runs_the_bundled_cli
    system_jq
    wrapper, skill = fixture
    link = File.join(@tmp, "agent skills", "revdoku")
    FileUtils.mkdir_p(File.dirname(link))
    File.symlink(skill, link)
    stdout, stderr, status = run_wrapper(File.join(link, "scripts/revdoku.sh"), "--help")
    assert status.success?, stderr
    assert_equal "--help\0", stdout
    assert_no_download
  end

  def test_missing_cli_fails_before_downloading_anything
    wrapper, skill = fixture(cli: false)
    stdout, stderr, status = run_wrapper(wrapper, "p", "--draft")
    refute status.success?
    assert_empty stdout
    assert_includes stderr, "bundled Revdoku CLI is missing or not executable"
    refute File.exist?(File.join(skill, "bin/revdoku"))
    assert_no_download
  end

  def test_nonexecutable_cli_is_not_silently_replaced
    wrapper, skill = fixture
    path = File.join(skill, "bin/revdoku")
    original = File.binread(path)
    File.chmod(0o644, path)
    _, stderr, status = run_wrapper(wrapper, "--help")
    refute status.success?
    assert_includes stderr, "not executable"
    assert_equal original, File.binread(path)
    refute File.executable?(path)
    assert_no_download
  end

  def test_bundled_jq_works_without_system_jq
    wrapper, skill = fixture
    FileUtils.cp(@env.fetch("SKILL_TEST_DOWNLOAD"), File.join(skill, "bin/jq"))
    _, stderr, status = run_wrapper(wrapper, "--help")
    assert status.success?, stderr
    assert_no_download
  end

  def test_corrupt_jq_download_never_reaches_cli_execution
    wrapper, skill = fixture
    stdout, stderr, status = run_wrapper(wrapper, "--help")
    refute status.success?
    assert_empty stdout
    assert_includes stderr, "downloaded jq checksum mismatch"
    refute File.exist?(File.join(skill, "bin/jq"))
    assert_includes File.read(@env.fetch("SKILL_TEST_DOWNLOADS")), "https://github.com/jqlang/jq/releases/download/jq-1.8.1/"
  end

  def test_verified_jq_download_is_installed_and_reused_on_every_supported_platform
    %w[Darwin/arm64 Darwin/x86_64 Linux/x86_64 Linux/aarch64 Linux/arm64].each do |platform|
      os, arch = platform.split("/")
      executable(File.join(@commands, "uname"), "#!/bin/sh\ncase \"$1\" in -s) echo #{os} ;; -m) echo #{arch} ;; esac\n")
      wrapper, skill = fixture(layout: platform.tr("/", "-"))
      # Pin the harmless fixture bytes in the test copy; use the real hash verifier.
      fixture_hash = Digest::SHA256.file(@env.fetch("SKILL_TEST_DOWNLOAD")).hexdigest
      File.write(wrapper, File.read(wrapper).gsub(/expected=[0-9a-f]{64}/, "expected=#{fixture_hash}"))
      _, stderr, status = run_wrapper(wrapper, "--help")
      assert status.success?, stderr
      assert File.executable?(File.join(skill, "bin/jq"))
      downloads = File.read(@env.fetch("SKILL_TEST_DOWNLOADS"))
      _, stderr, status = run_wrapper(wrapper, "--help")
      assert status.success?, stderr
      assert_equal downloads, File.read(@env.fetch("SKILL_TEST_DOWNLOADS"))
    end
  end

  def test_real_cli_runs_from_source_and_each_shipped_skill
    system_jq
    skills = [SKILL_ROOT]
    skills << File.join(CLIENT_ROOT, "plugins/revdoku/skills/revdoku") if PUBLIC_PACKAGE
    skills.each do |skill|
      wrapper = File.join(skill, "scripts/revdoku.sh")
      assert File.executable?(wrapper), "missing executable wrapper: #{wrapper}"
      stdout, stderr, status = run_wrapper(wrapper, "--help")
      assert status.success?, stderr
      assert_includes stdout, "upload [PATH]"
      refute_includes stdout, "--site-mode"
    end
    assert_no_download
  end

  def test_shell_installer_produces_a_complete_runnable_skill
    system_jq
    install_root = File.join(@tmp, "cursor")
    stdout, stderr, status = Open3.capture3(@env.merge(
      "REVDOKU_INSTALL_BASE" => nil,
      "REVDOKU_AGENT" => "cursor", "CURSOR_HOME" => install_root,
      "REVDOKU_BIN_DIR" => File.join(@tmp, "user-bin"),
      "REVDOKU_CONFIG_DIR" => File.join(@tmp, "config"),
      "REVDOKU_CLIENT_VERSION" => "0.0.0"
    ), "/bin/bash", File.join(CLIENT_ROOT, "install.sh"))
    assert status.success?, "#{stderr}\n#{stdout}"
    skill = File.join(install_root, "skills/revdoku")
    assert_equal File.binread(CLI), File.binread(File.join(skill, "bin/revdoku"))
    expected_version = File.read(File.join(CLIENT_ROOT, PUBLIC_PACKAGE ? "VERSION" : "../../../VERSION")).strip
    assert_equal expected_version, File.read(File.join(@tmp, "config/client_version")).strip
    stdout, stderr, status = run_wrapper(File.join(skill, "scripts/revdoku.sh"), "--help")
    assert status.success?, stderr
    assert_includes stdout, "upload [PATH]"
      refute_includes stdout, "--site-mode"
    assert_no_download
  end

  private

  def executable(path, content)
    # Replace a fixture command without writing through a system-tool symlink.
    File.unlink(path) if File.symlink?(path)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
    File.chmod(0o755, path)
  end

  def system_jq
    FileUtils.cp(@env.fetch("SKILL_TEST_DOWNLOAD"), File.join(@commands, "jq"))
  end

  def fixture(layout: "standalone", cli: true)
    package = File.join(@tmp, layout)
    skill = File.join(package, "skill")
    wrapper = File.join(skill, "scripts/revdoku.sh")
    FileUtils.mkdir_p(File.dirname(wrapper))
    FileUtils.cp(WRAPPER, wrapper)
    cli_path = File.join(layout == "source" ? package : skill, "bin/revdoku")
    executable(cli_path, "#!/bin/sh\nprintf '%s\\0' \"$@\"\nexit \"$SKILL_TEST_EXIT\"\n") if cli
    [wrapper, skill]
  end

  def run_wrapper(path, *args, env: {})
    Open3.capture3(@env.merge(env), path, *args)
  end

  def assert_no_download
    refute File.exist?(@env.fetch("SKILL_TEST_DOWNLOADS")), "wrapper attempted an unexpected download"
  end
end
