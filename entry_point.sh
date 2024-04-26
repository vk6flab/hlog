#!/bin/bash

if [ ! -d './hlog' ]
then
    /usr/local/libexec/hlog/init-data.sh ./hlog
    cp /src/hlog/README ./README
fi

if [ $# -eq 0 ]
then
	/usr/local/bin/hlog ./hlog
else
	/usr/local/bin/hlog-contest -c "$1" ./hlog
fi
