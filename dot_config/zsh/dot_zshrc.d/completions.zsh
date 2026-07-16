# Add bash completions for extra tools
autoload -U +X bashcompinit && bashcompinit
# terraform
if command -v terraform >/dev/null 2>&1; then
  complete -o nospace -C "$(command -v terraform)" terraform
fi
# linode-cli
if command -v linode-cli >/dev/null 2>&1; then
  source <(linode-cli completion bash)
fi
