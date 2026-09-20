class PodscapeMcp < Formula
  desc "MCP server exposing Kubernetes clusters as tools for AI assistants"
  homepage "https://github.com/codingprotocols/podscape"
  license "Apache-2.0"
  # No `version` stanza: Homebrew scans the version from the `v<x.y.z>` path
  # segment in the URLs below, and `brew audit` rejects declaring it a second
  # time. Podscape's release workflow rewrites those URLs and checksums, so
  # nothing here names a specific version.

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.5/podscape-mcp-darwin-arm64"
      sha256 "dfffe12182550dc2c8c7e133ce73cde62358c18f88df677fa0c41514bdca835a"
    end
    on_intel do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.5/podscape-mcp-darwin-amd64"
      sha256 "6456591f6225f2f414953b1461dfa5053e7db8758f48d5d9ee4d4764e52e16d9"
    end
  end

  # Linux/arm64 is deliberately unsupported: podscape's release workflow builds
  # linux-amd64 only. v4.0.4 shipped a linux-arm64 binary from an earlier
  # workflow, so an on_arm block worked by accident — bumping this formula to
  # any newer release would have pointed arm64 users at a 404. Restore this
  # block if and when the release workflow builds that target again.
  on_linux do
    on_intel do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.5/podscape-mcp-linux-amd64"
      sha256 "09c362c0a88e4c7e794f830840800bdf030f2f8096019950255855b52881496f"
    end
  end

  def install
    # Each platform downloads exactly one bare (non-archive) binary into the
    # staging dir, so this glob always resolves to that single file.
    bin.install Dir["podscape-mcp-*"].first => "podscape-mcp"
  end

  def caveats
    <<~EOS
      Register the server with your MCP client, for example:

        {
          "mcpServers": {
            "podscape": {
              "command": "#{opt_bin}/podscape-mcp"
            }
          }
        }
    EOS
  end

  test do
    # Asserts on --help rather than --version: releases up to and including
    # v4.0.4 do not register a --version flag.
    assert_match "Podscape MCP Server", shell_output("#{bin}/podscape-mcp --help")
  end
end
