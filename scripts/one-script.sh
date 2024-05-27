#!/bin/bash

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git -y
sudo dnf install lolcat -y

mkdir $dir
cd $dir
git clone $repository .

echo "Repository now in '$dir'. Use:"
echo "cd $dir"
echo ""
