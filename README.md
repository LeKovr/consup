consup
======

[consup](https://github.com/LeKovr/consup) - shared containers orchestration

*Read this in other languages: [English](README.en.md), [Russian](README.md)*

---

This repository aimed to create and use [Docker](https://www.docker.com/) containers with [fidm](https://github.com/LeKovr/fidm) tool and contains:

* [Dockerfiles](Dockerfiles/) - files for docker [automated builds](https://registry.hub.docker.com/u/lekovr/)
* [fidm](https://github.com/LeKovr/fidm) - configs for container running via `fidm start`
* [examples](demo/)

Usage example
-------------

Lets say we need 2 web application containers both uses postgresql.

Web application uses consup_nginx as base container and has the following config (fidm.yml)

```
# container name
image: consup_nginx

# required images
requires:
# frontend nginx routes requests to online containers
- consup/nginx mode=common
# single postgresql instance for every which wants "mode=common"
- consup/postgres mode=common

# link master service registration database
links:
- consup/consul    # consul.yml

```

Running `fidm start` in application dir will start its container and all not started dependencies.

All containers with same row `consup/postgres mode=common` in config will use the same postgresql database cluster

Dependensies
------------

* linux 64bit (git, make, wget)
* [Docker](http://docker.io)
* [fidm](https://github.com/LeKovr/fidm)

Install
-------

For dealing with prepared containers:
```
wget -qO- https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
```

For Dockerfile development:
```
git clone https://github.com/LeKovr/consup.git
```

Applications supported
----------------------

See Dockerfiles/*/ for details

Container structure
-------------------

![Container structure](doc/consup.png)

License
-------

The MIT License (MIT), see [LICENSE](LICENSE).

Copyright (c) 2016 Alexey Kovrizhkin ak@elfire.ru
