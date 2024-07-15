#!/bin/bash

get_help() {
    root_dir=$(dirname "$0")
    program_version=$(version)
    
    print_header "Usage:" 2
    printf "    %s [actions] [options]\n" "$(basename "$0")"
    echo ""
    
    
    print_header "Actions:"
    column -t -W 2 -s '|' "${root_dir}/src/help/actions.txt"
    echo ""
    
    print_header "Options:"
    column -t -W 2 -s '|' "${root_dir}/src/help/options.txt"
    echo ""
    
    print_header "Version:" 2
    echo "    ${program_version}"
}

version() {
    "$(git describe)"
}


print_log "File './src/help.sh' loaded"
