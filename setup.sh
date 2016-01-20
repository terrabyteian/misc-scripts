#!/bin/bash

# Setup script for a droplet that installs various missing packages

yum -y clean all
yum -y update

yum -y install man
yum -y install man-pages
yum -y install vim
yum -y install git
