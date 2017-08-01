#! /bin/bash
if [[ $# -eq 0 ]] ; then
  echo 'please input key'
  exit 1
fi

VBR="2500k"                                    # Bitrate
FPS="30"                                       # FPS
QUAL="ultrafast"                               # Preset
RTMP_URL="rtmp://localhost/live?key=$1"        # URL
SOURCE="0:0"                                   # Source UDP

ffmpeg \
-f avfoundation -framerate 30 \
-i "$SOURCE" -deinterlace \
-vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
-acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
-f flv "$RTMP_URL"
