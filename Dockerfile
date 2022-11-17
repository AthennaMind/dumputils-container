FROM debian:bullseye-slim
LABEL org.opencontainers.image.source="https://github.com/st3ga/dumputils"
LABEL org.opencontainers.image.description="[st3ga] dumputils. Provides easy access to most dump/restore utils used for managing database backups."

ENV DEBIAN_FRONTEND noninteractive

# Install Base Packages
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
       curl wget gpg gnupg2 zip unzip git \
       software-properties-common \
       apt-transport-https \
       ca-certificates

RUN cd /tmp/ \
    # add repository lists
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list \
    && curl -fsSl https://mariadb.org/mariadb_release_signing_key.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/mariadb.gpg \
    && echo "deb [arch=amd64,arm64,ppc64el] https://ftp.ubuntu-tw.org/mirror/mariadb/repo/10.6/debian bullseye main" | tee /etc/apt/sources.list.d/mariadb.list \
    && curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list \
    # update and install postgres and mariadb client tools
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
    # Create base dir for backups
    && mkdir -p /opt/backups \
    # clean 
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/wget-hsts

COPY .bashrc /root/.bashrc
WORKDIR /root
ENTRYPOINT ["bash"]