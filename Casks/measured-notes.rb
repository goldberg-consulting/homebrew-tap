cask "measured-notes" do
  version "0.1.2"
  sha256 "79b31ed93243acf96fe69cf9af4a3c1b5ea4c262ca531f710c4cc1ecdad7583a"

  url "https://github.com/goldberg-consulting/measured-notes/releases/download/v#{version}/measured-notes-#{version}-arm64.zip"
  name "Measured Notes"
  desc "Local notes with quick capture, Markdown, tables, and checklists"
  homepage "https://github.com/goldberg-consulting/measured-notes"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Measured Notes.app"

  uninstall quit: "one.measured.notes"
end
