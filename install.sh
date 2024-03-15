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
## adding google chrome repository
cat > /etc/yum.repos.d/google-chrome.repo << "EOF"
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
## adding masterPDFeditor repository
dnf config-manager --add-repo http://repo.code-industry.net/rpm/master-pdf-editor.repo
## adding ms edge repository 
dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge/config.repo

zoom='https://zoom.us/client/5.17.11.3835/zoom_x86_64.rpm'
chromegost='https://github.com/deemru/Chromium-Gost/releases/download/122.0.6261.112/chromium-gost-122.0.6261.112-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'
anydesk='https://download.anydesk.com/linux/anydesk_6.3.0-1_x86_64.rpm'

dnf install -y steam firefox yandex-browser-stable microsoft-edge-stable google-chrome-stable $chromegost gimp r7-office master-pdf-editor $myoffice skypeforlinux $zoom $anydesk

# another update

dnf makecache
dnf upgrade -y
