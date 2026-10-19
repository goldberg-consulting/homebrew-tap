cask "find-yoshi-it" do
  version "0.1.4"
  sha256 "39aca64787d8bffe1330f2bef779d52a29e544d7c69eeb6da045e4f7dbf1575c"

  url "https://github.com/goldberg-consulting/find-yoshi-it/releases/download/v#{version}/Find-Yoshi-IT-v#{version}-macOS-arm64.zip"
  name "Find Yoshi IT"
  desc "Local document search and app launcher with offline NAS indexing"
  homepage "https://github.com/goldberg-consulting/find-yoshi-it"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

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
