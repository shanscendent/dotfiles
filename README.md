# Shan's Dotfiles
## Install chezmoi
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply shanscendent
```

## Create chezmoi.toml for machine-specific variables
```bash
mkdir -p ~/.config/chezmoi && touch ~/.config/chezmoi/chezmoi.toml
vi ~/.config/chezmoi/chezmoi.toml
```
```powershell
New-Item -Path "~/.config/chezmoi" -ItemType Directory -Force; New-Item -Path "~/.config/chezmoi/chezmoi.toml" -ItemType File -Force
```

## chezmoi.toml
Work:
```toml
[data]
    environment = "intel"
    email = "shan.neng.lee@intel.com"
```

Personal:
```toml
[data]
    environment = "personal"
    email = "shanlee41@gmail.com"
```
