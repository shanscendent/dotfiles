# Miscellaneous setup copypastas

## SSH Agent

Enable the user agent

```bash
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
```

Add this line to .zshrc or .bashrc

```bash
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
```

Add your key

```bash
ssh-add
```
