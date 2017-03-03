# Self-hosted Git service

Проект предназначен для развертывания сервиса управления Git в рамках инфраструктуры consup.

В качестве такого сервиса используется [Gitea](https://gitea.io/) (далее по тексту именуется `gogs`).

## Установка

```
$ docker pull lekovr/consup_gogs
$ mkdir gogs && cd gogs
$ docker run --rm lekovr/consup_gogs tar -c -C /skel . | tar x
$ make deps
```

## Настройка

```
APP_SITE=gogs.dev.lan make setup
```

## Использование

```
make start
```

После запуска проект gogs будет доступен по адресу `http://gogs.dev.lan`, все создаваемые при работе проекта файлы будут размещены в текущем каталоге.
Кроме этого, будет использована БД Postgresql (размещается в общем для инфраструктуре контейнере, см. consup_postgres).
