#!/bin/sh
#This main.sh will call backup.sh as function

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
