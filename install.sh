#!/usr/bin/bash

update_packages() {
    dnf makecache
    dnf upgrade -y
}
install_packages() {
    for pak in $@
    do
        dnf install -y --skip-broken $pak
    done
}
add_repositories() {
    for repo in $@
    do
        dnf config-manager --add-repo $repo
    done
}

update_packages

add_repositories 'http://repo.code-industry.net/rpm/master-pdf-editor.repo' 'https://packages.microsoft.com/yumrepos/edge/config.repo' './repositories/microsoft-skypre.repo' './repositories/google-chrome.repo'

zoom='https://zoom.us/client/5.17.11.3835/zoom_x86_64.rpm'
chromegost='https://github.com/deemru/Chromium-Gost/releases/download/122.0.6261.112/chromium-gost-122.0.6261.112-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'
anydesk='https://download.anydesk.com/linux/anydesk_6.3.0-1_x86_64.rpm'

install_packages steam firefox yandex-browser-stable microsoft-edge-stable google-chrome-stable $chromegost gimp r7-office master-pdf-editor $myoffice skypeforlinux $zoom $anydesk

update_packages
