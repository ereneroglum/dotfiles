#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

NIXPKGS_ALLOW_UNFREE=1 home-manager switch -f "${SCRIPT_DIR}/home.nix"

unset SCRIPT_DIR
