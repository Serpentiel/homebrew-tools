cask "betterglobekey-companion" do
  version "4.0.0"
  # Placeholder checksum; the release bump automation fills in the real value.
  sha256 "137c6e43ace784377965c583a4e24efecbd3e4ecf2ecfe3d3aebd2b412583df9"

  url "https://github.com/Serpentiel/betterglobekey/releases/download/v#{version}/betterglobekey-companion-#{version}-universal.zip"
  name "betterglobekey-companion"
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

    The app is not notarized. If Gatekeeper blocks the first launch, clear the
    quarantine attribute and reopen it:
      xattr -dr com.apple.quarantine /Applications/betterglobekey-companion.app
  EOS
end
