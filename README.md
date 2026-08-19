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
| `podscape-mcp` | Formula | macOS (arm64, x86_64), Linux (x86_64) |

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

Both casks are bumped by automation in the app's own repository. On every `v*`
tag, that repo's release workflow rewrites `version` and `sha256` here and
**opens a pull request** — it never pushes to `main` directly, so the CI below
always runs before a change reaches users. Review and merge the PR to publish.

| File | Bumped by | Notes |
|------|-----------|-------|
| `Casks/pint-app.rb` | [Pint](https://github.com/codingprotocols/Pint) release workflow | checksum is the post-staple hash computed during notarization |
| `Casks/podscape.rb` | [podscape](https://github.com/codingprotocols/podscape) release workflow | checksums come from GitHub's per-asset digests |
| `Formula/podscape-mcp.rb` | **nobody — hand-maintained** | see below |

There are no templates: the automation edits these files in place, so hand edits
are preserved rather than overwritten.

`Formula/podscape-mcp.rb` is excluded from automation and needs a manual
checksum refresh on each release.

It previously carried a Linux `on_arm` block pointing at
`podscape-mcp-linux-arm64`, a binary podscape's release workflow no longer
builds — v4.0.4 has that asset only because an earlier workflow produced it, so
the block worked by accident and would have 404'd on the next version bump. That
block is now removed: **Linux/arm64 is unsupported**. Restore it if the release
workflow starts building that target again.

To refresh a checksum by hand, GitHub publishes a digest per release asset:

```sh
gh api repos/codingprotocols/podscape/releases/tags/v4.0.4 \
  --jq '.assets[] | "\(.name)  \(.digest)"'
```

CI on this repo audits and installs every cask on each push and pull request, so
a wrong checksum or URL is caught before it reaches users.

## Issues

- Pint — [codingprotocols/Pint/issues](https://github.com/codingprotocols/Pint/issues)
- Podscape and podscape-mcp — [codingprotocols/podscape/issues](https://github.com/codingprotocols/podscape/issues)
