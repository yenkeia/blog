#!/bin/bash

cd /opt/blog
# rm -rf /opt/blog/public
git pull
# mkdir -p /opt/blog/static/css
# hugo gen chromastyles --style=trac > static/css/syntax.css
# git submodule update --init --recursive
git submodule update --recursive --remote
hugo
