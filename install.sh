install_package() {
	echo "Installing" $1
	dnf install -y --skip-broken $1
}

# update

dnf makecache
dnf upgrade -y

# adding custom repositories

## adding skype repository
cat > /etc/yum.repos.d/microsoft-skype.repo << "EOF"
[microsoft-skype]
name=microsoft-skype
baseurl=https://repo.skype.com/rpm/stable/
enabled=1
gpgcheck=0
EOF

## adding masterPDFeditor repository
dnf config-manager --add-repo http://repo.code-industry.net/rpm/master-pdf-editor.repo
## adding skype repository
dnf config-manager --add-repo https://repo.skype.com/rpm/stable/
## adding ms edge repository 
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge/config.repo



# install software in repos

packages=(gimp firefox steam yandex-browser-stable r7-office master-pdf-editor microsoft-edge-stable skypeforlinux)

for pak in $packages
do
	install_package $pak
done

# install software as .rpm file

chrome='https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
zoom='https://zoom.us/client/5.17.11.3835/zoom_x86_64.rpm'
chromegost='https://github.com/deemru/Chromium-Gost/releases/download/122.0.6261.112/chromium-gost-122.0.6261.112-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'
anydesk='https://download.anydesk.com/linux/anydesk_6.3.0-1_x86_64.rpm'

echo "Start installing Google Chrome, Zoom, Chromiun GOST, MyOffice"
remote_packages=($chrome $zoom $chromegost $myoffice $anydesk)

for pak in $remote_packages
do
	install_package $pak
done


dnf makecache
dnf upgrade -y
