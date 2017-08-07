#!/bin/sh
# based on https://get.docker.com/ script
#
# This script installs consup config files for non-developer consup usage via:
#
#   wget -qO- https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
# or
#   curl -sSL https://raw.githubusercontent.com/LeKovr/consup/master/install.sh | sh
#
#  For making changes in consup itself, use git clone
# ------------------------------------------------------------------------------

set -e

# do not skip install if destination exists
force=$1

# current consup version
ver=v1.3

# source repo
prg=consup
url=https://raw.githubusercontent.com/LeKovr/$prg

# source files
files="Makefile consul.yml nginx.yml postgres.yml"

# ------------------------------------------------------------------------------
# *** BELOW THERE IS NOTHING TO EDIT ***
# ------------------------------------------------------------------------------
command_exists() {
    command -v "$@" > /dev/null 2>&1
}

# ------------------------------------------------------------------------------
do_install() {

    if [ -d $prg ] ; then
        if [ ! "$force" ] ; then
            echo "Destination dir '$prg' already exists. Skip install, use '$0 force' to force"
            return
        fi
        echo "Install into existing dir '$prg'.."
    else
        echo "Creating dir $prg.."
        mkdir $prg
    fi
    curl=''
    if command_exists curl; then
        curl='curl -SOLR'
    elif command_exists wget; then
        curl='wget -N'
    elif command_exists busybox && busybox --list-modules | grep -q wget; then
        curl='busybox wget -N'
    fi

    cd $prg
    for f in $files ; do
      echo "$f.."
      $curl $url/$ver/$f
    done
    cd ..
    echo "Done"
}
# ------------------------------------------------------------------------------

do_install
