FZF_ALT_C_COMMAND= source <(fzf --zsh)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

