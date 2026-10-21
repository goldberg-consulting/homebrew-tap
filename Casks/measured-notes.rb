cask "measured-notes" do
  version "0.1.3"
  sha256 "fd8a365e8b809a5521ae3737526a37a30b7b02015b52ef865b3af32af09a8044"

  url "https://github.com/goldberg-consulting/measured-notes/releases/download/v#{version}/measured-notes-#{version}-arm64.zip"
  name "Measured Notes"
  desc "Local notes with quick capture, Markdown, tables, and checklists"
  homepage "https://github.com/goldberg-consulting/measured-notes"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Measured Notes.app"

  uninstall quit: "one.measured.notes"
end
