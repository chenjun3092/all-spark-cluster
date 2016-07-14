#!/bin/bash
#https://raw.githubusercontent.com/Lab41/ipython-spark-docker/a73dca291447f4861a97a9716593306b148d0b2a/0-prepare-host.sh

# configure prerequisites
sudo apt-get update
sudo apt-get install --assume-yes wget \
                                  jq \
                                  openssh-server \
                                  openssh-client \

# install docker
wget -qO- https://get.docker.com/ | sh

# create docker group and add user
sudo groupadd docker
sudo usermod -aG docker $(whoami)
