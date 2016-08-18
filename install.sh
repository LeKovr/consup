#!/bin/sh
# based on https://get.docker.com/ script
set -e
#
# This script installs consup config files for non-developer consup usage via:
#
#   wget -qO- https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
# or
#   curl -sSL https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
#
#  For making changes in consup itself, use git clone

# do not skip install if destination exists
force=$1

# current consup version
ver=v1.1
ver=pgrest-160818

# source repo
prg=consup
url=https://raw.githubusercontent.com/LeKovr/$prg

# source files
files="consul nginx postgres"

# ------------------------------------------------------------------------------
# *** BELOW THERE IS NOTHING TO EDIT ***
# ------------------------------------------------------------------------------
command_exists() {
    command -v "$@" > /dev/null 2>&1
}

# ------------------------------------------------------------------------------
do_install() {

    if [[ ! "$force" ]] && [ -d $prg ] ; then
        echo "Destination dir already exists. Skip install"
        return
    fi
    [ -d $prg ] || mkdir $prg
    curl=''
    if command_exists curl; then
        curl='curl -SOLR'
    elif command_exists wget; then
        curl='wget -N'
    elif command_exists busybox && busybox --list-modules | grep -q wget; then
        curl='busybox wget -N'
    fi

    pushd $prg > /dev/null
    for f in $files ; do
      echo "$f.."
      $curl $url/$ver/$f.yml
    done
    popd > /dev/null
}
# ------------------------------------------------------------------------------

do_install
