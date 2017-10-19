#!/bin/sh


DATE=` date +%d-%m-%Y`

echo "Masukkan folder yang ingin di backup : "

read FOLDER



if [ ! -d $HOME/Backup ]

then
 
	mkdir $HOME/Backup

fi


if [ ! -e $PWD/log-backup ]

then
 
	touch $PWD/log-backup

fi



NOW=` date`

DEST="$HOME/Backup"


echo  "" >> $PWD/log-backup

echo  "===================== Backup $NOW Started ======================" >> $PWD/log-backup


$HOME/./backup.sh $FOLDER $DEST


echo  "=================================== END OF BACKUP ====================================" >> $PWD/log-backup


tar -czf backup-$DATE.tar.gz $HOME/Backup

rm -R $HOME/Backup



echo

echo "Backup selesai."

