# PATH settings
typeset -U path  # Remove duplicates

path=(
  $HOME/.local/bin
  /opt/homebrew/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  $path
)

export PATH
