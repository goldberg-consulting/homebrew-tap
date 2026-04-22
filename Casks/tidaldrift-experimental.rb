cask "tidaldrift-experimental" do
  version "1.5.0-metal.1"
  sha256 "3f0e0babab9c2def7a6837851454adb958fdd0af38322b295ef7208688ef11da"

  url "https://github.com/goldberg-consulting/measured.one.tidaldrift/releases/download/v#{version}/TidalDrift-#{version}.dmg"
  name "TidalDrift (Experimental — Metal Streaming)"
  desc "Pre-release TidalDrift with Metal-accelerated full-desktop screen streaming"
  homepage "https://github.com/goldberg-consulting/measured.one.tidaldrift"

  livecheck do
    skip "Experimental channel tracks GitHub pre-releases; bumped by the release.yml workflow"
  end

  conflicts_with cask: "tidaldrift"

  depends_on macos: ">= :ventura"

  app "TidalDrift.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TidalDrift.app"]
  end

  caveats <<~EOS
    Experimental Metal-streaming build. First launch will request Screen
    Recording and Accessibility permission; grant both to host streams
    and to accept remote input from clients. Per-app streaming is not
    exposed in this build — full-desktop only.

    Conflicts with the stable `tidaldrift` cask. To switch back:
      brew uninstall --cask tidaldrift-experimental
      brew install --cask tidaldrift
  EOS

  zap trash: [
    "~/Library/Preferences/com.goldbergconsulting.tidaldrift.plist",
    "~/Library/Application Support/TidalDrift",
    "~/Library/Caches/com.goldbergconsulting.tidaldrift",
  ]
end
