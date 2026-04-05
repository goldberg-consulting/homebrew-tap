cask "distribute-metal" do
  version "0.1.0"
  sha256 "4c8152d2c92752535c0852a1f5f44177b628d3be9c4b176ae61199543ab6d23c"

  url "https://github.com/goldberg-consulting/distribute-metal/releases/download/v#{version}/DistributeMetal-#{version}.dmg"
  name "DistributeMetal"
  desc "macOS menu bar app for distributed PyTorch training on Apple Silicon using Metal and MCCL"
  homepage "https://github.com/goldberg-consulting/distribute-metal"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "DistributeMetal.app"

  zap trash: [
    "~/Library/Application Support/DistributeMetal",
    "~/.config/distribute-metal",
  ]
end
