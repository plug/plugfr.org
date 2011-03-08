#!/usr/bin/env bash

pingUrl="http://blogsearch.google.com/ping"
blogName="PLUG+-+Provence+Linux+User+Group"
blogUrl="http%3A%2F%2Fplugfr.org%2F"
changesURL="http%3A%2F%2Fplugfr.org%2Ffeeds%2Farticles.xml"

url="${pingUrl}?name=${blogName}&url=${blogUrl}&changes=${changesURL}"

if which 'curl' > /dev/null; then
  curl $url
elif which 'wget' > /dev/null; then
  wget -qO- $url | cat
else
  echo "Pas de commande curl ou wget trouvée"
fi