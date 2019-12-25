#!/bin/bash

killall netio

netio -d -pass=test --rootdir=`pwd`/dbfs

ps ax | grep netio

reset
