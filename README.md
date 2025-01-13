# Shan's Dotfiles
## Prerequisites
Install homebrew so we can easily install chezmoi on Mac or Linux. For users with passwordless sudo, prepend `CI=1` to the installation command.
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi
```

## Set up chezmoi
```bash
chezmoi init shanscendent --apply 
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
