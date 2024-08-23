#!/bin/bash

if [[ -z $INSTALL_PROGRAMS ]]; then
  export INSTALL_PROGRAMS=0
fi

if [[ -z $DISABLE_SCREENLOCKER ]]; then
  export DISABLE_SCREENLOCKER=0
fi

if [[ -z $ADD_DESKTOP_SHORTCUTS ]]; then
  export ADD_DESKTOP_SHORTCUTS=0
fi

if [[ -z $LIST_PROGRAMS_TO_INSTALL ]]; then
  export LIST_PROGRAMS_TO_INSTALL=0
fi

if [[ -z $NOLOGO ]]; then
  export NOLOGO=0
fi

if [[ -z $NO_UPGRADE ]]; then
  export NO_UPGRADE=0
fi

if [[ -z $DEBUG ]]; then
  export DEBUG=0
fi

if [[ -z $ENABLE_MD_FORMAT ]]; then
  export ENABLE_MD_FORMAT=0
fi

if [[ -z $DOWNLOAD_RPM ]]; then
  export DOWNLOAD_RPM=0
fi

if [[ -z $DESTDIR ]]; then
  export DESTDIR="."
fi

if [[ -z $POLKIT ]]; then
  export POLKIT=0
fi
