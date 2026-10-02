# Goldberg Consulting Homebrew Tap

Homebrew formulae and casks for tools by [Goldberg Consulting](https://github.com/goldberg-consulting).

## Install

```bash
brew tap goldberg-consulting/tap
```

## Available casks

| Cask | Description |
|------|-------------|
| `distribute-metal` | measured.one.distribute-metal — distributed PyTorch training on Apple Silicon using Metal and MCCL |

### measured.one.distribute-metal

```bash
brew install goldberg-consulting/tap/distribute-metal
```

Requires Apple Silicon (M1+) and macOS 14+ (Sonoma).

## Find Yoshi IT

Native macOS document search, Command–Space launcher, and persistent offline NAS indexes.
Requires Apple silicon and macOS 14 or later.

```sh
brew install --cask goldberg-consulting/tap/find-yoshi-it
brew update
brew upgrade --cask find-yoshi-it
```

For an identical existing copy in your personal Applications folder:

```sh
brew install --cask --adopt --appdir="$HOME/Applications" goldberg-consulting/tap/find-yoshi-it
```

The cask quits the app before removal during upgrades and retains the index,
change journal, and preferences in `~/Library/Application Support/FindAnything`.
It does not clear quarantine or erase the library, even with `brew uninstall --zap`.
The current app is ad-hoc signed and not notarized; macOS may require first-launch
approval in Privacy & Security.

The **Update Find Yoshi IT** workflow checks the latest stable GitHub release every
30 minutes (GitHub scheduling can be delayed), or on manual dispatch. It verifies
the ZIP against the release checksum, checks the cask, installs it on a temporary
macOS runner, verifies its signature, and commits the new version to this tap.
Missing assets or mismatched checksums fail the update without changing the tap.
No cross-repository personal token is required. Run it immediately after releasing:

```sh
gh workflow run update-find-yoshi-it.yml --repo goldberg-consulting/homebrew-tap
```

## License

MIT
