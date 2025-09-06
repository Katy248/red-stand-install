#!/bin/bash

current_user=$(whoami) || "nobody"

check_root() {
  if [[ "${current_user}" != "root" ]]; then
    print_error "This command should be run as root"
    exit 1
  fi
}
check_no_root() {
  if [[ "${current_user}" == "root" ]]; then
    print_error "This command should NOT be run as root"
    exit 1
  fi
}

ACTION_SPECIFIED=0

parse_cmd() {
  print_log "Start parsing cli args"
  for i in "$@"; do
    case $i in
    # ACTIONS
    -i | --install-programs)
      INSTALL_PROGRAMS=1
      ACTION_SPECIFIED=1
      shift
      ;;
    -d | --disable-screen-lock)
      DISABLE_SCREENLOCKER=1
      ACTION_SPECIFIED=1
      shift
      ;;
    -a | --add-shortcuts)
      ADD_DESKTOP_SHORTCUTS=1
      ACTION_SPECIFIED=1
      shift
      ;;
    -r | --download-rpm)
      DOWNLOAD_RPM=1
      ACTION_SPECIFIED=1
      shift
      ;;
    --destdir=*)
      DESTDIR="${i#*=}"
      shift
      ;;
    -l | --list-programs)
      LIST_PROGRAMS_TO_INSTALL=1
      ACTION_SPECIFIED=1
      shift
      ;;
    --dump-config)
      dump_config
      exit 0
      shift
      ;;
    --add-virt)
      ADD_VIRT=1
      ACTION_SPECIFIED=1
      shift
      ;;
    -\? | -h | --h | --help)
      ACTION_SPECIFIED=1
      print_log "Help command started"
      get_help
      exit 0
      ;;
    -v | --version)
      ACTION_SPECIFIED=1
      program_version="$(git describe --tags)"
      echo "${program_version}"
      exit 0
      ;;
    # OPTIONS
    -m | -md | --md)
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
    # SPECIAL CASES
    --debug | -c=* | --config=*)
      print_log "Unparsed parameter '${i}'"
      shift
      ;;
    -* | --* | *)
      print_error "Unknown option '${i}'"
      echo "Use \`--help\` to show all options"
      exit 1
      ;;
    esac
  done
  print_log "Finish parsing cli args"
}
