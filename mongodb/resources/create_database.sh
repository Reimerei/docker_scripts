#!/bin/bash
set -e

# start mongod
echo Preallocating mongodb files in the data directory, this might take some time
mongod -f /data/mongodb.conf &>/dev/null &
pid=$!

# script to create database
cat > /tmp/add_user.js << EOF
db.addUser( { user: "$DATABASE_USER",
              pwd: "$DATABASE_PASS",
              roles: [ "readWrite", "dbAdmin" ]
            } )
EOF

# wait untill mongod accepts connection
until mongo --eval "db.stats()" &> /dev/null
do 
   sleep 2
done

# run script
echo Creating Database: $DATABASE_NAME
mongo $DATABASE_NAME /tmp/add_user.js --quiet

# delete script
rm /tmp/add_user.js

# stop mongo
echo Stopping mongo
kill -2 $pid
