FROM Debian:bullseye

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Europe/Brussels

RUN apt-get update && apt-get -y install \ 
  curl \ 
  fzf \ 
  ripgrep \
  tree \
  git \
  xclip \
  python3 \ 
  python3-pip \ 
  nodejs \
  npm \
  tzdata \
  neovim

# Create directory for Neovim configuration files.
RUN mkdir -p /root/.config/nvim

# Copy Neovim configuration files.
COPY ./config/ /root/.config/


# Clone packer
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 /root/.local/share/nvim/site/pack/packer/start/packer.nvim
 
# Create directory for projects (there should be mounted from host).
RUN mkdir -p /root/workspace
# Set default location after container startup.
WORKDIR /root/workspace
# Avoid container exit.
CMD ["tail", "-f", "/dev/null"]
