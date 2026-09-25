cask "pint-app" do
  version "1.5.0"
  sha256 "50a5d252ac3dc6941fccca98b01a1daff3f0dc586b8c33934c45f476411e689f"

  url "https://github.com/codingprotocols/Pint/releases/download/v#{version}/Pint-#{version}.dmg"
  # Token is "pint-app", not "pint": homebrew/core already ships a
  # "pint" formula (Cloudflare's Prometheus rule linter), and a clashing
  # token fails `brew audit --strict` and makes `brew install pint`
  # ambiguous. The app itself is still named Pint.
  name "Pint"
  desc "GUI for managing Homebrew packages"
  homepage "https://github.com/codingprotocols/Pint"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Pint ships a Sparkle updater, so `brew upgrade` intentionally leaves it
  # alone. Users who want Homebrew to drive upgrades: `brew upgrade --greedy`.
  auto_updates true
  # The app's LSMinimumSystemVersion is 26.2. Cask granularity is the major
  # version, so :tahoe is the closest expressible constraint — a 26.0/26.1 user
  # can install but not launch.
  depends_on macos: :tahoe

  app "Pint.app"

  zap trash: [
    "~/Library/Caches/com.codingprotocols.Pint",
    "~/Library/HTTPStorages/com.codingprotocols.Pint",
    "~/Library/Preferences/com.codingprotocols.Pint.plist",
    "~/Library/Saved Application State/com.codingprotocols.Pint.savedState",
  ]
end
