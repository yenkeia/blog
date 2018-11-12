#!/bin/bash

cd /opt/blog
git pull
# git submodule update --init --recursive
git submodule update --recursive --remote
hugo
