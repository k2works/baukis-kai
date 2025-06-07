# ベースイメージとして Ubuntu 18.04 を使用
FROM ubuntu:18.04 AS base

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=ja_JP.UTF-8 \
    LC_ALL=ja_JP.UTF-8 \
    LC_CTYPE=ja_JP.UTF-8 \
    RUBY_VER=3.4.4 \
    BUNDLER_VER=2.6.7 \
    NODE_VER=16 \
    PACKER_VERSION=1.9.2 \
    TERRAFORM_VERSION=1.6.6

# ロケールのセットアップ
RUN apt-get update && apt-get install -y \
    language-pack-ja-base \
    language-pack-ja \
    && update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja \
    && rm -rf /var/lib/apt/lists/*

# 基本的なパッケージのインストール
RUN apt-get update && \
    apt-get install -y \
           sudo \
           build-essential \
           zip \
           unzip \
           git \
           curl \
           wget \
           git-core \
           libssl-dev \
           libqt4-dev \
           libc6-dev \
           automake \
           libtool \
           libyaml-dev \
           zlib1g \
           zlib1g-dev \
           openssl \
           libreadline-dev \
           libxml2-dev \
           libxslt1-dev \
           libncurses5-dev \
           pkg-config \
           chrpath \
           libfontconfig1-dev \
           libxft-dev \
           libpq-dev \
           libsqlite3-dev \
           libmysqlclient-dev \
           default-mysql-client \
           postgresql-client \
           xvfb \
           qtbase5-dev \
           libqt5webkit5-dev \
           xauth \
           libcurl4-openssl-dev \
           software-properties-common \
           libffi-dev \
           libgdbm5 \
           libgdbm-dev \
           libdb-dev \
           lsof \
           libmariadb-dev \
           curl \
           unzip \
           sudo \
           ansible \
           rsync \
           vim \
           && apt-get clean \
           && rm -rf /var/lib/apt/lists/*

# Rubyのインストール
RUN git clone https://github.com/sstephenson/rbenv ~/.rbenv \
    && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
    && ~/.rbenv/plugins/ruby-build/install.sh \
    && echo 'export PATH="/$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
    && . ~/.bashrc \
    && rbenv install $RUBY_VER \
    && rbenv global $RUBY_VER

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm install $NODE_VER \
    && nvm use $NODE_VER

 # pipの更新とAWSツールのインストール
 RUN curl -sS https://bootstrap.pypa.io/pip/3.6/get-pip.py | python3 \
     && python3 -m pip install --no-cache-dir --upgrade pip \
     && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
     && unzip awscliv2.zip \
     && ./aws/install \
     && rm -rf awscliv2.zip aws \
     && python3 -m pip install --no-cache-dir awsebcli --upgrade

# HashiCorpツールのインストール
RUN curl -fsSL https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o packer.zip \
    && unzip packer.zip -d /usr/local/bin \
    && rm packer.zip \
    && curl -fsSL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip -d /usr/local/bin \
    && rm terraform.zip

# EasyRSAのセットアップ
RUN mkdir -p /home/vscode/easy-rsa \
    && useradd -m vscode || true \
    && wget -qO- https://github.com/OpenVPN/easy-rsa/releases/download/v3.1.5/EasyRSA-3.1.5.tgz | tar xz -C /home/vscode/easy-rsa/ --strip-components=1 \
    && chown -R vscode:vscode /home/vscode/easy-rsa \
    && chmod -R 755 /home/vscode/easy-rsa

# ヘルパースクリプトの追加
COPY --chmod=755 <<EOF /usr/local/bin/check-easyrsa
#!/bin/bash
echo "Checking for EasyRSA:"
find /usr -name "easyrsa" -type f
echo ""
echo "Checking for OpenSSL configs:"
find /usr -name "openssl-*.cnf"
EOF

# パスの設定
ENV PATH="/root/.rbenv/shims:$PATH"

# 作業ディレクトリの設定
WORKDIR /srv