#!/bin/bash

repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

sudo dnf install git -y

mkdir $dir
cd $dir
git clone $repository .

chmode +x install.sh

echo "Repository now in '$dir'. Use:"
echo "cd $dir"
echo ""
