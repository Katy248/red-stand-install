#!/bin/bash

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git lolcat -y

mkdir $dir
cd $dir
git clone $repository .

sudo bash install.sh --install-programs --disable-screenlock
bash install.sh --add-shortcuts
