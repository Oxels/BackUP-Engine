#!/bin/sh

#1=Source directory
#2=Backup directory

LS=` ls --format=single-column $1`
DATE=` date`

for FILE in $LS
do

  #If $FILE is a directory
  if [ -d $1/$FILE ]
  then
  
    mkdir $2/Backup-$FILE
    $HOME/./backup.sh $1/$FILE $2/Backup-$FILE
  
  #If $FILE is a file
  elif [ -f $1/$FILE ]
  then
  
    touch $2/Backup\-$FILE
    echo "#FILE BACKUP TANGGAL $DATE#" >> $2/Backup\-$FILE
    cat $1/$FILE >> $2/Backup\-$FILE
    echo "$DATE $USER telah mem-backup file $1/$FILE." >> $PWD/log-backup
    echo -e "Backuping $1/$FILE..."
    
  fi
  
done
