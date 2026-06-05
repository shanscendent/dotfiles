# install keychain for ssh key management on Linux (optional)
if command -v keychain >/dev/null 2>&1; then
    eval "$(keychain --quiet --eval --agents ssh id_ed25519)"
else
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
