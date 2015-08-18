
# ------------------------------------------------

branchname=$1
if [[ "$branchname" ]] ; then
  # run from git hook
  echo "Setup project branch $branchname"
fi

[ -e ~/.fidmrc ] || {
  echo "cfg[creator]=lekovr" > ~/.fidmrc
}

# ------------------------------------------------

NORESTART=1 bash fidm_nb

