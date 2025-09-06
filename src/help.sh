#!/bin/bash

get_help() {
  root_dir=$(dirname "$0")
  program_name="red-stand-install"
  program_version="$(git describe --tags)"

  print_header "Name:" 2
  printf "    %s - script for setup stand computers on REDOS\n" "${italic}${program_name}${normal}"
  echo ""

  print_header "Usage:" 2
  printf "    %s [actions] [options]\n" "${italic}${program_name}${normal}"
  echo ""

  print_header "Actions:" 2
  column -t -W 2 -s '|' "${root_dir}/src/help/actions.txt"
  echo ""

  print_header "Options:" 2
  column -t -W 2 -s '|' "${root_dir}/src/help/options.txt"
  echo ""

  print_header "Help options:" 2
  column -t -W 2 -s '|' "${root_dir}/src/help/help.txt"
  echo ""

  print_header "Version:" 2
  echo "    ${program_version}"
}

print_log "File './src/help.sh' loaded"
