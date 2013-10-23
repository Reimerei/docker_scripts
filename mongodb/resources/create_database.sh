#!/bin/bash
set -e

# start mongod
echo Starting mongodb for the first time, this might take some time
mongod -f /data/mongodb.conf &>/dev/null &

# script to create database
cat > /tmp/create_db.js << EOF
db = db.getSiblingDB('<$DATABASE_NAME>')
db.addUser( { user: "$DATABASE_USER",
              pwd: "$DATABASE_PASS",
              roles: [ "readWrite", "dbAdmin" ]
            } )
// shutdown
db = db.getSiblingDB('<admin>')
db.shutdownServer()
EOF

# wait untill mongod accepts connection
until mongo --eval "db.stats()" &> /dev/null
do 
   sleep 2
done

# run script
echo Creating Database: $DATABASE_NAME
mongo /tmp/create_db.js --quiet

# delete script
rm /tmp/create_db.js
