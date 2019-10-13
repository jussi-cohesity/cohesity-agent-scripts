#!/bin/bash

##
#
# This is example script to backup MySQL databases
#
# Place this script to Cohesity agent INSTALL_DIR/user_scripts -folder
#
##

BACKUP_DIR=/backup
TODAY=$(date +"%m-%d-%Y")
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
CHOWN="$(which chown)"
CHMOD="$(which chmod)"
GZIP="$(which gzip)"
MYSQL_USER="username"
MYSQL_PASSWORD="password"
MYSQL_HOST="localhost"

# Create directory for todays backup
mkdir -p $BACKUP_DIR/$TODAY

if [ -d $BACKUP_DIR/$TODAY ]; then

        # Get all database list first
        DBS="$($MYSQL -u $MYSQL_USER -h $MYSQL_HOST -p$MYSQL_PASSWORD -Bse 'show databases')"

        for db in $DBS
        do
                $MYSQLDUMP --single-transaction  -u $MYSQL_USER -h $MYSQL_HOST -p$MYSQL_PASSWORD $db | $GZIP -9 > $BACKUP_DIR/$TODAY/$db.dump.gz
        done
fi
