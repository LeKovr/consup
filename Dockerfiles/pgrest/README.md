## Consup pgrest image Dockerfile

This repository contains **Dockerfile** for consup pgrest image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_pgrest/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_nginx](https://registry.hub.docker.com/u/lekovr/consup_nginx/)

### Addons

The following packages added to base image:

* [PostgRest](https://github.com/begriffs/postgrest)
* [dbrpc](https://github.com/LeKovr/dbrpc)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_pgrest/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_pgrest`

### Usage

    docker run -it --rm lekovr/consup_pgrest

Or running some child image with fig

    $ fig run --rm pgrest
    ...
    $ docker exec --ti consup_pgrest_run_1 bash
