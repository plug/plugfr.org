#!/usr/bin/env bash

set -e

rm -rf _site
mkdir _site

JEKYLL_OPTIONS='--no-auto'

if which bundle >/dev/null; then
  JEKYLL_BIN='bundle exec jekyll'
else
  JEKYLL_BIN='jekyll'
fi

$JEKYLL_BIN $JEKYLL_OPTIONS

echo "Remove empty lines from generated files"
./script/remove_empty_lines.sh

SITEMAP=_site/sitemap.xml

if [ -f $SITEMAP ]; then
  if [ -f $SITEMAP.gz ]; then
    rm $SITEMAP.gz
  fi
  gzip -c $SITEMAP > $SITEMAP.gz
fi


# Check if we have an access on remote server, so users without access can run this script without "real" error
REMOTE=plug@ssh.tuxfamily.org
# ssh -q -o "BatchMode=yes" ${REMOTE} "echo 2>&1 >/dev/null"

rsync -aH --exclude=.git --delete-excluded --delete _site/ ${REMOTE}:plugfr/plugfr.org-web/htdocs/

echo "Site uploaded to 'TuxFamily' : http://plugfr.org/"

