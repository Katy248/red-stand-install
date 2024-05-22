#!/bin/bash

disable_screen_locking() {
    if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
        # disable screen blank
        gsettings set org.gnome.desktop.session idle-delay 0
        # disable autosuspend from ac
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "nothing"
        # disable autosuspend from battery
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "nothing"

        echo "GNOME"
    elif [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
        echo "KDE"
        
    elif [[ "$XDG_CURRENT_DESKTOP" == "MATE" ]]; then
        echo "MATE"
        
    fi
}
