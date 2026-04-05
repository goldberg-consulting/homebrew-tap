class MeasuredOneAgentsRules < Formula
  desc "Install measured.one Cursor agents, rules, and skills"
  homepage "https://github.com/goldberg-consulting/measured.one.agents-rules"
  url "https://github.com/goldberg-consulting/measured.one.agents-rules/archive/4ac92fd212861848b2be925758f50a82f27e43ce.tar.gz"
  version "0.1.0"
  sha256 "73c7b0e22e2e9477a312cfb12de495d49f3d63fcd5875cdba8cd955f27586b02"
  license "MIT"

  depends_on "bash"
  depends_on "python"

  def install
    libexec.install "cursor", "ReferenceData", "prompts", "install.sh", "install-all.sh", ".env.example", "README.md"

    (bin/"measured-one-agents-rules-install").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      target="${1:-.}"
      mkdir -p "$target/ReferenceData"
      "#{libexec}/install.sh" "$@"

      if [ -d "#{libexec}/cursor/skills" ]; then
        mkdir -p "$target/.cursor"
        cp -R "#{libexec}/cursor/skills" "$target/.cursor/"
      fi
    EOS

    (bin/"measured-one-agents-rules-install-all").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      if [ ! -f "#{libexec}/.env" ] && [ -f "#{libexec}/.env.example" ]; then
        cp "#{libexec}/.env.example" "#{libexec}/.env"
      fi
      cd "#{libexec}"
      exec "#{libexec}/install-all.sh" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Install into one project:
        measured-one-agents-rules-install /path/to/project

      Install into multiple projects:
        cp #{opt_libexec}/.env.example #{opt_libexec}/.env
        edit #{opt_libexec}/.env and set PROJECTS
        measured-one-agents-rules-install-all --dry-run
        measured-one-agents-rules-install-all
    EOS
  end

  test do
    system "#{bin}/measured-one-agents-rules-install", testpath.to_s
    assert_predicate testpath/".cursor/agents", :directory?
    assert_predicate testpath/".cursor/rules", :directory?
    assert_predicate testpath/".cursor/skills", :directory?
  end
end
