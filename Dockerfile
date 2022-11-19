FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

COPY doc /root/doc/
COPY bin /root/bin/
COPY .bashrc /root/
COPY .bash /root/.bash/

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
       # arhieve utils
       zip unzip bzip2 p7zip-full \
       # monitoring utils
       procps htop

RUN cd /tmp/ \
    # add repository lists
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
    && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc' \
    && add-apt-repository "deb [arch=amd64,arm64,ppc64el] https://atl.mirrors.knownhost.com/mariadb/repo/10.8/ubuntu $(lsb_release -cs) main" \
    && curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list \
    # update and install postgresclient, mariadb-client and redis-tools
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        postgresql-client-10 \
        postgresql-client-11 \
        postgresql-client-12 \
        postgresql-client-13 \
        postgresql-client-14 \
        postgresql-client-15 \
        mariadb-client \
        redis-tools \
    # install minio client
    && wget https://dl.min.io/client/mc/release/linux-amd64/mc \
    && mv mc /usr/local/bin/mc \
    && chmod +x /usr/local/bin/mc \
    # install mongo tools
    && wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian10-x86_64-100.5.2.deb -O mongo-tools.deb \
    && dpkg -i mongo-tools.deb \
    # Install kubectl 
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    # Install AWS cli
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    # Install bat
    && wget "https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb" \
    && dpkg -i bat_0.22.1_amd64.deb \
    # clean 
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.wget-hsts

WORKDIR /root

ENTRYPOINT ["/bin/bash"]
