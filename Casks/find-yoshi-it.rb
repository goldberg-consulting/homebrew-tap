cask "find-yoshi-it" do
  version "0.1.3"
  sha256 "cdbe0d89918c057b493ad6b6fee5c7e5767fd00cbd86456a24392d803f9f0d90"

  url "https://github.com/goldberg-consulting/find-yoshi-it/releases/download/v#{version}/Find-Yoshi-IT-v#{version}-macOS-arm64.zip"
  name "Find Yoshi IT"
  desc "Local document search and app launcher with offline NAS indexing"
  homepage "https://github.com/goldberg-consulting/find-yoshi-it"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Find Yoshi IT.app"

  uninstall quit: "local.findanything.mac"

  # Deliberately preserve the expensive index, change journal, and preferences.
  # No zap stanza: uninstalling the app must not discard the library.
  caveats <<~EOS
    This app is ad-hoc signed and not notarized. If macOS blocks the first launch,
    review and approve it in System Settings > Privacy & Security.
    Your existing index in ~/Library/Application Support/FindAnything is retained.
  EOS
end
