# Aliases
alias rm='rm -i'
alias diff='diff -U1'
alias cp='cp -i'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
(( $+commands[xdg-open] )) && alias open='xdg-open'

# Abbreviations
abbr -S ll='ls -alF' > /dev/null
abbr -S la='ls -A' > /dev/null
abbr -S l='ls -CF' > /dev/null
abbr -S n='nvim' > /dev/null
abbr -S h='history -i' > /dev/null
abbr -S lg='lazygit' > /dev/null
abbr -S g="git" > /dev/null
abbr -S "git s"="git status" > /dev/null
abbr -S "git d"="git diff" > /dev/null
abbr -S "git l"="git log" > /dev/null
abbr -S "git g"="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" > /dev/null
abbr -S "git a"="git add -p" > /dev/null
abbr -S "git c"="git commit -m" > /dev/null
abbr -S "git p"="git push -u origin" > /dev/null
abbr -S "git sh"="git stash" > /dev/null
abbr -S "git w"="git worktree" > /dev/null
abbr -S t='tmux new -As main' > /dev/null
abbr -S tm='tmux new -As mobile' > /dev/null
abbr -S serve='python3 -m http.server' > /dev/null
abbr -S k='kubectl' > /dev/null
abbr -S c='claude' > /dev/null
abbr -S 'claude c'='claude 適切な粒度でコミットして ref:git-commit-message' > /dev/null
abbr -S cn='notify' > /dev/null
abbr -S r='rg -i --color=auto --colors=path:fg:yellow --colors=match:fg:green --hidden' > /dev/null
