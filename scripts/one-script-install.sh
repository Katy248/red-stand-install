#!/bin/bash

install_programs() {
  sudo dnf install git -y
  sudo dnf install lolcat -y
}

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

install_programs

mkdir -p "${dir}"
cd "${dir}" || exit 1
git clone "${repository}" .

sudo bash install.sh --install-programs
bash install.sh --add-shortcuts --disable-screen-lock
