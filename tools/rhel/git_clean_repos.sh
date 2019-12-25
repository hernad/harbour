#!/bin/bash

git clean -f
git clean -f -d
git clean -f -X -d
git clean -f -X -d build

git clean -f -x -d

