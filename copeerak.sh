#!/bin/bash

while [ true ]; do
        OUT=$(timeout 3 cdda2wav -J -g /dev/sr0 >& /dev/stdout)
        if [[ -n `echo $OUT | grep load` ]]; then
                echo "no load" 
        elif [[ -n `echo $OUT | grep 'This disk has no audio'` ]]; then
                echo "data disc" 
        else
                echo "media CD"
        fi
done
