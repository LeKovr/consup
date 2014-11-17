## Consup modperl image Dockerfile

This repository contains **Dockerfile** for consup modperl image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_modperl/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_pgws](https://registry.hub.docker.com/u/lekovr/consup_pgws/)

### Addons

The following packages added to base image:

* [apache](http://httpd.apache.org/) v 1.3.42 with statically linked [mod_perl](http://perl.apache.org/) v 1.31

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_modperl/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_modperl`
   (alternatively, you can build an image from Dockerfile: `docker build -t="consup_modperl" github.com/lekovr/consup/Dockerfiles/modperl`)
   If you prefer [fig](http://www.fig.sh) than use [config file](https://github.com/LeKovr/consup/fig.yml) and run `fig build modperl`

### Usage

    docker run -it --rm lekovr/consup_modperl

Or running some child image with fig

    $ fig run --rm modperl
    ...
    $ docker exec --ti consup_modperl_run_1 bash

### Rebuilding apache modperl .deb packages

    $ cd asset-apache
    $ docker run -ti --rm -v $PWD:/opt -h consup_modperl_build --link consup_master_1:master debian:wheezy /opt/src/init.sh
