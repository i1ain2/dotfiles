#!/bin/bash
# Claude Code statusline script
# Displays: [user@host dir] Model | Context: XX% (of auto-compact threshold)

input=$(cat)

# Basic info (fallback if jq fails)
USER_HOST="[$(whoami)@$(hostname -s) $(basename "$(pwd)")]"

# Extract from JSON input
MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
TOKENS=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
MAX=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')

# Auto-compact threshold is 95% of context window
THRESHOLD=$((MAX * 95 / 100))
if [ "$THRESHOLD" -gt 0 ]; then
    RATIO=$((TOKENS * 100 / THRESHOLD))
else
    RATIO=0
fi

# Format context size (K = thousands)
TOKENS_K=$((TOKENS / 1000))
THRESHOLD_K=$((THRESHOLD / 1000))

printf '%s %s | %dK/%dK (%d%%)' "$USER_HOST" "$MODEL" "$TOKENS_K" "$THRESHOLD_K" "$RATIO"
