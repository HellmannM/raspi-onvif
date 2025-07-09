#!/bin/bash

sudo apt install git node npm

git clone https://github.com/daniela-hase/onvif-server.git
pushd onvif-server
npm install
npm config set strict-ssl=false
NODE_TLS_REJECT_UNAUTHORIZED='0' node main.js --create-config
popd

cp config.yaml onvif-server/config.yaml

sudo cp onvif.service /etc/systemd/system/onvif.service
sudo cp onvif /usr/bin/onvif
sudo systemctl enable onvif
sudo systemctl start onvif
sudo systemctl status onvif

