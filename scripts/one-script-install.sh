#!/bin/bash

install_programs() {
  dnf install git -y
  dnf install lolcat -y
}

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

pkexec install_programs

mkdir -p "$dir"
cd "$dir" || exit 1
git clone "$repository" .

sudo bash install.sh --install-programs --disable-screen-lock
bash install.sh --add-shortcuts
