# nodejs consup sample

## Setup

```
make gulp-install
make build
```

## Usage

### Bower

```
# Install and register package
PKG=angularjs make bower-install

# Search
PKG=angularjs make bower-search

# Simple command
make bower-list
```

### Gulp: run target

```
# Target named build:html
make gulp-build:html
```

## Notes

* [gulpfile.js based on](http://habrahabr.ru/post/250569/)
* [Kickstarting Angular With Gulp and Browserify](http://mherman.org/blog/2014/08/14/kickstarting-angular-with-gul)

