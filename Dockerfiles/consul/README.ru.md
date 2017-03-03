## Consup consul image Dockerfile

This repository contains **Dockerfile** for consup consul image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_consul/)
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image linked as consul to other consup images.

### Base Docker Image

* [lekovr/consup_base](https://registry.hub.docker.com/u/lekovr/consup_base/)

### Addons

In this image  [consul](https://www.consul.io/) configured in server mode.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_master/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_master`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_master" github.com/lekovr/consup/Dockerfiles/master`)
   If you prefer [docr.sh](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/blob/master/consul.yml) and run `docr.sh consul build`

### Usage

    docker run -it --rm lekovr/consup_master

Or running some child image with docr.sh

    $ docr.sh postgres start
    Starting consup_consul_master...
    Starting consup_postgres_master...
    ...
    $ docker exec --ti consup_consul_master bash

