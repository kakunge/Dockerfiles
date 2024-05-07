FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LC_CTYPE=C.UTF-8

RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

RUN mkdir -p /setup/config
WORKDIR /setup

RUN apt-get update
RUN apt-get install -y git gcc gettext ssh curl wget gdb zsh python3 python3-pip libffi-dev build-essential libssl-dev make cmake

# oh my zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
RUN echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
RUN chsh -s /usr/bin/zsh

# pwndbg
RUN git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh

# gef
RUN git clone https://github.com/hugsy/gef.git && echo source `pwd`/gef/gef.py >> ~/.gdbinit

# peda
RUN git clone https://github.com/longld/peda.git && echo source `pwd`/peda/peda.py >> ~/.gdbinit

# neovim
RUN git clone https://github.com/neovim/neovim.git && cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install

# astronvim
RUN git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim

COPY init.lua /setup/config/init.lua
COPY .zshrc /setup/config/.zshrc

WORKDIR /home

# v8
COPY x86/ubuntu20.04/v8/build.sh /home/build.sh
RUN chmod 755 /home/build.sh && /home/build.sh

# node
RUN wget https://nodejs.org/dist/v20.11.0/node-v20.11.0.tar.gz && tar zxvf node-v20.11.0.tar.gz && cd node-v20.11.0 && ./configure && make -j4

# npm

CMD [ "zsh" ]