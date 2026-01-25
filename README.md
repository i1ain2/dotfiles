# dotfiles

managed with [chezmoi](https://github.com/twpayne/chezmoi)

## Structure

```
.
├── .chezmoidata/
│   └── packages.yaml          # Package definitions (pacman, paru, brew, brew_cask)
├── dot_config/                # -> ~/.config/
│   ├── ghostty/               # Terminal config
│   ├── mise/config.toml.tmpl  # Dev tools (node, go, bun, etc.)
│   ├── nvim/                  # Neovim config (Lua)
│   ├── sheldon/plugins.toml   # zsh plugin manager
│   └── zsh/                   # zsh config (aliases, functions, path)
├── dot_claude/                # -> ~/.claude/ (Claude Code config)
├── dot_local/                 # -> ~/.local/
│   └── bin/                   # Custom scripts
├── dot_gitconfig.tmpl         # -> ~/.gitconfig
├── dot_tmux.conf              # -> ~/.tmux.conf
├── dot_vimrc                  # -> ~/.vimrc
├── dot_zprofile               # -> ~/.zprofile
├── dot_zshrc.tmpl             # -> ~/.zshrc
└── run_once_*.sh.tmpl         # First-run setup scripts
```

## Install

### 1. Install chezmoi

**macOS:**
```bash
brew install chezmoi
```

**Arch Linux:**
```bash
sudo pacman -S chezmoi
```

### 2. Create external config files

Before applying chezmoi, create the following config file.

#### ~/.config/chezmoi/chezmoi.toml

```toml
[data.git]
    email = "your-email@example.com"
    name = "Your Name"
    github_user = "your-github-username"
```

### 3. Apply dotfiles

```bash
chezmoi init https://github.com/i1ain2/dotfiles.git
chezmoi apply
```

## External Config Files

### ~/.zshrc.local

Machine-specific zsh settings. Sourced at the end of `~/.zshrc`.

```bash
# Path to navi cheatsheets
export NAVI_PATH="$HOME/.local/share/navi/cheats:$HOME/path/to/your/cheats"

# Root directory for notes (used by custom scripts)
export NOTES_ROOT="$HOME/path/to/your/notes"
```

## Pre-commit

Uses [prek](https://github.com/j178/prek) (a faster pre-commit alternative) with [secretlint](https://github.com/secretlint/secretlint) to prevent committing secrets.

```bash
# Install prek hooks
prek install
```

