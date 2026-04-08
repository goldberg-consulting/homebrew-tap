cask "distribute-metal" do
  version "0.2.4"
  sha256 "ada96fc9e74ad0cea06a6b0c78df5bcf91d99ba9c91ac0dc1f56e2cc7ec852ae"

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
