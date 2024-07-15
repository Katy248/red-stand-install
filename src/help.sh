#!/bin/bash

get_help() {
    print_header "Usage:" 2
    printf "    $(basename $0) [options]\n"
    echo ""

    print_header "Options:"
    column -t -W 2 -s '|' $(dirname $0)/docs/help.docs
}


print_log "File './src/help.sh' loaded"
