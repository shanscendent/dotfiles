FROM registry.suse.com/bci/bci-base:15.7

RUN set -euo pipefail; \
  zypper -n ref; \
  zypper -n in curl \
  git \
  which \
  glibc-locale-base \
  zsh \
  vim \
  ; \
  zypper addrepo https://download.opensuse.org/repositories/utilities/15.6/utilities.repo; \
  zypper --non-interactive --gpg-auto-import-keys refresh; \
  zypper install -y tmux \
  tree \
  ugrep \
  unzip \
  python313-pipx \
  ; \
  zypper -n clean -a ; \
  rm -rf /var/log/{lastlog,tallylog,zypper.log,zypp/history,YaST2}

# Assume we're running without sudo on a shared env, so don't install it

# Set locale and terminfo
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV TERM=xterm-256color
ENV SHELL=/usr/bin/zsh
# Fix tmux
ENV TMUX_TMPDIR=/tmp

# Switch to the 'ubuntu' user
RUN useradd -m -s /bin/bash suse
USER suse
WORKDIR /home/suse
ENV PATH="/home/suse/bin:${PATH}"

RUN --mount=type=secret,id=GITHUB_TOKEN,env=GITHUB_TOKEN \
  curl https://mise.run | env MISE_INSTALL_PATH=/home/suse/bin/mise MISE_QUIET=1 sh \
  && mise use --global chezmoi \
  && mkdir -p "$HOME/.config/chezmoi/" && touch "$HOME/.config/chezmoi/sudoless" \
  && mise exec -- chezmoi init shanscendent --apply

SHELL ["/usr/bin/zsh", "-c"]

RUN source ~/.config/zsh/.zshrc &&\
  nvim --headless "+Lazy! install" +qa
