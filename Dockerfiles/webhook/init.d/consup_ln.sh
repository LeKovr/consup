
# Create consup symlink
[ -d /home/consup ] && [ ! -L /home/app/consup ] && ln -s /home/consup /home/app/consup
