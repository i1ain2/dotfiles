# Shell functions

# cd to temporary directory
cdt() {
  cd $(mktemp -d)
}

# run TypeScript with ts-node
cts() {
  npx ts-node --compilerOptions '{"strict":true}' $1
}

# lock screen (Linux/Sway)
lock-screen() {
  swaylock -c 000000
}

# Ctrl-x Ctrl-o: fzf-git menu
_fzf_git_menu() {
  local result key
  local saved_buffer="$BUFFER"
  local saved_cursor="$CURSOR"

  {
    echo "Select fzf-git function:"
    echo "f) Files"
    echo "b) Branches"
    echo "t) Tags"
    echo "r) Remotes"
    echo "h) commit Hashes"
    echo "s) Stashes"
    echo "l) refLogs"
    echo "w) Worktrees"
    echo "e) Each ref"

    read -k1 key
    echo
  } >/dev/tty

  case $key in
    f) result=$(_fzf_git_files) ;;
    b) result=$(_fzf_git_branches) ;;
    t) result=$(_fzf_git_tags) ;;
    r) result=$(_fzf_git_remotes) ;;
    h) result=$(_fzf_git_hashes) ;;
    s) result=$(_fzf_git_stashes) ;;
    l) result=$(_fzf_git_lreflogs) ;;
    w) result=$(_fzf_git_worktrees) ;;
    e) result=$(_fzf_git_each_ref) ;;
    *)
      BUFFER="$saved_buffer"
      CURSOR="$saved_cursor"
      zle reset-prompt
      return 1
      ;;
  esac

  if [ -n "$result" ]; then
    BUFFER="${saved_buffer} ${result}"
    CURSOR=${#BUFFER}
  else
    BUFFER="$saved_buffer"
    CURSOR="$saved_cursor"
  fi

  zle reset-prompt
}
zle -N _fzf_git_menu
bindkey '^x^o' _fzf_git_menu

# Ctrl-x Ctrl-g: cd to ghq repository
_fzf_cd_ghq() {
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
  local root="$(ghq root)"
  local repo="$(ghq list | fzf --preview="eza --tree --level=2 ${root}/{1}")"
  local dir="${root}/${repo}"
  [ -n "${dir}" ] && cd "${dir}"
  zle accept-line
  zle reset-prompt
}
zle -N _fzf_cd_ghq
bindkey "^x^g" _fzf_cd_ghq

# Ctrl-x Ctrl-e: edit command in nvim
_edit_buffer() {
  local tmpfile=$(mktemp)
  echo "$BUFFER" > $tmpfile
  nvim $tmpfile -c "normal $" -c "set filetype=zsh"
  BUFFER="$(bat $tmpfile)"
  CURSOR=${#BUFFER}
  rm $tmpfile
  zle reset-prompt
}
zle -N _edit_buffer
bindkey '^x^e' _edit_buffer
