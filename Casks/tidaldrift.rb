cask "tidaldrift" do
  version "1.5.0"
  sha256 "9013111239140609224271035228696b3d935ec02b8c3ad5c41f1b40647e3125"

  url "https://github.com/goldberg-consulting/measured.one.tidaldrift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift"
  desc "Menu-bar Mac utility for discovering, connecting to, and streaming between Macs"
  homepage "https://github.com/goldberg-consulting/measured.one.tidaldrift"

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

