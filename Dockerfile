FROM ubuntu:18.04

# Setup locale
RUN \
apt-get -yq update && \
apt-get install -y language-pack-ja-base language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja
ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8

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
           libqtwebkit-dev \
           xauth \
           libcurl4-openssl-dev \
           software-properties-common \
           libffi-dev \
           libgdbm5 \
           libgdbm-dev \
           libdb-dev \
           lsof \
           vim

# Ruby
ENV RUBY_VER 2.7.8
ENV BUNDLER_VER 2.1.4
RUN rm -rf ~/.rbenv
RUN git clone https://github.com/sstephenson/rbenv ~/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN ~/.rbenv/plugins/ruby-build/install.sh
RUN echo 'export PATH="/$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
RUN . ~/.bash_profile && \
         rbenv install $RUBY_VER  && \
         rbenv global $RUBY_VER
ENV PATH ~/.rbenv/shims:$PATH
RUN ~/.rbenv/shims/gem install bundler:$BUNDLER_VER

# Node
ENV NODE_VER 16
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
RUN . $HOME/.nvm/nvm.sh && \
    nvm install $NODE_VER && \
    nvm use $NODE_VER && \
    node -v && npm -v && \
    npm i -g yarn
RUN apt install -y nodejs

