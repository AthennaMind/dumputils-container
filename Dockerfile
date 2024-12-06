FROM golang:1.20-alpine AS golang-builder
ENV TS_PARALLEL_COPY_VERSION="v0.4.0"
RUN apk add git --no-cache

WORKDIR /build

RUN git clone https://github.com/timescale/timescaledb-parallel-copy.git \
  && cd timescaledb-parallel-copy \
  && git checkout ${TS_PARALLEL_COPY_VERSION} \
  && cd cmd/timescaledb-parallel-copy \
  && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /build/timescaledb-parallel-copy

FROM ubuntu:22.04

ENV MONGO_TOOLS_VERSION="100.5.2"
ENV BAT_VERSION="0.22.1"
ENV DEBIAN_FRONTEND noninteractive

COPY doc /root/doc/
COPY bin /root/bin/
COPY .bashrc /root/
COPY .vimrc /root/
COPY .bash /root/.bash/
COPY --from=golang-builder /build/timescaledb-parallel-copy /usr/bin/

# create base dirs
RUN mkdir -p /opt/backups /root/.config /root/.kube \
  && find /root/bin/ -type f -print0 | xargs -0 chmod +x \
  # symlink python3 to python
  && ln -s /usr/bin/python3 /usr/bin/python \
  # install base packages
  && apt-get update -y \
  && apt-get install -y --no-install-recommends \
  # common utils
  vim gpg gnupg2 git ca-certificates software-properties-common apt-transport-https \
  # net utils
  curl wget iputils-ping openssh-client \
  # archive utils
  zip unzip bzip2 p7zip-full \
  # monitoring utils
  procps htop \
  # percona-toolkit dependencies
  libdbi-perl libdbd-mysql-perl libterm-readkey-perl libio-socket-ssl-perl

RUN cd /tmp/ \
  # add repository lists
  && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
  && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
  && apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' \
  && add-apt-repository "deb [arch=amd64,arm64,ppc64el] https://atl.mirrors.knownhost.com/mariadb/repo/10.8/ubuntu $(lsb_release -cs) main" \
  && curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list \
  # update and install postgres-client, mariadb-client and redis-tools
  && apt-get update -y \
  && apt-get install -y --no-install-recommends \
  postgresql-client-10 \
  postgresql-client-11 \
  postgresql-client-12 \
  postgresql-client-13 \
  postgresql-client-14 \
  postgresql-client-15 \
  postgresql-client-16 \
  postgresql-client-17 \
  mariadb-client \
  redis-tools \
  kafkacat \
  # install minio client
  && wget -q https://dl.min.io/client/mc/release/linux-amd64/mc \
  && mv mc /usr/local/bin/mc \
  && chmod +x /usr/local/bin/mc \
  # install mongo tools
  && wget -q https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian10-x86_64-${MONGO_TOOLS_VERSION}.deb -O mongo-tools.deb \
  && dpkg -i mongo-tools.deb \
  # Install kubectl
  && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
  # Install percona-toolkit
  && wget -q https://downloads.percona.com/downloads/percona-toolkit/3.5.0/binary/debian/jammy/x86_64/percona-toolkit_3.5.0-5.jammy_amd64.deb -O percona-toolkit.deb \
  && dpkg -i percona-toolkit.deb \
  # Install AWS cli
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  # Install bat
  && wget -q "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" -O bat.deb \
  && dpkg -i bat.deb \
  # configure vim
  && git clone https://github.com/VundleVim/Vundle.vim.git --depth=1 --branch master --single-branch ~/.vim/bundle/Vundle.vim \
  && vim +VundleInstall +qall \
  # clean
  && rm -rf /tmp/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /root/.wget-hsts \
  && rm -rf /root/.vim/bundle/Vundle.vim/.git

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
