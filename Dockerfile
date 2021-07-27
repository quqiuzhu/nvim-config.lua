FROM ubuntu:bionic

# Using mirrors
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && mv /etc/apt/sources.list.d /etc/apt/sources.list.d.bk \
    && mv /etc/apt/sources.list.d.bk /etc/apt/sources.list.d

# Neovim: https://github.com/neovim/neovim/wiki/Installing-Neovim
RUN apt-get update \
      && apt install -y curl wget \
      && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
      && chmod u+x nvim.appimage \
      && ./nvim.appimage --appimage-extract \
      && ./squashfs-root/AppRun --version \
      && ln -s /squashfs-root/AppRun /usr/bin/nvim \
      && update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 \
      && update-alternatives --config vi \
      && update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 \
      && update-alternatives --config vim \
      && update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 \
      && update-alternatives --config editor \
      && rm -f nvim.appimage

# Python3
RUN apt-get install -y python3.8 python3.8-dev python3.8-distutils python3.8-venv python3-pip \
    && mkdir -p $HOME/.config/pip \
    && printf '[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple' > $HOME/.config/pip/pip.conf \
    && pip3 install --upgrade pip \
    && pip3 install virtualenv \
    && pip3 install pynvim

# Build essentials
RUN apt-get install -y build-essential autoconf libtool cmake pkg-config git

ADD cargo_config /cargo_config

# RipGrep
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
    && chmod +x rustup.sh \
    && ./rustup.sh -y \
    && cp /cargo_config /root/.cargo/config \
    && /root/.cargo/bin/cargo install ripgrep

ENV PATH="/root/.cargo/bin:$PATH"

# Compress: unzip zip tar
RUN apt-get install -y unzip zip tar

# Golang
RUN wget https://mirrors.ustc.edu.cn/golang/go1.12.17.linux-amd64.tar.gz \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.12.17.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:$PATH"
