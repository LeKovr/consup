#!/bin/bash

# This script called by webhook
# See hooks.json

echo "Hook start"

# X-Gogs-Event header
EVENT=$1

echo "Processing event ($EVENT)"

# All json payload
echo "${HOOK_}" | jq '.'

echo "Hook stop"
