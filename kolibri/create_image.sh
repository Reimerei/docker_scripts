#!/bin/bash
############################################################################################
#
# Create kolibri image 
#
# Uses the play2_base image to create an image that runs the kolibrinet web app.
# A data directory for the secrets and logs is created.
#
############################################################################################

# quit if anything goes wrong
set -e

# Config
INSTANCE_NAME=kolibri
DATA_DIR=$HOME/$INSTANCE_NAME
IMAGE_NAME=kolibri

# Check if data directory exists
if [ -e $DATA_DIR ]; then
	echo Found existing data directory in "$DATA_DIR". Using the data in that directory 	
else
	# create new config
	mkdir -p $DATA_DIR

	# Check if we have a database config file, ask to create new database if not
	SECRETS_FILE=$HOME/mongodb/secrets/${INSTANCE_NAME}.conf
	if [ -e $SECRETS_FILE ]; then
		echo Using database credentials from $SECRETS_FILE
	else
		echo Could not find file with database credentials. Create new database? "[Y|n]"
		read answer
		if [ "$answer" -eq "n" ]; then
			echo Exiting
			exit 1
		else
			cd ../mongodb
			./create_database $INSTANCE_NAME
			cd -
		fi
	fi

	# load database credentials
	source $SECRETS_FILE

	# write play config file
	cat > $DATA_DIR/${INSTANCE_NAME}.conf << EOF

	# load docker.conf from repository
	inclue "docker"

	# set database url
	# TODO: setup ip and port
	mongodb.uri="mongodb://${DATABASE_USER}:${DATABASE_PASS}@localhost:27017/${DATABASE_NAME}"
EOF
fi

# build docker image.
sudo docker build -t $IMAGE_NAME .



