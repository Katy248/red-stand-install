#!/bin/bash

update_packages() {
    dnf makecache
    dnf upgrade -y
}
install_packages() {
    for pak in "$@"
    do
        print_log "Installing rpm package '${pak}'"
        dnf install -y --skip-broken "${pak}"
    done
}

download_rpm() {
  local destdir
  destdir="$1"
  print_log "Destination directory for rm download is: '${destdir}'"
  for pak in "${@:2}"; do
    print_log "Downloading '${pak}'"
    dnf download "${pak}" --destdir "${destdir}"
  done
}

setup_snap() {
    systemctl enable --now snapd
}
install_snaps() {
    for pak in "$@"
    do
        print_log "Installing snap package '${pak}'"
        snap install "${pak}"
    done
}
setup_flathub() {
    print_log "Adding flathub repository"
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}
update_flatpaks() {
    print_log "Upgrading flatpaks"
    flatpak upgrade -y
}
install_flatpaks() {
    for pak in "$@"
    do
        flatpak install "${pak}" -y
    done
}
add_repositories() {
    for repo in "$@"
    do
        dnf config-manager --add-repo "${repo}"
    done
}
add_shortcuts() {
    
    desktop_dir="$(xdg-user-dir DESKTOP)"
    print_log "Desktop directory: '${desktop_dir}'"
    
    for shortcut in "$@"
    do
        destination="${desktop_dir}/"
        if [[ -f "${shortcut}" ]]; then
            print_log "Create link for '${shortcut}'"
            ln -s "${shortcut}" "${destination}"
        else
            print_log "Desktop file '${shortcut}' did not found" "WARN"
        fi
    done
}
disable_screen_locking() {
    if [[ "${XDG_CURRENT_DESKTOP}" == "GNOME" ]]; then
        
        # disable screen blank
        gsettings set org.gnome.desktop.session idle-delay 0
        # disable autosuspend from ac
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
        # disable autosuspend from battery
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "nothing"
        
        elif [[ "${XDG_CURRENT_DESKTOP}" == "KDE" ]]; then
        
        lock_config="${HOME}/.config/kscreenlockerrc"
        
        echo "[Daemon]" > "${lock_config}"
        echo "Autolock=false" > "${lock_config}"
        echo "LockOnResume=false" > "${lock_config}"
        echo "Timeout=4" > "${lock_config}"
        echo "LockGrace=5" > "${lock_config}"
        
        elif [[ "${XDG_CURRENT_DESKTOP}" == "MATE" ]]; then
        
        # TODO: Make rules for MATE DE
        print_error "MATE Currently not supported for screenlock disabling"
    fi
}

# Format {{{

red=$(tput setaf 9)
yellow=$(tput setaf 11)
green=$(tput setaf 10)
normal=$(tput sgr0)
bold=$(tput bold)
dim=$(tput dim)
italic=$(tput sitm)
reverse=$(tput rev)

# }}}

print_header() {
    printf "%s" "${bold}"
    if [[ "${ENABLE_MD_FORMAT}" == 1 ]]; then
        
        header=""
        for i in $(seq '1' "${2}"); do
            header="${header}#"
        done
        
        
        printf "%s %s\n\n" "${header}" "${1}"
    else
        printf "%s\n" "${1}"
    fi
    printf "%s" "${normal}"
}

print_list() {
    for item in "$@"
    do
        if [[ "${ENABLE_MD_FORMAT}" == 1 ]]; then
            echo "- ${item}"
        else
            printf "    %s\n" "${item}"
        fi
    done
    if [[ "${ENABLE_MD_FORMAT}" == 1 ]]; then
        echo ""
    fi
}
print_error() {
    echo "${red}ERROR: $1${normal}" >&2 # &2 is stderr
}

print_log() {
    
    color=${green}
    if [[ "$2" == "WARN" ]]; then
        color=${yellow}
    fi
    
    if [[ "${DEBUG}" == 1 ]]; then
        current_date=$(date +%T) || "current date"
        echo "[${current_date}] ${color}${1}${normal}"
    fi
}
