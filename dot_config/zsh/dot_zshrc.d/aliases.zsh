#!/bin/zsh
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'

alias uq='ug -Q'                # interactive TUI search (uses .ugrep config)
alias uz='ug -z'                # compressed files and archives search (uses .ugrep config)
alias ux='ug -U --hexdump'      # binary pattern search (uses .ugrep config)

alias ugit='ug -R --ignore-files' # works like git-grep & define your preferences in .ugrep config

alias grep='ug -G'                # search with basic regular expressions (BRE) like grep
alias egrep='ug -E'                # search with extended regular expressions (ERE) like egrep
alias fgrep='ug -F'                # find string(s) like fgrep
alias zgrep='ug -zG'               # search compressed files and archives with BRE
alias zegrep='ug -zE'               # search compressed files and archives with ERE
alias zfgrep='ug -zF'               # find string(s) in compressed files and/or archives

alias xdump='ugrep -X ""'                 # hexdump files without searching (don't use .ugrep config)
alias zmore='ugrep+ -z -I -+ --pager ""'  # view compressed, archived and regular files (don't use .ugrep config)

alias ll='ls -lah'
alias autossh='autossh -M 0 -o "ServerAliveInterval=10" -o "ServerAliveCountMax=3"'
alias v='nvim'

alias nlof="~/scripts/fzf_listoldfiles.sh"
alias fman="compgen -c | fzf | xargs man"

# omakub inspired
# File System
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# Tools
alias n='nvim'
alias g='git'
alias d='docker'
alias lzg='lazygit'
alias lzd='lazydocker'
# Git
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
# Compression
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# macos
hud() {
    /bin/launchctl setenv MTL_HUD_ENABLED $1
}

