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


if [[ "${INSTALL_PROGRAMS}" == 1 ]]; then
    
    if [[ "${NO_UPGRADE}" == 0 ]]; then
        update_packages
    fi
    
    add_repositories "${ADDITIONAL_REPOSITORIES[@]}"
    install_packages "${PROGRAMS_TO_INSTALL[@]}"
    if [[ "${NO_UPGRADE}" == 0 ]]; then
        update_packages
    fi
    
    setup_snap
    install_snaps "${SNAPS_TO_INSTALL[@]}"
    
    setup_flathub
    if [[ "${NO_UPGRADE}" == 0 ]]; then
        update_flatpaks
    fi
    install_flatpaks "${FLATPAKS_TO_INSTALL[@]}"
    if [[ "${NO_UPGRADE}" == 0 ]]; then
        update_flatpaks
    fi
fi

if [[ "${DISABLE_SCREENLOCKER}" == 1 ]]; then
    disable_screen_locking
fi

if [[ "${ADD_DESKTOP_SHORTCUTS}" == 1 ]]; then
    print_log "Start adding desktop shortcuts"
    add_shortcuts "${SHORTCUTS_TO_CREATE[@]}"
fi

if [[ "${NOLOGO}" == 0 ]]; then
    print_logo drawings/done.txt
fi
