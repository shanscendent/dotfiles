# Shan's Dotfiles

## Prerequisites

### Linux/Mac

Install homebrew so we can easily install chezmoi on Mac or Linux. For users with passwordless sudo, prepend `CI=1` to the installation command.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# remember to copy the .zshrc or .bashrc lines and restart your shell
brew install chezmoi
```

### Windows

Install chezmoi on winget

```powershell
winget install --id=twpayne.chezmoi  -e
```

## Set up chezmoi

```bash
chezmoi init shanscendent --apply
```

## Additional setup

Set XDG_CONFIG_HOME for neovim config

```powershell
setx /M XDG_CONFIG_HOME "%USERPROFILE%\\.config"
```

Install npm for mason

```powershell
nvm install lts
nvm use <lts_version>
```

Open an admin powershell, then:  
Install the latest PSReadLine for Predictive IntelliSense

```powershell
Install-Module -Name PSReadLine -Force
```

## Create chezmoi.toml for machine-specific variables

### Linux/Mac

```bash
mkdir -p ~/.config/chezmoi && touch ~/.config/chezmoi/chezmoi.toml
vi ~/.config/chezmoi/chezmoi.toml
```

### Windows

```powershell
New-Item -Path "~/.config/chezmoi" -ItemType Directory -Force; New-Item -Path "~/.config/chezmoi/chezmoi.toml" -ItemType File -Force
notepad "$HOME/.config/chezmoi/chezmoi.toml"
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

## To-Do

- TODO Fix delta in lazygit theme autodetection
- TODO Change to homebrew for all Linux packages
