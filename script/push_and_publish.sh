#!/usr/bin/env bash

set -e

# Push to Github
git push origin master

# Push to the Tuxfamily mirror
git push tuxfamily master

# Publish

./script/publish.sh