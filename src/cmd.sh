#!/bin/bash

check_root() {
  if [[ "$(whoami)" != "root" ]]; then
    print_error "This command should be run as root"
    exit 1
fi
}
check_no_root() {
  if [[ "$(whoami)" == "root" ]]; then
    print_error "This command should NOT be run as root"
    exit 1
fi
}



parse_cmd(){
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
            LIST_PROGRAMS_TO_INSTALL=1
            shift
            ;;
        -md|--md)
            ENABLE_MD_FORMAT=1
            shift
            ;;
        --nologo)
            NOLOGO=1
            shift
            ;;
        --no-upgrade)
            NO_UPGRADE=1
            shift
            ;;
        --debug|--config=*)
            print_log "Unparsed parameter '$i'"
            shift
            ;;
        -\?|-h|--help)
            print_log "Help command started"
            get_help
            exit 0
            ;;
        -*|--*|*)
            print_error "Unknown option '$i'"
            echo "Use \`--help\` to show all options"
            exit 1
            ;;
    esac
    done
}
