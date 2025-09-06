#!/bin/bash

install_programs() {
  pkexec dnf install git lolcat -y
}

repository='https://github.com/Katy248/red-stand-install.git'
start_dir=$(pwd)
dir="${start_dir}/install-scripts"
install_programs

mkdir -p "${dir}"
cd "${dir}" || exit 1
git clone "${repository}" .

pkexec bash "${dir}/install.sh" --install-programs
bash install.sh --add-shortcuts --disable-screen-lock
