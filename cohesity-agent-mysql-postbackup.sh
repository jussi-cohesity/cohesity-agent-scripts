#!/bin/bash

##
#
# This is example script to use Cohesity Remote Adapter feature to backup MySQL databases
#
# Place this script to Cohesity agent INSTAL_DIR/user_scripts -folder
#
##

BACKUP_DIR=/backup
TODAY=$(date +"%m-%d-%Y")
BACKUP_RETAIN_DAYS=7

DBDELDATE=`date +"%m-%d-%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`

if [ ! -z ${BACKUP_DIR} ]; then
      cd ${BACKUP_DIR}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi 

