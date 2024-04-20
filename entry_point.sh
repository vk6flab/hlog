#!/bin/bash

if [ ! -d './hlog' ]
then
    /usr/local/libexec/hlog/init-data.sh ./hlog
    cp /src/hlog/README ./README
fi

/usr/local/bin/hlog ./hlog
