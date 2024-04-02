repository='https://github.com/Katy248/red-stand-install.git'
dir='install-scripts'

dnf install git

mkdir $dir
cd $dir
git clone $repository .

sudo bash install.sh
