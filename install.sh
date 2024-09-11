#!/bin/bash

. "$(dirname "$0")/src/consts.sh"

. "$(dirname "$0")/src/scripts.sh"

. "$(dirname "$0")/src/help.sh"
. "$(dirname "$0")/src/cmd.sh"
. "$(dirname "$0")/src/config_manager.sh"

parse_cli_config "$@"
load_config
parse_cmd "$@"

print_logo() {
    if [[ "$(command -v lolcat)" != "" ]]; then
        print_log "Program lolcat founded"
        lolcat "$1"
    else
        print_log "Program lolcat did not found, cat will be used"
        cat "$1"
    fi
}

if [[ "${ACTION_SPECIFIED}" == 0 ]]; then
    print_error "No action specified"
    get_help
    exit 0
fi


if [[ "${LIST_PROGRAMS_TO_INSTALL}" == 1 ]]; then
    
    print_header "\`RPM\` packages" 3
    print_list "${PROGRAMS_TO_INSTALL[@]}"
    
    print_header "\`Snap\` packages" 3
    print_list "${SNAPS_TO_INSTALL[@]}"
    
    print_header "\`Flatpak\` packages" 3
    print_list "${FLATPAKS_TO_INSTALL[@]}"
    exit 0
fi

if [[ "${NOLOGO}" == 0 ]]; then
    print_logo drawings/installation.txt
fi

if [[ "${DOWNLOAD_RPM}" == 1 ]]; then
  download_rpm "${DESTDIR}" "${PROGRAMS_TO_INSTALL[@]}"
fi


if [[ "${INSTALL_PROGRAMS}" == 1 ]]; then
    check_root
    . "$(dirname "$0")/src/install-action.sh"
fi

if [[ "${ADD_VIRT}" == 1 ]]; then 
  check_root
  { 
    echo "# Added via red-stand-install script" ; 
    echo "# For more info visit https://github.com/Katy248/red-stand-install" ;
    echo "10.81.11.22 engine.redvirt.tst" ; 
  } >> /etc/hosts
fi

if [[ "${DISABLE_SCREENLOCKER}" == 1 ]]; then
    disable_screen_locking
fi

if [[ "${ADD_DESKTOP_SHORTCUTS}" == 1 ]]; then
    check_no_root
    print_log "Start adding desktop shortcuts"
    add_shortcuts "${SHORTCUTS_TO_CREATE[@]}"
fi

if [[ "${NOLOGO}" == 0 ]]; then
    print_logo drawings/done.txt
fi
