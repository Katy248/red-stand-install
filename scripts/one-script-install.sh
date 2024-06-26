#!/bin/bash

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git -y
sudo dnf install lolcat -y

mkdir "$dir"
cd "$dir" || exit 1
git clone "$repository" .

sudo bash install.sh --install-programs --disable-screen-lock
bash install.sh --add-shortcuts
