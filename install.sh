#!/bin/bash
. ./scripts.sh
. ./consts.sh
. ./config.sh



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

print_logo() {
    if [[ $(command -v lolcat) != "" ]]; then
        print_log "Program lolcat founded"
        lolcat $1
    else
        print_log "Program lolcat did not found, cat will be used"
        cat $1
    fi
}

load_config "$CONFIG_FILE_PATH"

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
    --config=*)
        CONFIG_FILE_PATH="${i#*=}"
        shift
        ;;
    --debug)
        ENABLE_LOGS=1
        shift
        ;;
    -\?|-h|--help)
        cat docs/help.txt
        exit 0
        ;;
    -*|--*|*)
        print_error "Unknown option '$i'"
        echo "Use \`--help\` to show all options"
        exit 1
        ;;
  esac
done

if [[ "$LIST_PROGRAMS_TO_INSTALL" == 1 ]]; then

    print_header "\`RPM\` packages" 3
    print_list "${PROGRAMS_TO_INSTALL[@]}"

    print_header "\`Snap\` packages" 3
    print_list "${SNAPS_TO_INSTALL[@]}"

    print_header "\`Flatpak\` packages" 3
    print_list "${FLATPAKS_TO_INSTALL[@]}"
    exit 0

fi

if [[ "$NOLOGO" == 0 ]]; then
    print_logo drawings/installation.txt
fi


if [[ "$INSTALL_PROGRAMS" == 1 ]]; then

    if [[ "$NO_UPGRADE" == 0 ]]; then
        update_packages
    fi

    add_repositories "${ADDITIONAL_REPOSITORIES[@]}"
    install_packages "${PROGRAMS_TO_INSTALL[@]}"
    if [[ "$NO_UPGRADE" == 0 ]]; then
        update_packages
    fi

    setup_snap
    install_snaps "${SNAPS_TO_INSTALL[@]}"

    setup_flathub
    if [[ "$NO_UPGRADE" == 0 ]]; then
        update_flatpaks
    fi
    install_flatpaks "${FLATPAKS_TO_INSTALL[@]}"
    if [[ "$NO_UPGRADE" == 0 ]]; then
        update_flatpaks
    fi
fi

if [[ "$DISABLE_SCREENLOCKER" == 1 ]]; then
    disable_screen_locking
fi

if [[ "$ADD_DESKTOP_SHORTCUTS" == 1 ]]; then
    print_log "Start adding desktop shortcuts"
    add_shortcuts "${SHORTCUTS_TO_CREATE[@]}"
fi

if [[ "$NOLOGO" == 0 ]]; then
    print_logo drawings/done.txt
fi
