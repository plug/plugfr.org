#!/usr/bin/env bash

cd _site

remove_empty_lines ()
{
  TMP=`mktemp -t plug.XXXXXXXX`
  #grep -v -E "^\s*$" "$1" > $TMP
  awk '$0!~/^[ \t]*$/ {print $0}' "$1" > $TMP

  # do not use mv or cp to preserve permissions and owner!
  cat $TMP > "$1"
  rm $TMP
}

EXT="html|xml|css|js|htaccess"

find . -regextype posix-extended -path "./pub" -prune -o -regex ".*\.(${EXT})$" -print | while read F
  do
    echo "    $F"
    remove_empty_lines "$F"
  done

exit 0

