#!/bin/bash

mencoder $1 -vobsubout /dev/null -ovc copy -oac mp3lame -lameopts vbr=3 -o $1.tmp
mencoder $1.tmp -sub "$(echo $1 | sed 's/...$/txt/')" -font "/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf" -subfont-autoscale 0 -subfont-text-scale 25 -subpos 100 -utf8 -ovc x264 -x264encopts pass=1:bitrate=2000 -nosound -of avi -o /dev/null
mencoder $1.tmp -sub "$(echo $1 | sed 's/...$/txt/')" -font "/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf" -subfont-autoscale 0 -subfont-text-scale 25 -subpos 100 -utf8 -ovc x264 -x264encopts pass=2:bitrate=2000 -oac mp3lame -lameopts vbr=3 -of avi -o "$(echo $1 | sed 's/...$/avi/')"
#&>/dev/null

