#!/usr/bin/env bash
set -euo pipefail

# wl-paste を監視し、1Password などのパスワードマネージャーからのコピーを除外
wl-paste --type text --watch bash -c '
  # パスワードマネージャーからのコピーかチェック
  if wl-paste --list-types 2>/dev/null | grep -qi "password\|x-kde-passwordManagerHint"; then
    exit 0  # パスワードマネージャーからのコピーはスキップ
  fi

  # クリップボードの内容を取得
  content="$(wl-paste --no-newline 2>/dev/null || true)"

  # 空でなければ cliphist に保存
  if [[ -n "$content" ]]; then
    echo -n "$content" | cliphist store
  fi
'
