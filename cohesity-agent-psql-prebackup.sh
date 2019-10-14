#!/bin/bash

##
#
# This is example script to backup PostgreSQL databases
#
# Place this script to Cohesity agent INSTALL_DIR/user_scripts -folder
#
##

BACKUP_DIR=/backup
TODAY=$(date +"%m-%d-%Y")
PSQL="$(which psql)"
PGDUMP="$(which pg_dump)"
GZIP="$(which gzip)"
PGUSER="username"
PGPASSWORD="password"
PGHOST="localhost"
SKIPDATABASES="Database|otherdbtoskip|dontbackup"

# Create directory for todays backup
mkdir -p $BACKUP_DIR/$TODAY

if [ -d $BACKUP_DIR/$TODAY ]; then

        # Get all database list first
        DBS=$($PSQL -l | awk '{ print $1}' | grep -vE '^-|^List|^Name|template[0|1]' | grep -Ev "($SKIPDATABASES)")
        
        if [ "$DBS" == "" ] 
        then
                echo "ERROR! No DBs to protect found. Please check MySQL status!"
                exit 1
        else
                echo "Found DBs to backup: $DBS"
                
                for db in $DBS
                do
                        echo "Dumping DB $db"
                        mkdir -p $BACKUP_DIR/$TODAY/$db
                        $PGDUMP -Fp -U $PGUSER -h $PGHOST $db | $GZIP -9 > $BACKUP_DIR/$TODAY/$db/$db.dump.gz
                done
        fi
fi
