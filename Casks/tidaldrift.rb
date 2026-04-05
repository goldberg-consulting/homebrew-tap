cask "tidaldrift" do
  version "1.4.5"
  sha256 "b58730e50dc354a23c5b8001fb766bcec6b45b4cb34dcd7364c896fa5545b350"

  url "https://github.com/goldberg-consulting/measured.one.tidal-drift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift"
  desc "Menu-bar Mac utility for discovering, connecting to, and streaming between Macs"
  homepage "https://github.com/goldberg-consulting/measured.one.tidal-drift"

  depends_on macos: ">= :ventura"

  app "TidalDrift.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TidalDrift.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.goldbergconsulting.tidaldrift.plist",
    "~/Library/Application Support/TidalDrift",
  ]
end

