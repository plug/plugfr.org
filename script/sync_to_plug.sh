#!/usr/bin/env bash

rm -rf _site/*

jekyll --no-auto

if [ $? -eq 0 ]; then
  SITEMAP=_site/sitemap.xml
  
  if [ -f $SITEMAP ]; then
    if [ -f $SITEMAP.gz ]; then
      rm $SITEMAP.gz
    fi
    gzip -c $SITEMAP > $SITEMAP.gz
  fi
  
  rsync -aH --exclude=.git --delete-excluded _site/ lecour@lecour.fr:jeremy/plug/
  if [ $? -eq 0 ]; then
    echo "Site uploaded to 'lecour.fr:jeremy/plug/'"
  fi
else
  echo "----"
  echo "Impossible de re-générer le site Jekyll a retourné l'erreur $?"
fi