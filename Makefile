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
consup-app:
	for t in postgres webhook gogs pgrest pgws ; do time fidm build $t || exit ; done

# delete unused containers & images
clean: clean-container clean-noname

# delete unused containers
clean-container:
	docker rm $$(docker ps -a -q)

# delete unused images (w/o name)
clean-noname:
	docker rmi $$(docker images | grep "<none>" | awk "{print \$$3}")
#docker images -q -f dangling=true

clean-volume:
	docker volume rm $(docker volume ls -qf dangling=true)

# delete consup containers
clean-consup:
	docker rmi $$(docker images | grep "consup" | awk "{print \$$1}")

PGC_PROJECT ?= consup
PGC_NAME    ?= postgres
PGC_MODE    ?= common
PGC         ?= $(PGC_PROJECT)_$(PGC_NAME)_$(PGC_MODE)

define EXP_SCRIPT
[[ "$$DB_DUMPDIR" ]] || { echo "DB_DUMPDIR not set. Exiting" ; exit 1 ; } ; \
DB_NAME=$$1 ; \
[[ "$$DB_NAME" ]] || DB_NAME=all ; \
[ -d $$DB_DUMPDIR ] || mkdir $$DB_DUMPDIR || exit 1 ; \
if [[ $$DB_NAME == "all" ]] ; then \
echo "Exporting all databases..." ; \
psql --tuples-only -P format=unaligned \
  -c "SELECT datname FROM pg_database WHERE NOT datistemplate AND datname <> 'postgres'" | \
  while read d ; do echo $$d ; pg_dump -d $$d -Ft | gzip > $$DB_DUMPDIR/$$d.tgz ; done ; \
else \
echo "Exporting database $$DB_NAME..." ; \
pg_dump -d $$DB_NAME -Ft | gzip > $$DB_DUMPDIR/$$DB_NAME.tgz ; \
fi
endef
export EXP_SCRIPT

## dump all databases or named database
pg-exp: pg-start
	@echo "*** $@ ***"
	@echo "$$EXP_SCRIPT" | docker exec -i $(PGC) gosu postgres bash -s - $$DB_NAME

#
## start postgresql container id not running
pg-start:
	@RUNNING=$$(docker inspect --format="{{ .State.Running }}" $(PGC) 2> /dev/null) ; \
[ "$$RUNNING" == "true" ] || fidm start $(PGC_NAME).yml mode=$(PGC_MODE) ; \
echo "Wait for postgresql startup..." ; \
while true; do sleep 1 && ping -c1 localhost > /dev/null 2>&1 && break; done

## stop postgres if running
pg-stop:
	fidm rm $(PGC_NAME) mode=$(PGC_MODE)

## stop postgres & dependensies if running
pg-stopall:
	fidm rm $(PGC_NAME) -a mode=$(PGC_MODE)

psql:
	@echo "*** $@ ***"
	docker exec -ti $(PGC) gosu postgres psql
