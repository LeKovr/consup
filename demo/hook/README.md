Webhook Demo site
=================

## Setup

```
APP_SITE=ci.dev.lan make vars
```

## Usage

```
make start
```

## Config

Note that when hook & gogs hosted on same consup site. hook url looks like 
http://ci.dev.lan.web.service.consul/hooks/samplehook

## Use

### Create key
https://developer.github.com/guides/managing-deploy-keys/

```
ssh-keygen -t rsa -b 4096 -f hook_rsa -C "your_email@example.com"
```


### Register key

Project -> Settings -> Deploy keys -> Add deploy key


### Create tag

git tag v2
git push --tags


### Delete tag

git tag -d v2

git push --delete origin v2

git push origin :refs/tags/v2