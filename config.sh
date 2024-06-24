INSTALL_PROGRAMS=0
DISABLE_SCREENLOCKER=0
ADD_DESKTOP_SHORTCUTS=0
LIST_PROGRAMS_TO_INSTALL=0
NOLOGO=0

_DEFAULT_CONFIG_FILE="$(dirname $0)/rsirc"

CONFIG_FILE_PATH=$_DEFAULT_CONFIG_FILE



load_config() {
    print_log "Default config file path: '$_DEFAULT_CONFIG_FILE'"
    print_log "Loading config file '$1'"
    if test -f "$1" ; then
        . "$CONFIG_FILE_PATH"
        print_log "Config file '$1' loaded"
    else
        print_error "Config file '$1' doesn't exist"
    fi
}
