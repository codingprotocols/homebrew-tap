# Coding Protocols Homebrew Tap

Homebrew formulae and casks for [Coding Protocols](https://github.com/codingprotocols) tools.

## Install

```sh
# Podscape — Kubernetes management desktop client (macOS)
brew install --cask codingprotocols/tap/podscape

# podscape-mcp — MCP server exposing your cluster to AI assistants (macOS + Linux)
brew install codingprotocols/tap/podscape-mcp
```

`brew tap codingprotocols/tap` first is optional — the fully qualified name taps automatically.

## Contents

| Name | Type | Platforms |
|------|------|-----------|
| `podscape` | Cask | macOS 12+ (Apple Silicon and Intel) |
| `podscape-mcp` | Formula | macOS and Linux, arm64 and x86_64 |

## Upgrades

The Podscape desktop app has a built-in updater, so the cask is marked
`auto_updates true` and **`brew upgrade` deliberately leaves it alone** — the app
keeps itself current. To have Homebrew drive the upgrade instead:

```sh
brew upgrade --cask --greedy podscape
```

`podscape-mcp` is a plain CLI with no self-updater, so `brew upgrade` handles it
normally.

## These files are generated

Do not edit `Casks/podscape.rb` or `Formula/podscape-mcp.rb` by hand — they are
rendered from templates in the
[podscape](https://github.com/codingprotocols/podscape) repository
(`packaging/homebrew/`) and pushed here automatically by its release workflow on
every `v*` tag. Hand edits are overwritten by the next release.

To change a cask or formula, edit the template in `podscape`.

## Issues

Report problems at
[codingprotocols/podscape/issues](https://github.com/codingprotocols/podscape/issues).
