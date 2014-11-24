## Consup pgws image Dockerfile

This repository contains **Dockerfile** for consup pgws image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_nginx/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/)

### Addons

The following packages added to base image:

* [pgws](http://pgws.jast.ru/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_pgws/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_pgws`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_pgws" github.com/lekovr/consup/Dockerfiles/pgws`)
   If you prefer [fig](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/blob/master/fig.yml) and run `fig build pgws`

### Usage

    docker run -it --rm lekovr/consup_pgws

Or running some child image with fig

    $ fig run --rm pgws
    ...
    $ docker exec --ti consup_pgws_run_1 bash
