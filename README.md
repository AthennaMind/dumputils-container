## Dumputils

[![build](https://github.com/st3ga/dumputils/actions/workflows/build.yml/badge.svg)](https://github.com/st3ga/dumputils/actions/workflows/build.yml) **`🚀 blazingly-usefull! Please contribute if you have anything to add!`** 

## Table of Contents

**1. [What is it](<#what-is-it>)**  
**2. [What's inside](<#whats-inside>)**  
**3. [Usage](#usage)**  
- **[Aliases](#aliases)**
- **[Run](#run)**
- **[Build](#build)**
- **[Examples](#examples)**

### What is it

This container provides easy access to most dump/restore utils used for managing database backups. It aim to solve the problem of installing different versions of tools and managing dependencies localy. 

### What's inside

- **PostgreSQL Client Tools Version: 11, 12, 13, 14 and 15**
    - **[psql](https://www.postgresql.org/docs/15/app-psql.html)**
    - **[pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)**
    - **[pg_dumpall](https://www.postgresql.org/docs/current/app-pg-dumpall.html)**
    - **[pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html)**

- **Mongo tools version 100.5.2**
    - **mongodump**
    - **mongoexport**   
    - **mongofiles**
    - **mongoimport**  
    - **mongorestore** 
    - **mongostat**
    - **mongotop**

- **[kubectl](https://kubernetes.io/docs/reference/kubectl/) latest stable version** 
- **[MinIO Client](https://min.io/docs/minio/linux/reference/minio-mc.html) latest stable version**
- **[AWS cli](https://aws.amazon.com/cli/) latest stable version**
- **[Redis cli](https://redis.io/docs/manual/cli/) latest stable version**
- **[bat](https://github.com/sharkdp/bat) v0.22.1 for Syntax highlighting** 
- **net-utils, curl, wget for networking debuging**
- **zip, unzip, tar, etc .. for archiving**
- **.bashrc with aliases and nice shell prompt**
- **How To common tricks** 

### Usage

#### Aliases 

The container provides some bash aliases which makes the usage of pg_tools easier 

| Alias           |         Destination                        |
|-----------------|:------------------------------------------:|
| pg_dump12       |  /usr/lib/postgresql/12/bin/pg_dump        |
| pg_dump13       |  /usr/lib/postgresql/13/bin/pg_dump        |
| pg_dump14       |  /usr/lib/postgresql/14/bin/pg_dump        |
| pg_dump15       |  /usr/lib/postgresql/15/bin/pg_dump        |
| pg_restore12    |  /usr/lib/postgresql/12/bin/pg_restore     |
| pg_restore13    |  /usr/lib/postgresql/13/bin/pg_restore     |
| pg_restore14    |  /usr/lib/postgresql/14/bin/pg_restore     |
| pg_restore15    |  /usr/lib/postgresql/15/bin/pg_restore     |
| pg_dumpall12    |  /usr/lib/postgresql/12/bin/pg_dumpall     |
| pg_dumpall13    |  /usr/lib/postgresql/13/bin/pg_dumpall     |
| pg_dumpall14    |  /usr/lib/postgresql/14/bin/pg_dumpall     |
| pg_dumpall15    |  /usr/lib/postgresql/15/bin/pg_dumpall     |


#### Run

The prebuild images are pushed to Github (ghcr.io) and Dockerhub (docker.io). You can use whatever meets your expectations to run the image as follows: 

`The latest tag is stable and suitable for use. It reflects the latest git release tag`

- **Github Registry**

```bash
docker run --rm --name dumputils -h dumputils -v /opt/backups:/opt/backups  -it ghcr.io/st3ga/dumputils:latest /bin/bash
```

- **Docker Registry**

```bash
docker run --rm --name dumputils -h dumputils -v /opt/backups:/opt/backups -it st3ga/dumputils:latest /bin/bash
```

To run specific release version of your choice just use the desired git tag: 

- **Run version 1.0.0**

```bash
docker run --rm --name dumputils -h dumputils -v /opt/backups:/opt/backups -it st3ga/dumputils:1.0.0 /bin/bash
```

#### Build

For restricted environments the image can be build with the above commands. Please note that the main branch is considered unstable. Use the latest release tag. 

```bash
git clone https://github.com/st3ga/dumputils.git
git checkout v1.0.0
docker build -f Dockerfile -t registry.yourdomain.com/dumputils:1.0.0
```



#### Examples

- **Using the container to do manual backup of databases called `sales` inside PostgreSQL Version 12 running in `192.168.1.5:5432`. Upload to AWS s3 bucket called `test` after**

```bash
user@machine: mkdir -p /opt/backups
user@machine: docker run --rm --name dumputils -h dumputils -v /opt/backups:/opt/backups -it st3ga/dumputils:latest

┌─[root@dumputils]─[~]
└──╼: cd /opt/backups/ && export PGPASSWORD="<password>" && pg_dump12 -h 192.168.1.5 -p 5432 -U <user> -F t sales > sales.tar 

┌─[root@dumputils]─[~]
└──╼: export AWS_ACCESS_KEY_ID=<key-id> && export AWS_SECRET_ACCESS_KEY=<acces-key>

┌─[root@dumputils]─[~]
└──╼: aws s3 cp sales.tar s3://test/backups/
```

You can find the tar file in /opt/backups inside your host machine after you exit the container. 