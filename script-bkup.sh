#!/bin/bash
set -e

source config.env
#define the variables

Timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
Backup_file="backup-$Timestamp.tar.gz"
BACKUP_PATH="$Backup_Dir/$Backup_file"

mkdir -p "$Backup_Dir"

#if you let the user enter   the path using $1 remove the comment  from the following section
#check buck_file is not empty

#if [ -z "$1" ]
#then
#	echo "$time  -> enter the file path in the script arugument please" |tee -a "$logfile"
#	exit 1
#fi

log() {
    echo "$(date +"%F %T") -> $1" | tee -a "$Log_File"
}

#check the existing of Aws CLI
if ! command -v aws &> /dev/null
then
	 log "AWS CLI is not installed. Please install AWS CLI and configure it."
    exit 1

fi
# if you want the user to enter the path of the source backup directory  comment the following if statment
# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    log "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Check if backup file already exists; if not, create the backup in the else section


if [ -f "$BACKUP_PATH" ]
then
	log "Error: the backup $Backup_file already exists at $BACKUP_PATH!"
	
else
	log "Starting backup..."
	tar -czvf "$BACKUP_PATH" "$SOURCE_DIR"		# To allow dynamic source directory, replace $SOURCE_DIR with $1

	log "Local backup created: $BACKUP_PATH"
	
		# Upload a copy of the backup to the AWS S3 bucket

	if aws s3 cp "$BACKUP_PATH" "s3://$S3_Bucket/" 
	then
    	log "Backup uploaded to S3 bucket: $S3_Bucket"
	else
    	log "Error uploading backup to S3!"
    	exit 1
	fi


fi







