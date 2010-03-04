#!/usr/bin/env bash

rsync -avH --exclude=.git --delete-excluded _site/ lecour@lecour.fr:jeremy/plug/