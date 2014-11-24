## Consup master image Dockerfile

This repository contains **Dockerfile** for consup master image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_master/)
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image linked as master to other consup images.

### Base Docker Image

* [lekovr/consup_base](https://registry.hub.docker.com/u/lekovr/consup_base/)

### Addons

The following packages added to base image:

* [apt-cacher-ng](https://registry.hub.docker.com/_/debian/) - apt repo caching

Also, [consul](https://www.consul.io/) configured in server mode.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_master/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_master`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_master" github.com/lekovr/consup/Dockerfiles/master`)
   If you prefer [fig](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/blob/master/fig.yml) and run `fig build master`

### Usage

    docker run -it --rm lekovr/consup_master

Or running some child image with fig

    $ fig run consup_app
    Starting consup_master_1...
    ...
    $ docker exec --ti consup_master_1 bash

