
# Setup container

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

# id - specifies the ID of your hook. This value is used to create the HTTP endpoint (http://yourserver:port/hooks/your-hook-id)
# execute-command - specifies the command that should be executed when the hook is triggered
# command-working-directory

