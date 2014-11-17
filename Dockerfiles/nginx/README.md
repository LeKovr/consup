## Consup nginx image Dockerfile

This repository contains **Dockerfile** for consup nginx image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_nginx/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/)

### Addons

The following packages added to base image:

* [nginx](http://nginx.org/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_nginx/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_nginx`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_nginx" github.com/lekovr/consup/Dockerfiles/nginx`)
   If you prefer [fig](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/fig.yml) and run `fig build nginx`

### Usage

    docker run -it --rm lekovr/consup_nginx

Or running some child image with fig

    $ fig run --rm nginx
    ...
    $ docker exec --ti consup_nginx_run_1 bash
