## Consup base os image Dockerfile

This repository contains **Dockerfiles** for 64bit [consup](https://github.com/LeKovr/consup) base os [Docker](https://www.docker.com/) images.

BaseOS image is intended for use by [fidm](https://github.com/LeKovr/fidm) as part of [consup](https://github.com/LeKovr/consup) docker environment.
So you should get both of them and run the following scenario:

```
cd consup
fidm build baseos
fidm build base
fidm build some_app_image

```

### Base image

* [debian:wheezy](https://hub.docker.com/_/debian/)

### Automated Build (64bit only)

If you don't want to build consup_baseos, you can download [automated build](https://registry.hub.docker.com/u/lekovr/consup_base/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): 
`docker pull lekovr/consup_baseos`

Alternatively, you can build an image from Dockerfile by hand:
`docker build -t="lekovr/consup_base" github.com/lekovr/consup/Dockerfiles/baseos`

### License

The MIT License (MIT)
