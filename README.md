# Shan's Dotfiles

## Quick Setup

### Minimal vimrc for remote servers

Run this command

```sh
curl -o ~/.vimrc https://raw.githubusercontent.com/shanscendent/dotfiles/main/dot_vimrc
```

Alternatively, if you don't have internet access, just go to the link and copy the content [.vimrc](https://raw.githubusercontent.com/shanscendent/dotfiles/main/dot_vimrc)

### New Linux server setup

Takes about 5-10 minutes to finish running.

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install build-essential -y
CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install gcc chezmoi
chezmoi init shanscendent --apply
```

## Usage

### Set up chezmoi

```bash
chezmoi init shanscendent --apply
```

### Usage

```bash
chezmoi update --apply
```

Exit and reopen your terminal to apply changes.

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

#### Additional setup

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

Not needed at the moment

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

## To-Do

- TODO Fix delta in lazygit theme autodetection
- Upgrade to mason 2.0.0 after lazyvim fixes it https://github.com/LazyVim/LazyVim/issues/6039
- Fix chsh still asking for password with passwordless sudo
