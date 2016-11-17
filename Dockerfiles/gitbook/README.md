## Consup GitBook image Dockerfile

This repository contains **Dockerfile** for consup gitbook image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_gitbook/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [lekovr/consup_nodejs](https://registry.hub.docker.com/u/lekovr/consup_nodejs/)

### Addons

The following packages added to base image:

* [GitBook](https://www.gitbook.com/)
* [Calibre](https://calibre-ebook.com/)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_gitbook/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_gitbook`

### Usage

    $ docker run -it --rm lekovr/consup_gitbook gitbook init

or run with [fidm](https://github.com/LeKovr/fidm)

    $ FIDM_CMD="/init.sh gitbook init" fidm start gitbook.yml

### License

The MIT License (MIT)

Copyright (c) 2016 Alexey Kovrizhkin lekovr@gmail.com
