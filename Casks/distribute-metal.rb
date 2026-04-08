cask "distribute-metal" do
  version "0.2.1"
  sha256 "0614ebb0d507aa457bf4138738286a8afc5562c0e9d376087adf2d1e789cc8e6"

  url "https://github.com/goldberg-consulting/measured.one.distribute-metal/releases/download/v#{version}/DistributeMetal-#{version}.dmg"
  name "measured.one.distribute-metal"
  desc "macOS menu bar app by measured.one for distributed PyTorch training on Apple Silicon using Metal and MCCL"
  homepage "https://github.com/goldberg-consulting/measured.one.distribute-metal"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "DistributeMetal.app"

  zap trash: [
    "~/Library/Application Support/DistributeMetal",
    "~/.config/distribute-metal",
  ]
end
