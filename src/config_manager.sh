#!/bin/bash

_CONFIG_FILE_NAME='rsirc'

_DEFAULT_CONFIG_FILES=(                     \
    "${HOME}/.config/${_CONFIG_FILE_NAME}"  \
    "${HOME}/.${_CONFIG_FILE_NAME}"         \
    "$(dirname "$0")/${_CONFIG_FILE_NAME}"  \
    "$(dirname "$0")/.${_CONFIG_FILE_NAME}" \
    "/etc/${_CONFIG_FILE_NAME}"             \
)

for i in "$@"; do
    case "${i}" in
        --debug)
            ENABLE_LOGS=1
            shift
        ;;
        *)
            shift
        ;;
    esac
done
for i in "$@"; do
    case "${i}" in
        --config=*)
            CONFIG_FILE_PATH="${i#*=}"
            shift
        ;;
        *)
            shift
        ;;
    esac
done

load_config_file() {
    if test -f "$1" ; then
        . "$1"
        print_log "Config file '$1' loaded"
    else
        print_error "Config file '$1' doesn't exist"
    fi
}
load_config() {
    for file in "${_DEFAULT_CONFIG_FILES[@]}"; do
        if test -f "${file}" ; then
            CONFIG_FILE_PATH=${file}
            print_log "Config file is set to '${file}'"
            break
        fi
    done
    
    print_log "Loading config file '${CONFIG_FILE_PATH}'"
    load_config_file "${CONFIG_FILE_PATH}"
}
