cask "podscape" do
  arch arm: "-arm64", intel: ""

  version "4.0.5"
  sha256 arm:   "01226bf325b02bed35acf13c7c6ed305d0e7182960e336fe3649d7ab055a92e7",
         intel: "7dcfb4f175a8fc4e7c2d7fca0c7892783e474a3b7c8de29347ded9bb7d56782e"

  url "https://github.com/codingprotocols/podscape/releases/download/v#{version}/Podscape-#{version}#{arch}.dmg"
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
