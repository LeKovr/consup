
# change perms after generation by consul template
# ( name z_* called after [a-y]* )

# DEST Used by gogs install

# This will be removed after switch to consul-template >= 0.11.1

DEST=/opt/gogs/custom/conf
chown -R git $DEST
