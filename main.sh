#!/bin/sh
#This script will backup your targeted directory which only making one .tar.gz file in a day.
#If the backup script are used more than 1 time in a day, the older .tar.gz backup file will
#be replaced by the newer one. 
#
#The name of the backup files are:
#                      backup-[Name of the targeted directory]-[date of backup].tar.gz
#
#The backup logs file are saved in the same directory as the script are placed.

function backup (){
#$1=Source directory
#$2=Backup directory

   LS=` ls --format=single-column $1`
   DATE=` date`

   for FILE in $LS
   do
    #If $FILE is a directory
    if [ -d $1/$FILE ]
    then
      #Backuping the files inside sub-directory
      mkdir $2/Backup-$FILE
      backup $1/$FILE $2/Backup-$FILE
    
    #If $FILE is a file
    elif [ -f $1/$FILE ]
    then
      #Backuping the files
      touch $2/Backup\-$FILE
      echo "#FILE BACKUP TANGGAL $DATE#" >> $2/Backup\-$FILE
      cat $1/$FILE >> $2/Backup\-$FILE
      echo "$DATE $USER telah mem-backup file $1/$FILE." >> $PWD/log-backup
      echo -e "Backuping $1/$FILE..."

    fi
   done
}

#Main program starts here--------------------------------------------------------
DATE=` date +%d-%m-%Y`

echo "Masukkan folder yang ingin di backup : "
read FOLDER

#Checking the available backup directory and log file
if [ ! -d $HOME/Backup ]
then
	mkdir $HOME/Backup
fi

if [ ! -e $PWD/log-backup ]
then
	touch $PWD/log-backup
fi
#----------------------------------------------------


#Starting the backup
NOW=` date`
DEST="$HOME/Backup"

echo  "" >> $PWD/log-backup
echo  "===================== Backup $NOW Started ======================" >> $PWD/log-backup

#Calling function backup
backup $FOLDER $DEST

echo  "=================================== END OF BACKUP ====================================" >> $PWD/log-backup

#Check if there is an old version of the same file backup (same name file)
if [ -e "backup-$FOLDER-$DATE.tar.gz" ]; then
	rm backup-$FOLDER-$DATE.tar.gz
fi
#----------------------------------------------------


#Archiving the backup_directory and delete the backup_directory
tar -czf backup-$FOLDER-$DATE.tar.gz $HOME/Backup
rm -R $HOME/Backup
#----------------------------------------------------

#Backup Finished
echo
echo "Backup selesai."
#----------------------------------------------------
