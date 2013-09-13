#!/bin/bash

while [ true ]; do
        OUT=$(timeout 3 cdda2wav -J -g /dev/sr0 >& /dev/stdout)
        [[ -n `echo $OUT | grep load` ]] && echo "no load" 
        sleep 3
done
