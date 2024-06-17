#!/bin/bash
. ./scripts.sh

INSTALL_PROGRAMS=0
DISABLE_SCREENLOCKER=0
ADD_DESKTOP_SHORTCUTS=0

chromegost='https://github.com/deemru/Chromium-Gost/releases/download/122.0.6261.112/chromium-gost-126.0.6478.56-linux-amd64.rpm'
myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'
anydesk='https://download.anydesk.com/linux/anydesk_6.3.0-1_x86_64.rpm'

PROGRAMS_TO_INSTALL=(firefox yandex-browser-stable microsoft-edge-stable google-chrome-stable gimp r7-office master-pdf-editor thunderbird "$chromegost" "$anydesk" "$myoffice" snapd flatpak)

SNAPS_TO_INSTALL=(skype)

FLATPAKS_TO_INSTALL=("us.zoom.Zoom" "com.valvesoftware.Steam")

red=$(tput setaf 9)
green=$(tput setaf 10)
normal=$(tput sgr0)

check_root() {
  if [[ "$(whoami)" != "root" ]]; then
    echo "${red}This command should be run as root${normal}"
    exit 1
fi
}
check_no_root() {
  if [[ "$(whoami)" == "root" ]]; then
    echo "${red}This command should NOT be run as root${normal}"
    exit 1
fi
}


for i in "$@"; do
  case $i in
    -i|-ip|--install-programs)
        INSTALL_PROGRAMS=1
        check_root
        shift # past argument=value
        ;;
    -ds|--disable-screen-lock)
        DISABLE_SCREENLOCKER=1
        check_root
        shift # past argument=value
        ;;
    -as|--add-shortcuts)
        ADD_DESKTOP_SHORTCUTS=1
        check_no_root
        shift # past argument with no value
        ;;
    --list-programs)
        echo "# \`RPM\` packages"
        echo "---"
        for p in "${PROGRAMS_TO_INSTALL[@]}"; do
            echo "$p"
        done
        echo ""

        echo "# \`Snap\` packages"
        echo "---"
        for p in "${SNAPS_TO_INSTALL[@]}"; do
            echo "$p"
        done
        echo ""

        echo "# \`Flatpak\` packages"
        echo "---"
        for p in "${FLATPAKS_TO_INSTALL[@]}"; do
            echo "$p"
        done
        exit 0
        ;;
    -h|--help)
        cat docs/help.txt
        exit 0
        ;;
    -*|--*|*)
        echo "${red}Unknown option $i ${normal}"
        echo "Use \`--help\` to show all options"
        exit 1
        ;;
  esac
done

if [[ $(command -v lolcat) != "" ]]; then
    lolcat drawings/installation.txt
else
    cat drawings/installation.txt
fi


if [[ "$INSTALL_PROGRAMS" == 1 ]]; then

    update_packages

    add_repositories 'http://repo.code-industry.net/rpm/master-pdf-editor.repo' 'https://packages.microsoft.com/yumrepos/edge/config.repo' './repositories/google-chrome.repo'
    install_packages "${PROGRAMS_TO_INSTALL[@]}"
    update_packages

    setup_snap
    install_snaps "${SNAPS_TO_INSTALL[@]}"

    setup_flathub
    install_flatpaks "${FLATPAKS_TO_INSTALL[@]}"
fi

if [[ "$DISABLE_SCREENLOCKER" == 1 ]]; then
    disable_screen_locking
fi

if [[ "$ADD_DESKTOP_SHORTCUTS" == 1 ]]; then
    add_shortcuts Zoom yandex-browser steam skypeforlinux r7-office-desktopeditors microsoft-edge google-chrome   chromium-gost gimp masterpdfeditor5 myoffice-text-home-edition 
fi

if [[ $(command -v lolcat) != "" ]]; then
    lolcat drawings/done.txt
else
    cat drawings/done.txt
fi
