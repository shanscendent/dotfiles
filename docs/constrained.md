# Constrained environments

When trying to set up your dotfiles on a very constrained system with no sudo access, some ancient gcc and a 150MB home directory limit, things start breaking.

Here's some rough steps to get started

1. install chezmoi with the binary install script (mise requires a newer gcc)
2. refer to the suse15 Dockerfile
3. but only chezmoi init (don't apply), delete .chezmoiscripts, .local/share/applications and symlink_home_dir.sh before chezmoi applying
4. manually copy symlink_home_dir.sh and run it
5. clone oh my tmux manually and symlink your conf
6. install mise with the script
7. add the mise shims directory to your path manually
8. then install stuff in your mise toml
9. might need to reinstall npm manually after updating mise again if there's an error
10. then run zsh manually if you're stuck with bash with no way to change your shell
11. build and install ugrep manually from source, move binary to $HOME/bin
12. build and install neovim manually from source, add $HOME/neovim/bin to path
13. install cargo using the rustup script, don't modify path
14. cargo install tree-sitter
15. create a zig-cc wrapper for zig cc command for treesitter to compile parsers correctly before you start neovim
16. start nvim and let everything install

## Wrappers

zig-cc

```bash
mkdir -p ~/bin

cat << 'EOF' > ~/bin/zig-cc
#!/usr/bin/env bash
exec zig cc "$@"
EOF

chmod +x ~/bin/zig-cc
export CC="$HOME/bin/zig-cc"
```
