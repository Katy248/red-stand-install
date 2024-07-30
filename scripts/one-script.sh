#!/bin/bash

printf "This script will use sudo, continue?\n"
read -r -p "[Y/n]: " answer
if [[ "${answer^^}" == "N" ]]; then
  printf "Canceled by user\n"
  exit 0
fi

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git -y
sudo dnf install lolcat -y

mkdir "$dir"
git clone "$repository" "$dir"

echo "Repository now in '$dir'. Use:"
echo "cd $dir"
echo ""
