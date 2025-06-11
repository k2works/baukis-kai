# ベースイメージとして Ubuntu 22.04 を使用
FROM ubuntu:22.04 AS base

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
            ansible \
            rsync \
            vim \
            libssl-dev \
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
            libpq-dev \
            libsqlite3-dev \
            default-mysql-client \
            postgresql-client \
            libcurl4-openssl-dev \
            software-properties-common \
            libffi-dev \
            libgdbm-dev \
            libdb-dev \
            lsof \
            default-libmysqlclient-dev \
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
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        python3-dev \
        python3-venv \
        virtualenv \
        build-essential \
        git \
        unzip \
        && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    pip3 install --no-cache-dir --upgrade pip virtualenv && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git && \
    cd aws-elastic-beanstalk-cli-setup && \
    python3 ./scripts/ebcli_installer.py && \
    echo 'export PATH="/root/.ebcli-virtual-env/executables:$PATH"' >> /root/.bashrc && \
    rm -rf aws-elastic-beanstalk-cli-setup && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# PATHの設定
ENV PATH="/root/.ebcli-virtual-env/executables:$PATH"

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

# Chrome関連のライブラリ
RUN apt-get update && \
    apt-get install -y \
    libnss3 \
    libnss3-dev \
    libxss1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libgtk-3-0 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libxfixes3

# パスの設定
ENV PATH="/root/.rbenv/shims:$PATH"

# 作業ディレクトリの設定
WORKDIR /srv

