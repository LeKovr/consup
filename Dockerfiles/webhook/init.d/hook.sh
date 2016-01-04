
# Create sample hook def

DEST=/home/app/hooks.json

[ -f $DEST ] || cat > $DEST <<EOF
[
  {
    "id": "samplehook",
    "execute-command": "ls -l",
    "command-working-directory": "/home/app"
  }
]
EOF
