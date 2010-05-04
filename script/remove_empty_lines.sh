#!/usr/bin/env bash

cd _site

# guess OS based on kernel
# TODO : find a better way to support debian with BSD kernel
test -e /proc # -> 0 if /proc exists (= linux)
if [ $? -eq 0 ]; then
  OS=LINUX
else
  OS=BSD
fi


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

CMD_FIN_OPT_BSD=""
CMD_FIN_OPT_LNX=""

if [ $OS = 'LINUX' ]; then
  CMD_FIND_OPT_LNX='-regextype posix-extended'
else
  CMD_FIND_OPT_BSD='-E'
fi

find ${CMD_FIND_OPT_BSD} . -path "./pub" -prune -o ${CMD_FIND_OPT_LNX} -regex ".*\.(${EXT})$" -print  | while read F
  do
    echo "    $F"
    remove_empty_lines "$F"
  done

exit 0

