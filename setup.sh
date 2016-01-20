#!/bin/bash

# Setup script for a droplet that installs various missing packages

RED='\033[0;31m'
GREEN='\033[0;32m'
CLR='\033[0m'

LOG="/tmp/setup.log"

function greenprint {
	printf "[$GREEN%s$CLR]\n" $1
}

function redprint {
	printf "[$RED%s$CLR]\n" $1
}

function pipinstall {
	printf "Pip-installing %s... " "$1"
	pip install $1 2>&1 >> $LOG 2>&1
	if [ "$?" != "0" ]; then
		redprint "Failed"
		return 1
	else
		greenprint "Success"
		return 0
	fi
}

function yuminstall {
	printf "Yum-installing %s... " "$1"
	yum -y install $1 >> $LOG 2>&1
	if [ "$?" != "0" ]; then
		redprint "Failed"
		return 1
	else
		greenprint "Success"
		return 0
	fi
}

function run_cmd {
	printf "Performing %s... " "$1"
	$1 >> $LOG 2>&1
	if [ "$?" != "0" ]; then
		redprint "Failed"
		return 1
	else
		greenprint "Success"
		return 0
	fi
}


# Clear log
rm -f $LOG

cd /tmp

# Clean yum cache and update list
run_cmd "yum -y clean all"
run_cmd "yum -y update"

# Install some pkgs through yum
yuminstall man
yuminstall man-pages
yuminstall vim
yuminstall git
yuminstall wget

# Install pip
run_cmd "wget https://bootstrap.pypa.io/get-pip.py"
run_cmd "python get-pip.py"

# Install some python modules with pip
pipinstall virtualenv
pipinstall virtualenvwrapper


printf "\n\nView detailed output in $LOG\n"
