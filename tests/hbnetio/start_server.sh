#!/bin/bash

killall netio

ROOT_DIR=netio_root
netio $1 -pass=topsecret -rootdir=`pwd`/$ROOT_DIR -rpc=rpc_processor.hb


#reset

ps ax | grep netio | grep -v grep

netstat -tlpn | grep 2941
