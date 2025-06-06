# Shan's Dotfiles

## Quick Setup

### Minimal vimrc for remote servers (or the root user)

Run this command

```sh
curl -o ~/.vimrc https://raw.githubusercontent.com/shanscendent/dotfiles/main/dot_vimrc
```

Alternatively, if you don't have internet access, just go to the link and copy the content [.vimrc](https://raw.githubusercontent.com/shanscendent/dotfiles/main/dot_vimrc)

### New Linux server setup (Ubuntu Server (20.04-24.04) and Ubuntu Desktop 24.04 only)

#### Normal Setup

Takes about 5-10 minutes to finish running.

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install build-essential curl git -y
CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install gcc chezmoi
chezmoi init shanscendent --apply
```

For desktop, the script will forcibly log you out after first installation of Pop Shell, just log back in and

```bash
chezmoi apply
```

to finish the rest of the setup.

#### Lite Setup

Homebrew is a bit heavy, there's a different setup path that uses mostly apt and mise to install only the necessary binaries for more resource constrained environments.

Unauthenticated requests to the GitHub API are rate limited, you may want to set a token for mise [here](https://mise.jdx.dev/getting-started.html#github-api-rate-limiting)

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install curl git -y
curl https://mise.run | sudo env MISE_INSTALL_PATH=/usr/local/bin/mise MISE_QUIET=1 sh
mise use --global chezmoi
mkdir -p $HOME/.config/chezmoi/ && touch $HOME/.config/chezmoi/lite
mise exec -- chezmoi init shanscendent --apply
```

### Test Drive

Want to take my dotfiles for a test drive? There's a ready made Ubuntu container that you can drop into to have a go, if you have Docker available on your system.

Note that it might be slightly out of date, it's x86 only, and it's also quite big at ~4GB.

This drops you into the container's shell and removes it after you `exit`

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

Clean up and remove the image

```bash
docker image rm ghcr.io/shanscendent/dotfiles/ubuntu
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

To build and push the ubuntu test container

Login to GHCR with `docker login ghcr.io`, then run

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
- Tidy up files that don't need to be there on some OSes
- Tidy up zshrc
- Tidy up messy install scripts
- Set up the Ubuntu docker container properly (or neovim in chezmoi scripts), helpful reading below
  - https://github.com/folke/lazy.nvim/discussions/1188
  - https://github.com/LazyVim/LazyVim/discussions/3679

## Notes

- Only Linux distros tested have been Ubuntu. YMMV for other distros.
- Ubuntu 20.04-24.04 headless should work fine, desktop only tested for 24.04.
