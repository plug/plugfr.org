#!/usr/bin/env bash
gzip _site/sitemap.xml
rsync -avH --exclude=.git --delete-excluded _site/ lecour@lecour.fr:jeremy/plug/