cask "measured-notes" do
  version "0.1.6"
  sha256 "82ecd7d0cc07bba6f339b565c002d449cee69ab4f3e5e160d4f1f11c1b977141"

  url "https://github.com/goldberg-consulting/measured-notes/releases/download/v#{version}/measured-notes-#{version}-arm64.zip"
  name "Measured Notes"
  desc "Local notes with quick capture, Markdown, tables, and checklists"
  homepage "https://github.com/goldberg-consulting/measured-notes"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Measured Notes.app"

  uninstall quit: "one.measured.notes"
end
