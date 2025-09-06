#!/bin/bash

. "$(dirname "$0")/src/scripts.sh"

if [[ "${NO_UPGRADE}" == 0 ]]; then
  update_packages
fi

add_repositories "${ADDITIONAL_REPOSITORIES[@]}"
install_packages "${PROGRAMS_TO_INSTALL[@]}"
if [[ "${NO_UPGRADE}" == 0 ]]; then
  update_packages
fi

setup_snap
install_snaps "${SNAPS_TO_INSTALL[@]}"

setup_flathub
if [[ "${NO_UPGRADE}" == 0 ]]; then
  update_flatpaks
fi
install_flatpaks "${FLATPAKS_TO_INSTALL[@]}"
if [[ "${NO_UPGRADE}" == 0 ]]; then
  update_flatpaks
fi
