
# Create consup symlink
if [ -d /home/consup ] ; then
  if [ ! -L /home/app/consup ] ; then
    ln -s /home/consup /home/app/consup
  fi
fi
