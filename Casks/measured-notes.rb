cask "measured-notes" do
  version "0.1.7"
  sha256 "3d469d4f377e6a0876d6ec54d5f51355a57b50dcf7a13dcded9d2005aa07accd"

  url "https://github.com/goldberg-consulting/measured-notes/releases/download/v#{version}/measured-notes-#{version}-arm64.zip"
  name "Measured Notes"
  desc "Local notes with quick capture, Markdown, tables, and checklists"
  homepage "https://github.com/goldberg-consulting/measured-notes"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Measured Notes.app"

  uninstall quit: "one.measured.notes"
end
