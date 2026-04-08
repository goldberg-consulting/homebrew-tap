cask "measured-one-agents-rules" do
  version "0.2.1"
  sha256 "9e89c2bcdb5011675dc783fb69f87bcf48e4be9ba8fa1cd1f2f76c224533cbb7"

  url "https://github.com/goldberg-consulting/measured.one.agents-rules/releases/download/v#{version}/measured-one-agents-rules-#{version}.vsix"
  name "measured.one Agents & Rules"
  container type: :naked
  desc "Cursor extension that installs shared agents, rules, and skills into any workspace"
  homepage "https://github.com/goldberg-consulting/measured.one.agents-rules"

  depends_on formula: "goldberg-consulting/tap/measured-one-agents-rules"

  artifact "measured-one-agents-rules-#{version}.vsix", target: "#{HOMEBREW_PREFIX}/share/measured-one-agents-rules/measured-one-agents-rules-#{version}.vsix"

  postflight do
    cursor_paths = ["/opt/homebrew/bin/cursor", "/usr/local/bin/cursor", "#{Dir.home}/.local/bin/cursor"]
    code_paths = ["/opt/homebrew/bin/code", "/usr/local/bin/code"]
    editor = (cursor_paths.find { |p| File.exist?(p) }) || (code_paths.find { |p| File.exist?(p) })

    if editor
      system_command editor,
                     args: ["--install-extension", "#{staged_path}/measured-one-agents-rules-#{version}.vsix", "--force"],
                     print_stderr: true
    else
      ohai "Neither cursor nor code CLI found."
      ohai "Install manually: Cmd+Shift+P > Extensions: Install from VSIX > #{HOMEBREW_PREFIX}/share/measured-one-agents-rules/measured-one-agents-rules-#{version}.vsix"
    end
  end

  uninstall_postflight do
    cursor_paths = ["/opt/homebrew/bin/cursor", "/usr/local/bin/cursor", "#{Dir.home}/.local/bin/cursor"]
    code_paths = ["/opt/homebrew/bin/code", "/usr/local/bin/code"]
    editor = (cursor_paths.find { |p| File.exist?(p) }) || (code_paths.find { |p| File.exist?(p) })

    if editor
      system_command editor,
                     args: ["--uninstall-extension", "measured-one.cursor-agents-installer"],
                     print_stderr: true
    end
  end

  caveats <<~EOS
    measured.one Agents & Rules extension has been installed in Cursor/VS Code.

    CLI tools are also available:
      measured-one-agents-rules-install /path/to/project
      measured-one-agents-rules-install-all

    To complete setup:
      1. Reload Cursor (Cmd+Shift+P > Developer: Reload Window)
      2. Run "Cursor Agents: Install from Repository" from the command palette
  EOS
end
