#!/bin/sh
#This main.sh will call backup.sh as function

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

$PWD/backup.sh $FOLDER $DEST

echo  "=================================== END OF BACKUP ====================================" >> $PWD/log-backup

if [ -e backup-$FOLDER-$DATE.tar.gz ]
then
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
