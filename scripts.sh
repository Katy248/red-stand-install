#!/bin/bash
update_packages() {
    dnf makecache
    dnf upgrade -y
}
update_snap() {
    systemctl enable --now snapd
}
install_snaps() {
    for pak in $@ 
    do
        snap install "$pak"
    done
}
install_flatpaks() {
    for pak in $@ 
    do
        flatpack install "$pak" -y
    done
}
install_packages() {
    for pak in $@
    do
        dnf install -y --skip-broken "$pak"
    done
}
add_repositories() {
    for repo in $@
    do
        dnf config-manager --add-repo "$repo"
    done
}
add_shortcuts() {

    desktop_dir="$HOME/Рабочий стол"
    echo $desktop_dir

    for app in $@
    do
        link_file="/usr/share/applications/$app.desktop"
        if [[ -f "$link_file" ]]; then
            ln -s "$link_file" "$desktop_dir/$app.desktop"
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
