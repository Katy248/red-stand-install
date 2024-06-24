#!/bin/bash
update_packages() {
    dnf makecache
    dnf upgrade -y
}
install_packages() {
    for pak in $@
    do
        dnf install -y --skip-broken "$pak"
    done
}
setup_snap() {
    systemctl enable --now snapd
}
install_snaps() {
    for pak in $@ 
    do
        snap install "$pak"
    done
}
setup_flathub() {
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
update_flatpaks() {
    flatpak upgrade -y
}
install_flatpaks() {
    for pak in $@ 
    do
        flatpak install "$pak" -y
    done
}
add_repositories() {
    for repo in $@
    do
        dnf config-manager --add-repo "$repo"
    done
}
add_shortcuts() {

    desktop_dir="$(xdg-user-dir DESKTOP)"
    print_log "Desktop directory: '$desktop_dir'"

    for app in $@
    do
        print_log "Trying to add '$app' shortcut"
        link_file="/usr/share/applications/$app.desktop"
        destination_file="$desktop_dir/$app"
        if [[ -f "$link_file" ]]; then
            print_log "Desktop file path for '$app': '$link_file'"
            ln -s "$link_file" "$destination_file"
        else
            print_log "Icon for '$app' did not found" "WARN"
        fi
    done
}
disable_screen_locking() {
    if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then

        # disable screen blank
        gsettings set org.gnome.desktop.session idle-delay 0
        # disable autosuspend from ac
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
        # disable autosuspend from battery
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "nothing"

    elif [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then

        lock_config="~/.config/kscreenlockerrc"

        echo "[Daemon]" > "$lock_config"
        echo "Autolock=false" > "$lock_config"
        echo "LockOnResume=false" > "$lock_config"
        echo "Timeout=4" > "$lock_config"
        echo "LockGrace=5" > "$lock_config"
        
    elif [[ "$XDG_CURRENT_DESKTOP" == "MATE" ]]; then
        
        # TODO: ---
        echo "MATE"
        
    fi
}

ENABLE_LOGS=0

ENABLE_MD_FORMAT=0

# Format {{{
red=$(tput setaf 9)
yellow=$(tput setaf 11)
green=$(tput setaf 10)
normal=$(tput sgr0)
bold=$(tput bold)
# }}}

print_header() {
    printf ${bold}
    if [[ "$ENABLE_MD_FORMAT" == 1 ]]; then
        printf "### $@\n\n"
    else
        printf "$@:\n"
    fi
    printf ${normal}
}

print_list() {
    for item in $@
    do
        if [[ "$ENABLE_MD_FORMAT" == 1 ]]; then
            echo "- $item"
        else
            printf "  $item\n"
        fi
    done
    if [[ "$ENABLE_MD_FORMAT" == 1 ]]; then
        echo ""
    fi
}
print_error() {
    echo "${red}$1${normal}" >&2 # &2 is stderr 
}

print_log() {

    color=$green
    if [[ "$2" == "WARN" ]]; then
        color=$yellow
    fi

    if [[ "$ENABLE_LOGS" == 1 ]]; then
        echo "$(date +%T) ${color}$1 ${normal}"
    fi
}
