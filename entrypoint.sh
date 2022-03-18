#!/bin/bash

set -e

if [ -z "$ZAPIER_DEPLOY_KEY" ]; then
  echo "ZAPIER_DEPLOY_KEY is required to run commands with the zapier-platform-cli"
  exit 126
fi

sh -c "zapier $*"
