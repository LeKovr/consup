# Build all gitbook items

PROJECT=$1
shift
# setup perms
. /init.sh echo --

# build failed if bad link exists
[ -L html ] && rm html

# build
gosu op gitbook build ./
gosu op gitbook pdf  ./ _book/${PROJECT}.pdf
gosu op gitbook epub ./ _book/${PROJECT}.epub
