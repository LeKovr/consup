## Consup syncthing support image Dockerfile

This repository contains **Dockerfile** for consup syncthing support image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_syncsup/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [lekovr/consup_base](https://registry.hub.docker.com/u/lekovr/consup_base/)

### Addons

The following packages added to base image:

* [syncthing relay server](https://github.com/syncthing/relaysrv/)
* [syncthing discovery server](https://github.com/syncthing/discosrv/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_syncsup/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_syncsup`

### Usage

1. get syncthing.yml from https://github.com/LeKovr/consup
2. place `syncthing.yml` file in sync root folder
3. run `fidm start syncthing.yml`
4. connect to admin interface via `http://127.0.1.2:8384/`

