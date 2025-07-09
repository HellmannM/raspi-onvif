#!/bin/bash

sudo apt install git node npm

git clone https://github.com/daniela-hase/onvif-server.git
pushd onvif-server
npm install
npm config set strict-ssl=false
NODE_TLS_REJECT_UNAUTHORIZED='0' node main.js --create-config
popd

cp config.yaml onvif-server/config.yaml

sudo apt install -y gstreamer1.0-tools gstreamer1.0-rtsp gstreamer1.0-alsa alsa-utils
arecord -L
#surround51:CARD=ICH5,DEV=0
#    Intel ICH5, Intel ICH5
#    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
#default:CARD=U0x46d0x809
#    USB Device 0x46d:0x809, USB Audio
#    Default Audio Device
#Find the audio card of the microfone and take note of its name, for instance default:CARD=U0x46d0x809. Then create a new path that takes the video stream from the camera and audio from the microphone:

sudo cp onvif.service /etc/systemd/system/onvif.service
sudo cp onvif /usr/bin/onvif
sudo systemctl enable onvif
sudo systemctl start onvif
sudo systemctl status onvif

