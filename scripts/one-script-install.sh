#!/bin/bash

# printf "This script will use sudo, continue?\n"
# read -r -p "[Y/n]: " answer
# if [[ "${answer^^}" == "N" ]]; then
#   printf "Canceled by user\n"
#   exit 0
# fi

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

pkexec dnf install git -y
pkexec dnf install lolcat -y

mkdir "$dir"
cd "$dir" || exit 1
git clone "$repository" .

pkexec bash install.sh --install-programs --disable-screen-lock
bash install.sh --add-shortcuts
