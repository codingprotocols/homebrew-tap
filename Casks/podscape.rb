cask "podscape" do
  arch arm: "-arm64", intel: ""

  version "4.0.4"
  sha256 arm:   "d1826f7aa056b1f83b2ffaf423f9bd445ab2ef8b740a01a18978bb52e588c0d8",
         intel: "e213d95c7c86c3a10868ae5af7b623bb046f63555d5926eae56ca79ff5369a2b"

  url "https://github.com/codingprotocols/podscape/releases/download/v#{version}/Podscape-#{version}#{arch}.dmg",
      verified: "github.com/codingprotocols/podscape/"
  name "Podscape"
  desc "Kubernetes management desktop client"
  homepage "https://github.com/codingprotocols/podscape"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Podscape ships an in-app electron-updater, so `brew upgrade` intentionally
  # leaves it alone. Users who want Homebrew to drive upgrades: `brew upgrade --greedy`.
  auto_updates true

  # Electron 41's LSMinimumSystemVersion is 12.0. The bare symbol means
  # "monterey or newer"; the ">= :monterey" string form is deprecated.
  depends_on macos: :monterey

  app "Podscape.app"

  zap trash: [
    "~/.podscape",
    "~/Library/Application Support/Podscape",
    "~/Library/Caches/com.codingprotocols.podscape",
    "~/Library/Logs/Podscape",
    "~/Library/Preferences/com.codingprotocols.podscape.plist",
    "~/Library/Saved Application State/com.codingprotocols.podscape.savedState",
  ]
end
