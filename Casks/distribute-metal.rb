cask "distribute-metal" do
  version "0.2.0"
  sha256 "2dd86a81e23f64be3c0777025fce2621e2bb81315369febb8fcbad8b3b8f37e4"

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
