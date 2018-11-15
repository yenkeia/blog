#!/bin/bash

cd /opt/blog
git fetch --all
git reset --hard origin/master
git pull
git submodule update --recursive --remote
hugo

# rm -rf /opt/blog/public
# mkdir -p /opt/blog/static/css
# hugo gen chromastyles --style=trac > static/css/syntax.css
# git submodule update --init --recursive