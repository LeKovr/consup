## Consup postgresql image Dockerfile

This repository contains **Dockerfile** for consup postgresql image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_postgres/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image linked as **db** to consup application images.

### Base Docker Image

* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/)

### Addons

The following packages added to base image:

* [Postgresql](http://postgresql.org/) v 9.3 with contrib and plperl
* [check_postgres](http://bucardo.org/wiki/Check_postgres) used as consul health check

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_postgres/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_postgres`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_postgres" github.com/lekovr/consup/Dockerfiles/postgres`)
   If you prefer [fig](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/fig.yml) and run `fig build postgres`

### Usage

    docker run -it --rm lekovr/consup_postgres

Or running some child image with fig

    $ fig run consup_app
    Starting consup_master_1...
    Starting consup_db_1...
    ...
    $ docker exec --ti consup_db_1 bash

