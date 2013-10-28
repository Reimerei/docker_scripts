#!/bin/bash
############################################################################################
#
# MongoDB - Create Image/Add Database
#
# Creates an new mongodb image with an external data directory. 
# This directory is used to persist the state of the image.
#
# If there already is a data directory a new database will be added to it.
#
############################################################################################

# quit if anything goes wrong
set -e

# check arguments
if [ -z $1 ]; then
	echo "Usage: create_database.sh [database_name]"
	exit 1
fi

# Config
DATABASE_NAME=$1
DATABASE_USER=$1
DATABASE_PASS=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1)
DATA_DIR=$HOME/mongodb
IMAGE_NAME=mongodb

if [ -e $DATA_DIR ]; then
	echo Found existing data directory in $DATA_DIR. Adding database to that instance.
else
	echo Creating new data directory in $DATA_DIR
fi

# create directories for data and secrets
mkdir -p $DATA_DIR/data
mkdir -p $DATA_DIR/secrets

# copy resources
cp resources/* $DATA_DIR/data/

# build docker image.
sudo docker build -t $IMAGE_NAME .

# create database
sudo docker run -v $DATA_DIR/data:/data:rw -entrypoint="/data/create_database.sh" -e DATABASE_NAME=$DATABASE_NAME -e DATABASE_USER=$DATABASE_USER -e DATABASE_PASS=$DATABASE_PASS $IMAGE_NAME

# write secrets to file
SECRETS_FILE=$DATA_DIR/secrets/${DATABASE_NAME}.conf 
cat > $SECRETS_FILE << EOF
DATABASE_NAME=$DATABASE_NAME
DATABASE_USER=$DATABASE_USER
DATABASE_PASS=$DATABASE_PASS
EOF
echo "The secrets have been writen to $SECRETS_FILE"
echo DONE
