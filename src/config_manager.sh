#!/bin/bash

_CONFIG_FILE_NAME='rsirc'

_DEFAULT_CONFIG_FILES=(                     \
    "${HOME}/.config/${_CONFIG_FILE_NAME}"  \
    "${HOME}/.${_CONFIG_FILE_NAME}"         \
    "$(dirname "$0")/${_CONFIG_FILE_NAME}"  \
    "$(dirname "$0")/.${_CONFIG_FILE_NAME}" \
    "/etc/${_CONFIG_FILE_NAME}"             \
)

CONFIG_FILE_PATH=0

parse_cli_config() {
    for i in "$@"; do
        case "${i}" in
            --debug)
                ENABLE_LOGS=1
                print_log "Logs enabled"
                shift
            ;;
            -c=*|--config=*)
                CONFIG_FILE_PATH="${i#*=}"
                print_log "Config file is set to '${i#*=}' via cli"
                shift
            ;;
            *)
                shift
            ;;
        esac
    done
}

load_config_file() {
    print_log "Loading config file '${CONFIG_FILE_PATH}'"
    if test -f "$1" ; then
        . "$1"
        print_log "Config file '$1' loaded"
    else
        print_error "Config file '$1' doesn't exist, continue without config"
    fi
}
load_config() {
    print_log "Start loading configuration"
    
    
    if [[ "${CONFIG_FILE_PATH}" != 0 ]]; then
        load_config_file "${CONFIG_FILE_PATH}"
        return
    fi
    
    for file in "${_DEFAULT_CONFIG_FILES[@]}"; do
        if test -f "${file}" ; then
            CONFIG_FILE_PATH=${file}
            print_log "Config file is set to '${file}'"
            break
        else
            print_log "No config file in '${file}'" "WARN"
        fi
    done
    
    load_config_file "${CONFIG_FILE_PATH}"
}
