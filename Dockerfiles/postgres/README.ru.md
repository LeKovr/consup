Проект [ConSup](https://github.com/LeKovr/consup/README.ru.md)

| --- :|
| [English](README.md) |

# Контейнер postgresql

Репозиторий содержит **Dockerfile** и необходимые файлы для сборки контейнера consup_postgresql
для [автоматической сборки](https://registry.hub.docker.com/u/lekovr/consup_postgres/) и публикации в
[Docker Hub Registry](https://registry.hub.docker.com/).

## Базовый контейнер

* [baseapp](../baseapp/README.ru.md) - исходник
* [lekovr/consup_baseapp](https://registry.hub.docker.com/u/lekovr/consup_baseapp/) - сборка

## Дополнения

Следующие пакеты добавляются к базовому образу при сборке:

* [Postgresql](http://postgresql.org/) с contrib and plperl
* [check_postgres](http://bucardo.org/wiki/Check_postgres), используется как consul health check
* [dbcc](https://github.com/LeKovr/dbcc), используется для автоматического создания БД и пользователей

## Установка и использование

Контейнер предназначен для работы в инфраструктуре consup и она должна быть предварительно развернута.

Для непосредственной работы с БД необходимо после этого выполнить `docker pull lekovr/consup_postgres`, после этого в каталоге consup можно запустить клиента СУБД командой `make psql`.

Однако, основной сценарий использования контейнера в том, что он указывается в зависимостях использующих его сервисов.
При установке такого сервиса, контейнер будет установлен при выполнении команды `make deps-pg`.
