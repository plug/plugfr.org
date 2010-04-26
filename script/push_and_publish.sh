#!/usr/bin/env bash

# Push to Github
git push origin

# Push to the Tuxfamily mirror
git push tuxfamily

# Publish

./script/publish.sh