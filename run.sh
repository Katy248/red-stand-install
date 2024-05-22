#!/bin/bash

chmod +x install.sh

sudo --preserve-env=HOME ./install.sh "$@"
