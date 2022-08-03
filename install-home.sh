#!/usr/bin/env bash

if ! command -v home-manager &> /dev/null
then
    echo "home-manager could not be found. Please install home-manager first."
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

NIXPKGS_ALLOW_UNFREE=1 home-manager switch -f "${SCRIPT_DIR}/home.nix"

unset SCRIPT_DIR
