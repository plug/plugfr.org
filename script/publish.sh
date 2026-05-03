#!/usr/bin/env bash

set -e
[ -n "$DEBUG" ] && set -x

rm -rf _site
mkdir _site

echo "Building site"
bin/jekyll build --quiet

echo "Removing empty lines from generated files"
./script/remove_empty_lines.sh

sitemap='_site/sitemap.xml'

if [ -f $sitemap ]; then
  if [ -f $sitemap.gz ]; then
    rm $sitemap.gz
  fi
  gzip -c $sitemap > $sitemap.gz
fi

echo "Uploading site to 'Evolix hosting10'"
REMOTE=plug@hosting10.evolix.net
rsync -aH --exclude=.git --delete-excluded --delete _site/ ${REMOTE}:www/

echo "Finished : https://plugfr.org/"
