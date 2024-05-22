#!/bin/bash

add_shortcuts() {

    desktop_dir=$(xdg-user-dir DESKTOP)

    for app in $@
    do
        ln -s "/usr/share/applications/$app.desktop" "$desktop_dir/$app.desktop"
    done
}
