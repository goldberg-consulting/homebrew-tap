cask "tidaldrift" do
  version "1.5.11"
  sha256 "f5c517375fa46bf4384b4703f32b172c5a4fbce77bca0d8aa1604f255ae169c1"

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

  # Strip Gatekeeper quarantine. Required while notarization is pending
  # agreement renewal for team 97UY84BV45; the DMG is Developer ID signed
  # but not yet notarized. Re-notarization will be restored in a follow-up.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TidalDrift.app"]
  end

  zap trash: [
    "~/Library/Application Support/TidalDrift",
    "~/Library/Preferences/com.goldbergconsulting.tidaldrift.plist",
  ]
end
