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

STATUS_NO_DISC=0
STATUS_WAITING_FOR_BLANK_MEDIA=1
STATUS_WAITING_FOR_BLANK_DATA=2

STATUS=$STATUS_NO_DISC

while [ true ]; do
        if [[ $STATUS -eq $STATUS_NO_DISC ]]; then
                case cddrive_contents in
                        $CD_MEDIA)
                                cdd2wav dev=0,0,0 -vall cddb=0 -B -Owav
                                STATUS=$STATUS_WAITING_FOR_BLANK_MEDIA
                        ;;
                esac
        fi
        if [[ $STATUS -eq $STATUS_WAITING_FOR_BLANK_MEDIA ]]; then
                case cddrive_contents in
                        $CD_BLANK)
                                cdrecord dev=0,0,0 -v -dao -useinfo -text *.wav
                                rm *.wav
                                STATUS=$STATUS_NO_DISC;
                                ;;
                        *)
                                eject
                                ;;
                esac
        fi

done
