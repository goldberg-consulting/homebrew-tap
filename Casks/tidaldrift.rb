cask "tidaldrift" do
  version "1.4.6"
  sha256 "163f4dcb6bbde5ac83d3d897bc02fa5ddeed7c2c404518cba9d2afd0c4cfbfe4"

  url "https://github.com/goldberg-consulting/measured.one-tidaldrift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift"
  desc "Menu-bar Mac utility for discovering, connecting to, and streaming between Macs"
  homepage "https://github.com/goldberg-consulting/measured.one-tidaldrift"

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

