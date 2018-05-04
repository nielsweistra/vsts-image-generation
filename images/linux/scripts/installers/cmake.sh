#!/bin/bash
################################################################################
##  File:  cmake.sh
##  Team:  CI-Platform
##  Desc:  This is an example script that can be copied to add a new software
##         installer to the image
################################################################################

## Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

## Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if command -v cmake; then
    echo "Example variable already set to $EXAMPLE_VAR"
else
	curl -sL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.sh -o cmakeinstall.sh \
	&& chmod +x cmakeinstall.sh \
	&& ./cmakeinstall.sh --prefix=/usr/local --exclude-subdir \
	&& rm cmakeinstall.sh
fi

## Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v cmake; then
    echo "cmake was not installed"
    return -1
fi

## Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "cmake ($(cmake -v))"

