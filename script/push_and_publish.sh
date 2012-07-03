#!/usr/bin/env bash

set -e

# Push to Github
git push origin

# Push to the Tuxfamily mirror
git push tuxfamily

# Publish

./script/publish.sh