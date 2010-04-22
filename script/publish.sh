#!/usr/bin/env bash

rm -rf _site/*

jekyll --no-auto

if [ $? -eq 0 ]; then
  echo "Remove empty lines from generated files"
  ./script/remove_empty_lines.sh
fi

if [ $? -eq 0 ]; then
  SITEMAP=_site/sitemap.xml

  if [ -f $SITEMAP ]; then
    if [ -f $SITEMAP.gz ]; then
      rm $SITEMAP.gz
    fi
    gzip -c $SITEMAP > $SITEMAP.gz
  fi

  # rsync -aH --exclude=.git --delete-excluded _site/ lecour@lecour.fr:jeremy/plug/
  rsync -aH --exclude=.git --delete-excluded _site/ plug@ssh.tuxfamily.org:plugfr/plugfr.org-web/htdocs/
  if [ $? -eq 0 ]; then
    echo "Site uploaded to 'TuxFamily' : http://plugfr.org/"
  fi
else
  echo "----"
  echo "Impossible de re-générer le site Jekyll a retourné l'erreur $?"
fi

