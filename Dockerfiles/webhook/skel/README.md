Webhook site
============

Webhook docker image

## Setup

```
APP_SITE=ci.dev.lan make .config
```

## Usage

```
make start
```

## Config

Note that when hook & gogs hosted on same consup site. hook url looks like 
http://ci.dev.lan.web.service.consul/hooks/samplehook

## Use

### Register key at gogs

Project -> Settings -> Deploy keys -> Add deploy key

### Create tag

```
git tag v2
git push --tags
```
This will 
* `git clone` distro 
* run `make .config`
* run `make start-hook`

### Delete tag

```
git tag -d v2
git push --delete origin v2

git push origin :refs/tags/v2
```
