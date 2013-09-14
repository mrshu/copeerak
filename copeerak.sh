#!/bin/bash

CD_BLANK=0
CD_DATA=1
CD_MEDIA=2
function cddrive_contents {
        OUT=$(timeout 3 cdda2wav -J -g /dev/sr0 >& /dev/stdout)
        if [[ -n `echo $OUT | grep load` ]]; then
                return $CD_BLANK; 
        elif [[ -n `echo $OUT | grep 'This disk has no audio'` ]]; then
                return $CD_DATA; 
        else
                return $CD_MEDIA; 
        fi
}


while [ true ]; do
        case "
done
