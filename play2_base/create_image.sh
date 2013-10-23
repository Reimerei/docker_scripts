#!/bin/bash
############################################################################################
#
# Play2 Base 
#
# Create an image that can be used to run play2 applications. 
# sbt-launch.jar is used to to download and run the play2 enviroment and all dependencies.
#
############################################################################################

# quit if anything goes wrong
set -e

# build docker image
sudo docker build -t play2_base .
