#!/bin/bash
############################################################################################
#
# MongoDB - Init
#
# Creates an new mongodb container with an external data directory.
# Database and User are created. They can be used by any container that mounts the 
# data directory
#
############################################################################################

# quit if anything goes wrong
set -e

# Config
DATABASE_NAME=kolibri
DATABASE_USER=kolibri
DATABASE_PASS=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w20 | head -n1)
DATA_DIR=$HOME/mongodb

if [ -e $DATA_DIR ]; then
	echo The data directory "$DATA_DIR" already exists. Delete before creating a new database
	exit 1
fi

# create local directory for data and secrets
mkdir -p $DATA_DIR/data

# copy resources
cp resources/* $DATA_DIR/data/

# build docker image
sudo docker build -t mongodb .

# create database
sudo docker run -v $DATA_DIR/data:/data:rw -entrypoint="/data/create_database.sh" -e DATABASE_NAME=$DATABASE_NAME -e DATABASE_USER=$DATABASE_USER -e DATABASE_PASS=$DATABASE_PASS mongodb

# write secrets to file
cat > $DATA_DIR/secrets.conf << EOF
DATABASE_NAME=$DATABASE_NAME
DATABASE_USER=$DATABASE_USER
DATABASE_PASS=$DATABASE_PASS
EOF

