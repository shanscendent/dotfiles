FROM ubuntu:24.04

# Update and install prerequisites for Homebrew
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  file \
  git \
  sudo \
  locales \
  && rm -rf /var/lib/apt/lists/*

# Add the existing 'ubuntu' user to the sudoers group
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set locale and terminfo
RUN locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color

# Switch to the 'ubuntu' user
USER ubuntu
WORKDIR /home/ubuntu

# Install Homebrew
RUN NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.bashrc \
  && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
RUN brew install gcc chezmoi

# Uncomment to remove dotfiles setup
RUN chezmoi init shanscendent --apply

SHELL ["/home/linuxbrew/.linuxbrew/bin/zsh", "-c"]

RUN source ~/.zshrc &&\
  antidote update &&\
  nvim --headless "+Lazy! install" +qa

