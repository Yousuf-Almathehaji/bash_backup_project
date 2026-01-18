#!/bin/bash
#

#define the variables
buck_file="Data" #write the path of the dirctory that you want to backup it or write $1 if want the user write the path
time=$(date +"%Y-%m-%d_%H-%M-%S")
targetpath=/home/ubuntu/buckup # you can change the path where you want
file_name=bcukup-file-$time.tar.gz
logfile=/home/ubuntu/buckup/filelogs.log #you can change log file where you want
s3_backet="setting-buckup-for-yousuf" # write the name of your  s3 backet
file_uploud="$targetpath/$file_name" 

#if you let the user enter   the path using $1 remove the comment  from the following section
#check buck_file is not empty

#if [ -z "$1" ]
#then
#	echo "$time  -> enter the file path in the script arugument please" |tee -a "$logfile"
#	exit 2
#fi

#check the existing of Aws CLI
if ! command -v aws &> /dev/null
then
	echo "$time -> You must to install the Aws CLI"| tee -a "$logfile"
	exit 2

fi
#check exit status and the existing of the buckup and doing the buckup in else section.

if [ $? -ne 2 ]
then
	if [ -f $file_name ]
	then
		echo "$time -> Error the buckup $file_name is already exist!" | tee -a "$logfile"
	else
		tar -czvf "$targetpath/$file_name" "$buck_file"
		echo
		echo "$time -> buckup done successfuly: $targetpath/$file_name " |tee -a "$logfile"
		echo 
		#making copy of the backup in aws s3 backet

		aws s3 cp "$file_uploud" "s3://$s3_backet/"

	fi
fi
#check if the backup done successfuly to s3 backeet 
if [ $? -eq 0 ]
then
	echo "$time -> backup to s3 backet done successfuly :$s3_backet" |tee -a "$logfile"
else
	echo "$time -> backup to  s3 backet failed !"|tee -a "$logfile"
fi





