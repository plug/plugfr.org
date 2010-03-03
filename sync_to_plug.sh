#!/usr/bin/env bash

rsync -avH --exclude=.git --delete-excluded _site/ plug@plugfr.org:public_html/demo/