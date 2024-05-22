#!/bin/bash

add_shortcuts() {

    desktop_dir=$(xdg-user-dirs DESKTOP)

    for app in $@
    do
        ls -s "/usr/share/applications/$app.desktop" "$desktop_dir/$app.desktop"
    done
}
