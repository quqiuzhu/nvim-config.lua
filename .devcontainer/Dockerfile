FROM registry.sensetime.com/library/ubuntu:20.04-r1

# Using mirrors
RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && mv /etc/apt/sources.list.d /etc/apt/sources.list.d.bk \
    && mv /etc/apt/sources.list.d.bk /etc/apt/sources.list.d

# Neovim: https://github.com/neovim/neovim/wiki/Installing-Neovim
RUN apt-get update \
      && apt install -y curl wget \
      # Compress: unzip zip tar
      && apt install -y unzip zip tar \
      # Build essentials
      && DEBIAN_FRONTEND=noninteractive apt install -y build-essential autoconf libtool cmake pkg-config git \
      && apt install -y clang-format lua5.3 liblua5.3-dev ripgrep \
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

# RipGrep
ADD cargo_config /cargo_config
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh \
    && chmod +x rustup.sh \
    && ./rustup.sh -y \
    && cp /cargo_config /root/.cargo/config \
    && /root/.cargo/bin/cargo install tree-sitter-cli \
    && /root/.cargo/bin/cargo install ripgrep 
ENV PATH="/root/.cargo/bin:$PATH"

# Formatter
RUN curl -fsSL https://deb.nodesource.com/setup_14.x |  bash - \
    && apt-get install -y nodejs python3-pip\
    && npm install prettier -g \
    && pip3 install yapf \ 
    && wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz \
    && tar zxpf luarocks-3.3.1.tar.gz \
    && cd luarocks-3.3.1 \
    && ./configure \
    && make . && make install \
    && luarocks install --server=https://luarocks.org/dev luaformatter

# Golang
RUN wget https://mirrors.ustc.edu.cn/golang/go1.20.7.linux-amd64.tar.gz \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.7.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:$PATH"
