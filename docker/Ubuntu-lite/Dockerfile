FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
  curl \
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
ENV SHELL=/usr/bin/zsh

# Switch to the 'ubuntu' user
USER ubuntu
WORKDIR /home/ubuntu

RUN --mount=type=secret,id=GITHUB_TOKEN,env=GITHUB_TOKEN \
  curl https://mise.run | sudo env MISE_INSTALL_PATH=/usr/local/bin/mise MISE_QUIET=1 sh \
  && mise use --global chezmoi \
  && mkdir -p "$HOME/.config/chezmoi/" && touch "$HOME/.config/chezmoi/lite" \
  && mise exec -- chezmoi init shanscendent --apply

SHELL ["/usr/bin/zsh", "-c"]

RUN source ~/.config/zsh/.zshrc &&\
  nvim --headless "+Lazy! install" +qa
