# iac.tender.pro backend Makefile
SHELL    = /bin/bash
PRG     ?= $(shell basename $$PWD)

APP_ROOT ?= $$PWD

## настройка контейнера из CI хука
setup:
	@# noop

## стартовать контейнер, предварительно удалив старый, если был
start: stop startonly

## стартовать контейнер, ничего не удаляя
# если make запускается внутри контейнера, должен быть передан APP_ROOT
# иначе достаточно $$PWD
startonly:
	@echo "*** $@ ***"
	@fidm start args_add=--volume=$(APP_ROOT):/home/app \

## остановить и удалить контейнер
stop:
	@echo "*** $@ ***"
	fidm rm

## остановить и удалить контейнер и все контейнеры, от которых он зависит
stopall: $(CFG)
	@echo "*** $@ ***"
	fidm rm -a

# ------------------------------------------------------------------------------
# Docker

## установка зависимостей
deps:
	@echo "*** $@ ***"
	@echo "Consup root: $(CONSUP_ROOT)"
	# code from http://docs.docker.com/linux/step_one/
	which docker > /dev/null || wget -qO- https://get.docker.com/ | sh
	# code from https://github.com/LeKovr/fidm
	which fidm > /dev/null || wget -qO- https://raw.githubusercontent.com/LeKovr/fidm/master/install.sh | sh
	# Каталог **consup** должен быть доступен из каталога **iac** как `../consup` или `../../consup`.
	[[ -d $(CONSUP_ROOT)/consup ]] || cd $(CONSUP_ROOT) && wget -qO- https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
	# контейнеры Docker
	for n in consul ; do docker pull lekovr/consup_$$n ; done
	@echo Done

.PHONY: all start startonly stop stopall deps
