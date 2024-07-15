#!/bin/bash

_chromegost='https://github.com/deemru/Chromium-Gost/releases/download/126.0.6478.56/chromium-gost-126.0.6478.56-linux-amd64.rpm'
_myoffice='https://preset.myoffice-app.ru/myoffice-standard-home-edition-2.7.0-x86_64.rpm'

export ADDITIONAL_REPOSITORIES=(                                \
    'http://repo.code-industry.net/rpm/master-pdf-editor.repo'  \
    'https://packages.microsoft.com/yumrepos/edge/config.repo'  \
    './repositories/google-chrome.repo'                         \
)

export PROGRAMS_TO_INSTALL=(                                            \
    firefox yandex-browser-stable microsoft-edge-stable                 \
    google-chrome-stable gimp r7-office master-pdf-editor thunderbird   \
    "$_chromegost" "$_myoffice"                                         \
    snapd flatpak                                                       \
)

export SNAPS_TO_INSTALL=(skype)

_zoom="us.zoom.Zoom"
_steam="com.valvesoftware.Steam"
_anydesk="com.anydesk.Anydesk"

export FLATPAKS_TO_INSTALL=("${_zoom}" "${_steam}" "${_anydesk}")

_USR_APP_DIR="/usr/share/applications"
_FLATPACK_APP_DIR='/var/lib/flatpak/exports/share/applications'

export SHORTCUTS_TO_CREATE=(                                \
    "${_USR_APP_DIR}/yandex-browser.desktop"                \
    "${_USR_APP_DIR}/r7-office-desktopeditors.desktop"      \
    "${_USR_APP_DIR}/microsoft-edge.desktop"                \
    "${_USR_APP_DIR}/google-chrome.desktop"                 \
    "${_USR_APP_DIR}/chromium-gost.desktop"                 \
    "${_USR_APP_DIR}/gimp.desktop"                          \
    "${_USR_APP_DIR}/masterpdfeditor5.desktop"              \
    "${_USR_APP_DIR}/myoffice-text-home-edition.desktop"    \
    "${_FLATPACK_APP_DIR}/${_steam}.desktop"                \
    "${_FLATPACK_APP_DIR}/${_anydesk}.desktop"              \
    "${_FLATPACK_APP_DIR}/${_zoom}.desktop"                 \
)
# TODO: Add Skype shortcut

