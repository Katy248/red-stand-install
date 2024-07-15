#!/bin/bash

get_help() {
    print_header "Usage:" 2
    printf "    $(basename $0) <action> [options]...\n"
    echo ""

    print_header "Actions:"
    column -t -W 2 -s '|' $(dirname $0)/docs/actions.txt
    echo ""

    print_header "Options:"
    column -t -W 2 -s '|' $(dirname $0)/docs/options.txt
    echo ""

    printf "${bold}Version:${normal} $(version)\n"
}

version() {
    echo $(git describe)
}


print_log "File './src/help.sh' loaded"
