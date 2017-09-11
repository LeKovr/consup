

# -------------------------------------------------------------------------------
# Install dbinit - database init script

ver=pgrest-160818

# source repo
prg=consup
branch=master
url=https://raw.githubusercontent.com/LeKovr/$prg
name=dbinit.sh

echo "Setup $name from $prg $branch" \
  && curl -OLsS $url/$branch/$name \
  && chmod a+x $name \
  && mv $name /usr/local/sbin/
