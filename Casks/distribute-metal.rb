cask "distribute-metal" do
  version "0.1.1"
  sha256 "2138325be2372f541143399822b3152796fdbe0e8f051d8bbf979faf7d89f1fd"

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
