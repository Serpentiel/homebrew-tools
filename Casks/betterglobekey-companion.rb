cask "betterglobekey-companion" do
  version "4.3.2"
  sha256 "449919040692b047bff5b3e573ccca540e87d9712921d56ce806156187b48b13"

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

  depends_on formula: "betterglobekey"
  depends_on macos: :ventura

  app "betterglobekey-companion.app"

  zap trash: [
    "~/Library/Application Support/betterglobekey-companion",
    "~/Library/Application Support/com.serpentiel.betterglobekey.companion",
    "~/Library/Caches/com.serpentiel.betterglobekey.companion",
    "~/Library/Preferences/com.serpentiel.betterglobekey.companion.plist",
    "~/Library/Saved Application State/com.serpentiel.betterglobekey.companion.savedState",
    "~/Library/WebKit/com.serpentiel.betterglobekey.companion",
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
