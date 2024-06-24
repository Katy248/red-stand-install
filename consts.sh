chromegost='https://github.com/deemru/Chromium-Gost/releases/download/126.0.6478.56/chromium-gost-126.0.6478.56-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'
anydesk='https://download.anydesk.com/linux/anydesk_6.3.0-1_x86_64.rpm'

ADDITIONAL_REPOSITORIES=(\
'http://repo.code-industry.net/rpm/master-pdf-editor.repo' \
'https://packages.microsoft.com/yumrepos/edge/config.repo' \
'./repositories/google-chrome.repo')

PROGRAMS_TO_INSTALL=(firefox yandex-browser-stable microsoft-edge-stable \
google-chrome-stable gimp r7-office master-pdf-editor thunderbird \
"$chromegost" "$anydesk" "$myoffice" snapd flatpak)

SNAPS_TO_INSTALL=(skype)

FLATPAKS_TO_INSTALL=("us.zoom.Zoom" "com.valvesoftware.Steam")

SHORTCUTS_TO_CREATE=(Zoom yandex-browser steam skypeforlinux \
    r7-office-desktopeditors microsoft-edge google-chrome chromium-gost gimp \
    masterpdfeditor5 myoffice-text-home-edition)
