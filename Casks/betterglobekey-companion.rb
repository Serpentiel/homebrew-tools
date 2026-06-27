cask "betterglobekey-companion" do
  version "4.0.0"
  sha256 "REPLACE_WITH_COMPANION_ZIP_SHA256"

  url "https://github.com/Serpentiel/betterglobekey/releases/download/v#{version}/betterglobekey-companion-#{version}-universal.zip",
      verified: "github.com/Serpentiel/betterglobekey/"
  name "betterglobekey companion"
  desc "Graphical configuration editor for betterglobekey"
  homepage "https://github.com/Serpentiel/betterglobekey"

  # The companion ships prebuilt with each release; bump the version and checksum
  # to the release's universal artifact on every version bump.
  livecheck do
    url "https://github.com/Serpentiel/betterglobekey/releases/latest"
    strategy :github_latest
  end

  depends_on formula: "serpentiel/tools/betterglobekey"
  depends_on macos: :big_sur

  app "betterglobekey-companion.app"

  zap trash: [
    "~/Library/Application Support/betterglobekey-companion",
    "~/Library/Preferences/com.serpentiel.betterglobekey.companion.plist",
    "~/Library/Saved Application State/com.serpentiel.betterglobekey.companion.savedState",
  ]

  caveats <<~EOS
    The companion edits the running betterglobekey service's configuration, so
    start the service first:
      brew services start betterglobekey
  EOS
end
