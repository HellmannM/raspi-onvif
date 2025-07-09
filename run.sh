#!/bin/bash

sudo ip link add onvif-1 link wlan0 address aa:aa:aa:aa:aa:a1 type macvlan mode bridge

docker run -d --network=host -e RTSP_RTSPADDRESS="127.0.0.1:554" --name rtsp-simple-server aler9/rtsp-simple-server

rpicam-vid -t 0 --width 1600 --height 1200 --nopreview --exposure long --rotation 0 \
  --sharpness 1.2 --contrast 1.4 --brightness 0.2 --saturation 1.0 --awb auto --denoise auto \
  --codec libav --libav-format avi -n --framerate 10 -b 6200000 --inline \
  --autofocus-mode manual --lens-position 0.5 --autofocus-window 0.25,0.25,0.5,0.5 \
  --profile high --level 4.2 -o - \
  | ffmpeg -re -i - -c:v copy -f rtsp rtsp://localhost:554/mystream

node main.js ./config.yaml

