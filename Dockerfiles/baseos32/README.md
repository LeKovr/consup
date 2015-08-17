## Consup base os image Dockerfile

This repository contains **Dockerfiles** for 32bit [consup](https://github.com/LeKovr/consup) base os [Docker](https://www.docker.com/) images.

BaseOS image is intended for use by [fidm](https://github.com/LeKovr/fidm) as part of [consup](https://github.com/LeKovr/consup) docker environment.
So you should get both of them and run the following scenario:

```
cd consup
fidm build baseos32
fidm build base
fidm build some_app_image

```

### Base image

[debian i386](https://hub.docker.com/r/protomouse/debian-i386/)

### License

The MIT License (MIT)
