cask "measured-notes" do
  version "0.1.1"
  sha256 "ab8894bf6b3896507c9039bce3cb5f3c7b3067e28ef0e1a5953fb03ad520e4ab"

  url "https://github.com/goldberg-consulting/measured-notes/releases/download/v#{version}/measured-notes-#{version}-arm64.zip"
  name "Measured Notes"
  desc "Local notes with quick capture, Markdown, tables, and checklists"
  homepage "https://github.com/goldberg-consulting/measured-notes"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Measured Notes.app"

  uninstall quit: "one.measured.notes"
end
