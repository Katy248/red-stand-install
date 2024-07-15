#!/bin/bash

get_help() {
    print_header "Usage:" 2
    printf "    $(basename $0) [actions] [options]\n"
    echo ""

    print_header "Actions:"
    column -t -W 2 -s '|' $(dirname $0)/src/help/actions.txt
    echo ""

    print_header "Options:"
    column -t -W 2 -s '|' $(dirname $0)/src/help/options.txt
    echo ""

    print_header "Version:" 2
    echo "    $(version)"
}

version() {
    echo $(git describe)
}


print_log "File './src/help.sh' loaded"
