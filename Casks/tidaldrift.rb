cask "tidaldrift" do
  version "1.6.29"
  sha256 "6abef1d355cd80d13b4d5f6b5bfefb286a8995d5a3a49322ed97b434e19a3d89"

  url "https://github.com/goldberg-consulting/measured.one.tidaldrift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift"
  desc "Menu-bar utility for discovering and connecting to local computers"
  homepage "https://github.com/goldberg-consulting/measured.one.tidaldrift"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "TidalDrift.app"

  # Strip the Gatekeeper quarantine attribute so the freshly downloaded app
  # launches without an "unidentified developer" block. The DMG is Developer ID
  # signed and notarized, so this is a belt-and-suspenders step.
  #
  # We deliberately do NOT run `tccutil reset` here. The app is signed with a
  # stable bundle ID and Developer ID, so macOS preserves Screen Recording,
  # Accessibility, and Input Monitoring grants across upgrades. Resetting on
  # every upgrade wiped those permissions and silently broke hosting/control
  # (e.g. LocalCast capture and remote input) until the user re-granted them.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TidalDrift.app"]
  end

  uninstall quit: "com.goldbergconsulting.tidaldrift"

  zap trash: [
    "~/Library/Application Support/TidalDrift",
    "~/Library/Preferences/com.goldbergconsulting.tidaldrift.plist",
  ]
end
