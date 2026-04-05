cask "tidaldrift" do
  version "1.4.3"
  sha256 "0127e484c102cf753333ae1e89b230c2f86136a79d65a73beb7c537bed2a9530"

  url "https://github.com/goldberg-consulting/measured.one.tidal-drift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift"
  desc "Menu-bar Mac utility for discovering, connecting to, and streaming between Macs"
  homepage "https://github.com/goldberg-consulting/measured.one.tidal-drift"

  depends_on macos: ">= :ventura"

  app "TidalDrift.app"

  zap trash: [
    "~/Library/Preferences/com.goldbergconsulting.tidaldrift.plist",
    "~/Library/Application Support/TidalDrift",
  ]
end

