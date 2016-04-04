## Consup syncthing image Dockerfile

This repository contains **Dockerfile** for consup syncthing image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_lsyncd/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_base](https://registry.hub.docker.com/u/lekovr/consup_base/)

### Addons

The following packages added to base image:

* [syncthing](https://github.com/syncthing/syncthing)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_syncthing/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_syncthing`

### Usage

1. get syncthing.yml from https://github.com/LeKovr/consup
2. place `syncthing.yml` file in sync root folder
3. run `fidm start syncthing.yml`
4. connect to admin interface via `http://127.0.1.2:8384/`

