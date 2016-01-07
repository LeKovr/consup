## Consup lsyncd image Dockerfile

This repository contains **Dockerfile** for consup lsyncd image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_lsyncd/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_nginx](https://registry.hub.docker.com/u/lekovr/consup_nginx/)

### Addons

The following packages added to base image:

* [lsyncd](https://gogs.io/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_lsyncd/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_lsyncd`

### Usage

    docker run -it --rm lekovr/consup_lsyncd

Or running some child image with fidm

    $ fidm start lsyncd
