#
# Consup farm setup file
#

# ------------------------------------------------
# Globals

[[ "$SITE" ]] || SITE=""
[[ "$CMD" ]] || CMD=start
[[ "$CFG" ]] || CFG=farm.cfg

# ------------------------------------------------
# fidm wrapper

fidm_run() {
  local site=$1
  local path=$2
  local html=$3

  [[ "$SITE" ]] && [[ "$SITE" != "$site" ]] && return

  echo "*** SetUp site $site..."
  [[ "$path" == "${path#.}" ]] || path=$PWD${path#.}
  if [[ "$path" != "${path#/}" ]] ; then
    # path starts with "/"
    [[ "$html" ]] || html=html
    echo "  Mount path: $path"
    echo "  html dir: $html"
    fidm $CMD mode=www name=$site args_add="--volume=$path:/home/www" args_add="--env=HTML_DIR=$html"

  elif [[ "$path" ]] ; then
    echo "  Redirect to: $path"
    fidm $CMD mode=redir name=$site args_add="--env=NGINX_REDIR=$path"
  else
    # no path => site used for global redirect
    # push config to required nginx frontend. 
    # included via line in fidm.yml
    # - consup/nginx mode=common

    export ENV_nginx="--env=NGINX_DEFAULT=http://$site"
    echo "ENV_nginx=$ENV_nginx"
  fi
  echo ""
}

# ------------------------------------------------
# Run script

branchname=$1
if [[ "$branchname" ]] ; then
  # run from git hook
  echo "Setup project branch $branchname"
fi

[ -e ~/.fidmrc ] || {
  echo "cfg[creator]=lekovr" > ~/.fidmrc
}

[ -e $CFG ] || {
  echo "File $CFG does not exists."
  echo "See README.md for $CFG example"
  exit 1
}

while read line ; do
    s=${line%%#*} # remove endline comments
    [ -n "${s##+([[:space:]])}" ] || continue # ignore line if contains only spaces

    fidm_run $s
done < $CFG
