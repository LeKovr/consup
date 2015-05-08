## Consup powerdns image Dockerfile

This repository contains **Dockerfile** for consup powerdns image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_pdns/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image requires **db** and **consul** consup application images.

### Base Docker Image

* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/)

### Addons

The following packages added to base image:

* [PowerDNS](https://www.powerdns.com/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_pdns/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_pdns`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_pdns" github.com/lekovr/consup/Dockerfiles/pdns`)
   Also you can use fig-like tool named [fidm](https://github.com/LeKovr/fidm) than use [config file](https://github.com/LeKovr/consup/blob/master/pdns.yml) and run `fidm build pdns`

### Usage

    docker run -it --rm lekovr/consup_pdns

Or running with dependent images with fidm via pdns.yml

    $ fidm start pdns
    Tag consup_consul_master is active
    Tag consup_postgres_common is active
    Tag consup_consul_master is active
    Creating consup_pdns_master...
    ...
    $ docker exec --ti consup_pdns_master bash

