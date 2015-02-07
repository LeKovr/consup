## Consup base app image Dockerfile

This repository contains **Dockerfile** for consup base app image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_base/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image used as base for consup application images.

### Base Docker Image

* [lekovr/consup_base](https://registry.hub.docker.com/u/lekovr/consup_base/)

### Addons

The following additions has been made to base image:

* Run consul agent linked to master consul server

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_baseapp/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_baseapp`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_baseapp" github.com/lekovr/consup/Dockerfiles/baseapp`)
3. To use image as base, you should tag it: `docker tag CONTAINER_ID lekovr/consup_baseapp`.

### Usage

Place in Dockerfile: `FROM lekovr/consup_baseapp`
