## Consup base image Dockerfile

This repository contains **Dockerfile** for consup base image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_base/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This image used as base for any other consup images.

### Base Docker Image

[lekovr/consup_baseos](https://hub.docker.com/r/lekovr/consup_baseos/)

### Addons

The following packages added to original debian distro:

* [supervisor](http://supervisord.org/) (latest, via easy_install)
* [consul](https://www.consul.io/) - tool for service discovery, monitoring and configuration
* [confd](https://github.com/kelseyhightower/confd) - Manage local application configuration files using templates
* [gosu](https://github.com/tianon/gosu) - Simple Go-based setuid+setgid+setgroups+exec
* [jq](http://stedolan.github.io/jq) - command-line JSON processor

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_base/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_base`
   (alternatively, you can build an image from Dockerfile: `docker build -t="lekovr/consup_base" github.com/lekovr/consup/Dockerfiles/base`).

3. To use image as base, you should tag it: `docker tag CONTAINER_ID lekovr/consup_base`.

### Usage

Place in Dockerfile: `FROM lekovr/consup_base`

### Environment

The following ENV variables are supported in running container:

* TZ - set container's timezone to given value
