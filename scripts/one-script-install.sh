#!/bin/bash

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git lolcat -y

mkdir $dir
cd $dir
git clone $repository .

chmode +x install.sh

sudo --preserve-env=HOME bash install.sh --install-programs --disable-screenlock --add-shortcuts
