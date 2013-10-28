#!/bin/bash

set -e

INSTANCE_NAME=$1
DATA_DIR=$HOME/$INSTANCE_NAME
SECRETS_FILE=$HOME/mongodb/secrets/${INSTANCE_NAME}.conf
HOST_FILE=$HOME/mongodb/secrets/host.conf

# load database credentials
source $SECRETS_FILE
source $HOST_FILE

# write play config file
cat > $DATA_DIR/${INSTANCE_NAME}.conf << EOF

# load docker.conf from repository
include "docker"

# set database url
mongodb.uri="mongodb://${DATABASE_USER}:${DATABASE_PASS}@${DATABASE_IP}:${DATABASE_PORT}/${DATABASE_NAME}"

EOF

