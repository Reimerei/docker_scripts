#!/bin/bash
############################################################################################
#
# MongoDB - Run image
#
# Runs a mongodb image created with init_database.sh. Mounts the existing data directory
# so data will be preserved when the image is restarted. 
#
############################################################################################

# Config
IMAGE_NAME=mongodb
DATA_DIR=$HOME/mongodb

if [ ! -d $DATA_DIR ]; then
	echo The data dir does not exist: $DATA_DIR
	exit 1
fi

# check if the image is already running
sudo docker ps | grep $IMAGE_NAME: > /dev/null
if [ $? -ne "0" ]; then
	sudo docker run -d -v $DATA_DIR/data:/data:rw $IMAGE_NAME 
	sleep 2
fi

# get ip
cid=$(sudo docker ps | grep mongodb: | cut -f1 -d " ")
ip=$(sudo docker inspect $cid | grep IPAddress | cut -d '"' -f 4)

CONFIG=$DATA_DIR/secrets/host.conf

# write to config
cat > $CONFIG << EOF
DATABASE_IP=$ip
DATABASE_PORT=27017
EOF

echo Running on $ip
