cask "pint-app" do
  version "1.4.3"
  sha256 "9f0393539e565a913f2d045023a23e09c7c1b5548944ab26e3a0fb4d80cec471"

  url "https://github.com/codingprotocols/Pint/releases/download/v#{version}/Pint-#{version}.dmg",
      verified: "github.com/codingprotocols/Pint/"
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
