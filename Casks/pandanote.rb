cask "pandanote" do
  version "0.3.1"
  sha256 "7af24413ebd1a5b16a45f33ae64dd5099ce091b6327a0475f13ff91b8e209441"

  url "https://github.com/goldberg-consulting/pandanote/releases/download/v#{version}/Pandanote-#{version}.zip"
  name "Pandanote"
  desc "Native Markdown workspace with code variables and Inkwell publishing"
  homepage "https://github.com/goldberg-consulting/pandanote"

  depends_on arch: :arm64
  depends_on macos: :sequoia
  depends_on formula: "node"
  depends_on formula: "pandoc"
  depends_on formula: "pandoc-crossref"

  app "Pandanote.app"

  uninstall quit: "com.goldbergconsulting.pandanote"

  caveats <<~EOS
    PDF publishing also requires a TeX distribution.
    If you do not already have one, install it with:
      brew install --cask mactex-no-gui
  EOS
end
