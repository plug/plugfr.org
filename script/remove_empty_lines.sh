#!/usr/bin/env bash

cd _site

remove_empty_lines ()
{
  TMP=`mktemp -t plug.XXXXXXXX`
  grep -v -E "^\s*$" "$1" > $TMP

  # do not use mv or cp to preserve permissions and owner!
  cat $TMP > "$1"
  rm $TMP
}

find . \( -name "*.html" -o -name "*.xml" -o -name "*.css" -o -name "*.js" -o -name ".htaccess" \) -print | while read F
  do
    remove_empty_lines "$F"
  done

exit 0

