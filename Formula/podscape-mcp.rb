class PodscapeMcp < Formula
  desc "MCP server exposing Kubernetes clusters as tools for AI assistants"
  homepage "https://github.com/codingprotocols/podscape"
  version "4.0.4"
  license "Apache-2.0"

  livecheck do
    url "https://github.com/codingprotocols/podscape/releases/latest"
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.4/podscape-mcp-darwin-arm64"
      sha256 "49f58e03d552d270b2b6c41d6599af2ce05912a8701c515070b2f91b5c90555f"
    end
    on_intel do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.4/podscape-mcp-darwin-amd64"
      sha256 "35ea0225ad69b43b229a4fd5ec85e0522d98ff8656f67b48956040dfc66a67e5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.4/podscape-mcp-linux-arm64"
      sha256 "136633dd7af48672c9e759ab9b64cfca5fd2c72afc5e3bdaa16e73a82dbd1dab"
    end
    on_intel do
      url "https://github.com/codingprotocols/podscape/releases/download/v4.0.4/podscape-mcp-linux-amd64"
      sha256 "834b5bebf33b8cab33223c50397317f67e594bbe494f5d0dc4b1d5e2228417f1"
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
