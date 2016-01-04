## Consup node.js image Dockerfile

This repository contains **Dockerfile** for consup nodejs image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_nodejs/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/)

### Addons

The following packages added to base image:

* [webhook](https://github.com/adnanh/webhook)
* [node.js v4.2.4](https://hub.docker.com/_/node/)
* bower, gulp and set of usefull libs

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_nodejs/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_nodejs`

### Usage

    $ docker run -it --rm lekovr/consup_nodejs bower list

or run with [fidm](https://github.com/LeKovr/fidm)

    $ FIDM_CMD="/init.sh bower list --config.analytics=false" fidm start nodejs.yml

### License

The MIT License (MIT)

Copyright (c) 2016 Alexey Kovrizhkin lekovr@gmail.com
