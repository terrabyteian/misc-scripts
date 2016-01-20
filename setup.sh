#!/bin/bash

# Setup script for a droplet that installs various missing packages

cd /tmp

yum -y clean all
yum -y update

yum -y install man
yum -y install man-pages
yum -y install vim
yum -y install git
yum -y install wget

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install virtualenv
pip install virtualenvwrapper


