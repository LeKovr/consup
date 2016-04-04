# consup project Makefile
# Build docker images with fidm
# https://github.com/LeKovr/fidm

SHELL    = /bin/bash

# build docker image
build-%:
	X=$@ ; fidm build $${X#build-}

# build set of inherited images
consup:
	for t in baseos base baseapp consul nginx postgres ; do time fidm build $t || exit ; done

# build set of nginx-based images
consup1:
	for t in postgres webhook gogs pgrest pgws ; do time fidm build $t || exit ; done

# delete unused containers & images
clean: clean-container clean-noname

# delete unused containers
clean-container:
	docker rm $$(docker ps -a -q)

# delete unused images (w/o name)
clean-noname:
	docker rmi $$(docker images | grep "<none>" | awk "{print \$$3}")

# delete consup containers
clean-consup:
	docker rmi $$(docker images | grep "consup" | awk "{print \$$1}")

