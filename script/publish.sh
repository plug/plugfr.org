#!/usr/bin/env bash

set -e
[ -n "$DEBUG" ] && set -x

rm -rf _site
mkdir _site

bin/jekyll build

echo "Remove empty lines from generated files"
./script/remove_empty_lines.sh

sitemap='_site/sitemap.xml'

if [ -f $sitemap ]; then
  if [ -f $sitemap.gz ]; then
    rm $sitemap.gz
  fi
  gzip -c $sitemap > $sitemap.gz
fi


# Check if we have an access on remote server, so users without access can run this script without "real" error
REMOTE=plug@ssh.tuxfamily.org
# ssh -q -o "BatchMode=yes" ${REMOTE} "echo 2>&1 >/dev/null"

rsync -aH --exclude=.git --delete-excluded --delete _site/ ${REMOTE}:plugfr/plugfr.org-web/htdocs/

echo "Site uploaded to 'TuxFamily' : http://plugfr.org/"

