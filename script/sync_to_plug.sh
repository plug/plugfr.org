#!/usr/bin/env bash
SITEMAP=_site/sitemap.xml

if [ -f $SITEMAP ]; then
  if [ -f $SITEMAP.gz ]; then
    rm $SITEMAP.gz
  fi
  gzip -c $SITEMAP > $SITEMAP.gz
fi

rsync -avH --exclude=.git --delete-excluded _site/ lecour@lecour.fr:jeremy/plug/