# frozen_string_literal: true

require "digest"
require "fileutils"
require "minitest/autorun"
require "open3"
require "tmpdir"

class StandaloneCliTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__)

  def setup
    @tmp = Dir.mktmpdir("revdoku-standalone-")
    @bin = File.join(@tmp, "bin")
    @destination = File.join(@tmp, "installed")
    FileUtils.mkdir_p([@bin, @destination])
    File.write(File.join(@bin, "curl"), <<~BASH)
      #!/usr/bin/env bash
      set -euo pipefail
      [[ "$*" == *https://github.com/revdoku/revdoku/releases/download/cli-v*/revdoku* ]] || exit 98
      while [[ $# -gt 0 ]]; do
        if [[ "$1" == '-o' ]]; then cp "$FIXTURE_CLI" "$2"; exit; fi
        shift
      done
      exit 99
    BASH
    File.chmod(0o755, File.join(@bin, "curl"))
    @env = { "PATH" => "#{@bin}:#{ENV.fetch('PATH')}", "FIXTURE_CLI" => File.join(ROOT, "cli/revdoku"),
      "REVDOKU_CONFIG_DIR" => File.join(@tmp, "config") }
  end

  def teardown
    FileUtils.remove_entry(@tmp)
  end

  def install
    Open3.capture2e(@env, "bash", File.join(ROOT, "cli/install.sh"), "--dir", @destination)
  end

  def test_installs_verified_executable_without_ai_configuration
    FileUtils.mkdir_p(@env.fetch("REVDOKU_CONFIG_DIR"))
    File.write(File.join(@env.fetch("REVDOKU_CONFIG_DIR"), "client_version"), "0.0.1\n")
    output, status = install
    assert status.success?, output
    assert_equal File.binread(File.join(ROOT, "cli/revdoku")), File.binread(File.join(@destination, "revdoku"))
    version, _, status = Open3.capture3(@env, File.join(@destination, "revdoku"), "--version")
    assert status.success?
    expected = File.read(File.join(ROOT, "cli/install.sh"))[/^VERSION='([^']+)'$/, 1]
    assert_equal expected, version.strip
    assert_equal ["client_version"], Dir.children(@env.fetch("REVDOKU_CONFIG_DIR"))
  end

  def test_checksum_failure_preserves_existing_installation
    File.write(File.join(@destination, "revdoku"), "previous version")
    bad = File.join(@tmp, "bad-cli")
    File.write(bad, "#!/bin/bash\ntouch #{@tmp}/executed\n")
    @env["FIXTURE_CLI"] = bad
    output, status = install
    refute status.success?
    assert_includes output, "checksum mismatch"
    assert_equal "previous version", File.read(File.join(@destination, "revdoku"))
    refute File.exist?(File.join(@tmp, "executed"))
    assert_empty Dir.glob(File.join(@destination, ".revdoku-install.*"))
  end

  def test_refuses_symlink_destination
    elsewhere = File.join(@tmp, "elsewhere")
    File.write(elsewhere, "untouched")
    File.symlink(elsewhere, File.join(@destination, "revdoku"))
    _, status = install
    refute status.success?
    assert_equal "untouched", File.read(elsewhere)
  end

  def test_release_assets_have_correct_checksums
    output_dir = File.join(@tmp, "assets")
    output, status = Open3.capture2e("bash", File.join(ROOT, "cli/package-release.sh"), output_dir)
    assert status.success?, output
    assert_equal %w[LICENSE SHA256SUMS install-cli.sh revdoku], Dir.children(output_dir).sort
    File.readlines(File.join(output_dir, "SHA256SUMS")).each do |line|
      digest, name = line.split
      assert_equal digest, Digest::SHA256.file(File.join(output_dir, name)).hexdigest
    end
  end
end
