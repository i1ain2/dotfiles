# Claude Code Context

## Environment Overview
- **Dotfiles Management**: chezmoi with templating and conditional logic
- **OS Support**: macOS (Darwin) + Linux (Arch Linux)
- **Shell**: zsh (Powerlevel10k, sheldon plugin manager) + fish shell support
- **Terminal**: Alacritty with Tokyo Night theme, HackGen35 Console NF font
- **Editor**: Neovim with custom Lua configuration

## Development Tools & Environment
```
Languages: Node.js, Go (1.23.0), Python, Rust
Package Managers: mise, brew (macOS), pacman (Arch)
Key Tools:
- fzf (fuzzy finder)
- ghq (repository management)
- lazygit (git TUI)
- tmux (terminal multiplexer)
- kubectl (Kubernetes)
- terraform
- navi (command cheatsheet)
- direnv (environment management)
```

## Important Aliases & Abbreviations
```bash
# Core commands
c → claude
n → nvim
g → git
t → tmux a -t 0 || tmux -u
lg → lazygit
r → rg (ripgrep with custom colors)

# Git shortcuts
git s → git switch
git st → git status
git d → git diff
git l → git log
git g → git log --graph (pretty format)
git a → git add
git ap → git add -p
git c → git commit -m
git p → git push -u origin

# Development
serve → python3 -m http.server
k → kubectl
```

## Custom Functions & Key Bindings
```bash
# Functions
cdt()       # cd to temporary directory
cts()       # run TypeScript with ts-node
lock-screen() # swaylock for Linux

# Key Bindings
Ctrl-x Ctrl-o → fzf-git menu
Ctrl-x Ctrl-g → fzf cd to ghq repository
Ctrl-x Ctrl-e → edit command in nvim
Ctrl-x Ctrl-h → navi cheat sheet widget
```

## Chezmoi Management

### Key Concepts
- **Templates**: `.tmpl` files support Go templating with conditional logic
- **OS-specific configs**: macOS (Darwin) and Linux support
- **Private files**: `private_` prefix for sensitive data
- **Run-once scripts**: `run_once_*.sh.tmpl` for initial setup

### Directory Mapping
```
dot_config/              → ~/.config/
dot_zshrc.tmpl          → ~/.zshrc
dot_gitconfig.tmpl      → ~/.gitconfig
private_dot_local/      → ~/.local/ (sensitive)
run_once_packages_*.sh  → Package installation scripts
```

### Common Operations
```bash
# Review changes
chezmoi diff

# Apply changes
chezmoi apply

# Edit source files
chezmoi edit ~/.zshrc

# Add new file to chezmoi
chezmoi add ~/.newconfig
```

### Template Variables
```go
{{ if eq .chezmoi.os "darwin" }}  # macOS specific
{{ if eq .chezmoi.os "linux" }}   # Linux specific
```

## Configuration Files Structure
```
~/.config/
├── alacritty/alacritty.toml     # Terminal config
├── nvim/                        # Neovim configuration
├── fish/                        # Fish shell (alternative)
├── mise/config.toml            # Development tools
├── hypr/                       # Hyprland (Linux)
├── sway/                       # Sway WM (Linux)
└── waybar/                     # Status bar (Linux)
```

## Package Management
- **macOS**: Homebrew packages defined in template variables
- **Linux**: Pacman packages for Arch Linux
- **Development tools**: Managed by mise (Node.js, Go, etc.)
- **Shell plugins**: Managed by sheldon

## Important Notes
- Always use `chezmoi diff` before `chezmoi apply`
- Alacritty lacks native audio bell support on macOS
- Claude Code has no built-in task completion hooks
- Enable notifications: System Preferences → Notifications → Script Editor → Allow
- Fish shell functions mirror zsh equivalents
- P10k theme configuration stored in `~/.local/share/zsh/.p10k.zsh`
