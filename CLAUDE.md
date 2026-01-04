# Chezmoi Dotfiles - プロジェクトコンテキスト

## 概要
- **管理ツール**: chezmoi（Go テンプレート対応）
- **OS**: macOS (Darwin) + Arch Linux
- **シェル**: zsh (P10k) + fish
- **ターミナル**: Alacritty, Ghostty
- **エディタ**: Neovim

## Chezmoi 基本操作

```bash
chezmoi diff      # 変更確認（必須）
chezmoi apply     # 適用
chezmoi edit ~/.config/nvim/init.lua  # ソース編集
chezmoi add ~/.newconfig              # 新規追加
```

## ディレクトリマッピング

```
dot_config/              → ~/.config/
dot_zshrc.tmpl          → ~/.zshrc
dot_gitconfig.tmpl      → ~/.gitconfig
private_dot_local/      → ~/.local/ (機密情報)
run_once_*.sh.tmpl      → 初期セットアップスクリプト
```

## テンプレート構文

```go
{{ if eq .chezmoi.os "darwin" }}  # macOS
{{ if eq .chezmoi.os "linux" }}   # Linux
```

## 主要設定ファイル

- `alacritty/alacritty.toml.tmpl` - ターミナル設定（Tokyo Night）
- `ghostty/config.tmpl` - Ghostty ターミナル
- `fish/config.fish.tmpl` - Fish シェル
- `dot_zshrc.tmpl` - Zsh 設定
- `dot_gitconfig.tmpl` - Git 設定

## 重要事項

- **必ず** `chezmoi diff` → `chezmoi apply` の順で実行
- テンプレートファイルは `.tmpl` 拡張子必須
- 機密情報は `private_` プレフィックス使用
- P10k 設定: `~/.local/share/zsh/.p10k.zsh`
