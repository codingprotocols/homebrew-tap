# Coding Protocols Homebrew Tap

Homebrew formulae and casks for [Coding Protocols](https://github.com/codingprotocols) tools.

## Install

```sh
# Pint — Homebrew package manager GUI (macOS)
brew install --cask codingprotocols/tap/pint-app

# Podscape — Kubernetes management desktop client (macOS)
brew install --cask codingprotocols/tap/podscape

# podscape-mcp — MCP server exposing your cluster to AI assistants (macOS + Linux)
brew install codingprotocols/tap/podscape-mcp
```

`brew tap codingprotocols/tap` first is optional — the fully qualified name taps automatically.

## Contents

| Name | Type | Platforms |
|------|------|-----------|
| `pint-app` | Cask | macOS 26+ (Apple Silicon and Intel) |
| `podscape` | Cask | macOS 12+ (Apple Silicon and Intel) |
| `podscape-mcp` | Formula | macOS and Linux, arm64 and x86_64 |

## Upgrades

Both desktop apps have built-in updaters, so their casks are marked
`auto_updates true` — the apps keep themselves current whether or not Homebrew
is involved.

That flag does **not** reliably stop `brew upgrade` from also upgrading them.
Observed with `pint-app` on Homebrew 6.0.16: it appears in plain
`brew outdated --cask` and a bare `brew upgrade --cask` upgrades it, no
`--greedy` required — even though other `auto_updates` casks on the same machine
were skipped. Treat `brew upgrade` as *able* to upgrade these casks; it lands on
the same version the in-app updater would.

`--greedy` remains the way to force casks Homebrew would otherwise skip:

```sh
brew upgrade --cask --greedy pint-app
brew upgrade --cask --greedy podscape
```

`podscape-mcp` is a plain CLI with no self-updater, so `brew upgrade` handles it
normally.

## Maintenance

`Casks/podscape.rb` and `Formula/podscape-mcp.rb` are **generated** — they are
rendered from templates in the
[podscape](https://github.com/codingprotocols/podscape) repository and pushed
here automatically on every `v*` tag. Hand edits are overwritten by the next
release; change the template in `podscape` instead.

`Casks/pint-app.rb` is **maintained by hand**. Each Pint release needs `version` and
`sha256` updated here:

```sh
V=1.4.4   # the new version
curl -sL -o /tmp/Pint-$V.dmg \
  "https://github.com/codingprotocols/Pint/releases/download/v$V/Pint-$V.dmg"
shasum -a 256 /tmp/Pint-$V.dmg
```

CI on this repo audits and installs every cask on each push, so a wrong checksum
or URL is caught before it reaches users.

## Issues

- Pint — [codingprotocols/Pint/issues](https://github.com/codingprotocols/Pint/issues)
- Podscape and podscape-mcp — [codingprotocols/podscape/issues](https://github.com/codingprotocols/podscape/issues)
