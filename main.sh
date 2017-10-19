#!/bin/sh

#backup storage

cek_folder ()
{
  #Backuping the files
for FILE in $LS

do

	if [ -f $FILE ] #Jika $FILE merupakan FILE dan bukan folder

	then

		if [ -f $HOME/$DEST/Backup\-$FILE ] #Jika file sudah ada di bakcup folder, hapus dulu

		then

			rm $HOME/$DEST/Backup\-$FILE

		fi

		touch $HOME/$DEST/Backup\-$FILE

		echo "#FILE BACKUP TANGGAL $DATE#" >> $HOME/$DEST/Backup\-$FILE

		cat $HOME/$DIR/$FILE >> $HOME/$DEST/Backup\-$FILE

		echo "$DATE  $USER telah mem-backup file $HOME/$DIR/$FILE" >> $HOME/$DEST/log-backup\-$DEST

		echo -e "Backuping $HOME/$DIR/$FILE" 

	fi

done
}

##################################################
#Reading source directory and dest directory
#echo "Masukkan directory yang ingin di-backup: "
#read DIR

#echo "Masukkan directory tujuan: "
#read DEST
##################################################

#file directory that would be backuped
DIR=$PWD

echo"Masukkan nama direktori tujuan: "
read DEST

#list all of the files and folders from source directory
LS=` ls --format=single-column $DIR`

#for date documentation when the files are backuped
DATE=` date`


#checking the directory wether is exist or not
if [ ! -d $HOME/$DEST ]
then

	mkdir $HOME/$DEST

fi

#creating logs
if [ ! -f $HOME/$DEST/log-backup-$DEST ]
then

	touch $HOME/$DEST/log-backup-$DEST

fi


#kalau kosong gimana? kalau folder berisi gimana?

echo -e "====================================" >> $HOME/$DEST/log-backup\-$DEST

#Archiving files into .tar.gz file
tar -czf backup-$DATE.tar.gz Backup_temp
mv ./backup-$DATE.tar.gz $HOME/Backups/backup-$DATE.tar.gz
rm $PWD/Backup_temp
