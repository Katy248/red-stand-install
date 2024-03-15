
# update
dnf makecache
dnf upgrade -y

# install software in repos
dnf install -y \
	gimp \
	firefox \
	steam \
	yandex-browser-stable \
	r7-office

# install software as .rpm file
skype='https://repo.skype.com/rpm/stable/skypeforlinux_8.106.0.210-1.x86_64.rpm'
masterpdfeditor='https://code-industry.net/public/master-pdf-editor-5.9.82-qt5.x86_64.rpm'
chrome='https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm'
zoom='https://zoom.us/client/5.17.11.3835/zoom_x86_64.rpm'
chromegost='https://github.com/deemru/Chromium-Gost/releases/download/122.0.6261.112/chromium-gost-122.0.6261.112-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'

dnf install -y \ 
	$skype \
	$masterpdfeditor \
	$chrome \
	$zoom \
	$chromiumgost \
	$myoffice

# install software from other repositories

# adding anydesk repository
cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

# adding ms edge repository
cat > /etc/yum.repos.d/microsoft-edge.repo << "EOF"
[microsoft-edge]
name=microsoft-edge
baseurl=https://packages.microsoft.com/yumrepos/edge/
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# adding masterPDFeditor repository
dnf config-manager --add-repo http://repo.code-industry.net/rpm/master-pdf-editor.repo

dnf install -y \
	anydesk \
	master-pdf-editor \
	microsoft-edge-stable

