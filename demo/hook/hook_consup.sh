#!/bin/bash

# This script called by webhook
# See hooks.json

# Use inside consup environvent
# Add .web.service.consul suffix to repo url
CONSUP_ENV="1"

. hook_lib.sh

