## Consup webhook image Dockerfile

This repository contains **Dockerfile** for consup webhook image
for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/lekovr/consup_webhook/) 
published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Base Docker Image

* [lekovr/consup_nginx](https://registry.hub.docker.com/u/lekovr/consup_nginx/)

### Addons

The following packages added to base image:

* [webhook](https://github.com/adnanh/webhook)
* [webtail](https://github.com/LeKovr/webtail)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/lekovr/consup_webhook/) from public
 [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull lekovr/consup_webhook`

3. Fetch skeleton files for usage example: `docker run --rm lekovr/consup_webhook tar -c -C /skel . | tar x`

### Usage

```
$ make deps
$ make start
```

### License

The MIT License (MIT)

Copyright (c) 2015 Alexey Kovrizhkin lekovr@gmail.com
