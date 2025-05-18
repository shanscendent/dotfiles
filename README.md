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

### Test Drive

Want to take these dotfiles for a test drive? There's a ready made Ubuntu container that you can drop into to have a go. Note that it'll be slightly out of date

Please have docker available on your system.

```bash
docker run --rm --init --name shanbuntu --hostname shanbuntu -it ghcr.io/shanscendent/dotfiles/ubuntu:latest zsh
```

Alternatively, if you'd like to leave it running and remove it later

```bash
# Start the container
docker run --init --name shanbuntu --hostname shanbuntu -it -d ghcr.io/shanscendent/dotfiles/ubuntu:latest sleep infinity
# Execute into it
docker exec -it shanbuntu zsh
# Stop and remove the container
docker stop shanbuntu && docker rm shanbuntu
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

### Ubuntu test container

Login to GHCR with `docker login ghcr.io`

```bash
just docker
```

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

- Fix delta in lazygit theme autodetection
- Clean up cluttered home directory, try and move everything to `.config`
- Tidy up zshrc
- Tidy up files that don't need to be there on some OSes
- Set up the Ubuntu docker container properly (or neovim in chezmoi scripts), helpful reading below
  - https://github.com/folke/lazy.nvim/discussions/1188
  - https://github.com/LazyVim/LazyVim/discussions/3679
- Recipe to clear Docker cache to pull new changes?
