-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

# SCRIPT:
# How to install Docker
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io docker-compose # Remove old versions
sudo apt install docker.io docker-compose
sudo systemctl start docker  # Start Docker
sudo systemctl enable docker # Automate Docker to run at startup
docker --version
# Create a docker-group and add docker and the current user to the group to avoid 'sudo' (permission)
sudo groupadd docker
sudo usermod -aG docker $USER
# If you initially ran Docker CLI commands using sudo before adding your user to the docker group,
# you may see the following error, which indicates that your ~/.docker/ directory was created with
# incorrect permissions due to the sudo commands.

# --> https://docs.docker.com/install/linux/linux-postinstall/

docker info                  # Get run state information
docker images                # List of docker images on your system

# Initiate a Docker image
#docker run -it --name saeed-yocto -v /mnt/yocto-cache/:/mnt/yocto-cache/ beijer/yocto
docker run -it --name saeed-yocto -v ~/yocto-cache:/mnt/yocto-cache -v ~/repo:/repo beijer/yocto

# How to create a docker image from a running container
https://www.scalyr.com/blog/create-docker-image/

## List Docker CLI commands #########################
docker
docker container --help

## Display Docker version and info
docker --version
docker version
docker info

## Execute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -aq


-----------------------------------------------------------


# Docker image configuration/modification script (file: Dockerfile-yocto)

FROM ubuntu:xenial

USER root
RUN apt-get clean && apt-get update && apt-get dist-upgrade -y

# Set loacle to en_US.UTF-8
RUN apt-get install locales
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

# Standard Yocto dependencies
RUN apt-get update && apt-get install --no-install-recommends -y gawk wget git-core diffstat unzip texinfo \
     gcc-multilib build-essential chrpath socat python-dev python3-dev \
     ca-certificates cpio file curl unzip git-core openssh-client

# Our specific dependencies
RUN apt-get update && apt-get install --no-install-recommends -y gnupg2 libunwind8 libcurl3

RUN useradd -m builder
RUN mkdir -p /mnt/yocto-cache /home/builder/.ssh

COPY tempfiles/repo /usr/local/bin/repo
COPY known_hosts /home/builder/.ssh/known_hosts

RUN chown -R builder /home/builder/.ssh/ && \
    chmod a+xr /usr/local/bin/repo && \
    chmod -R u=rwX,go= /home/builder/.ssh/

VOLUME ["/mnt/yocto-cache"]
ENV DL_DIR="/mnt/yocto-cache/downloads/" SSTATE_DIR="/mnt/yocto-cache/sstate-cache"
ENV BB_ENV_EXTRAWHITE="DL_DIR SSTATE_DIR"

USER builder

RUN git config --global user.email "builder@beijer.se" && git config --global user.name "Builder"

-----------------------------------------------------------

# The build command
docker build -t beijer/$basename --file docker-images/Dockerfile-$basename docker-images

-----------------------------------------------------------

# A build script (file: build.sh)
# This builds two images that are called 'beijer/yocto' and 'beijer/yocto-teamcity'

#!/bin/bash -ex
cd $(dirname $(readlink -f "$0"))

# Docker remote file management is crap
wget -P docker-images/tempfiles -N http://teamcity.beijer.se/update/buildAgent.zip
wget -P docker-images/tempfiles -N https://storage.googleapis.com/git-repo-downloads/repo

# Build all images, in correct order for dependencies
for basename in yocto yocto-teamcity; do          # --> Array of two elements: yocto and yocto-teamcity
    docker build -t beijer/$basename --file docker-images/Dockerfile-$basename docker-images
done

# Bring up machines
docker-compose up -d --remove-orphans

-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
