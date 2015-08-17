
# Consup farm for static sites

This project allows you to manage a bunch of static websites in single place.

## Requirements

* [Docker](https://www.docker.com/).
* [fidm](https://github.com/LeKovr/fidm)

## Usage

### Create farm.cfg

```
# farm.cfg config file

www.dev.lan/maintenance.html	# Redirect inactive sites there
xxx.dev.lan www.dev.lan		# Redirect to www..
www.dev.lan ./../demo www  	# "." replaced with $PWD
yyy.dev.lan /usr/share/nginx	# Just static site
```

### Make farm up

bash setup.sh

### Make up single site

SITE=yyy.dev.lan bash setup.sh

### Stop whole farm

CMD=stop bash setup.sh

### Stop and drop all farm containers

CMD="rm -a" bash setup.sh

## License

The MIT License (MIT)
