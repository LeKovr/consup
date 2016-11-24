# Setup ssh persistense

# /home/app is a mounted volume
SRC=/home/app/data/ssh

# here are ssh keys placed
DEST=/etc/ssh

if [ -d $SRC ] ; then
  # do not needed local keys
  rm -rf $DEST
else
  # save keys for persistense
  mv $SRC $DEST
fi

# create link
ln -s $SRC $DEST
