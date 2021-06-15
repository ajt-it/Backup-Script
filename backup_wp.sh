#!/bin/bash

#### RAPPORT DE L'EXÉCUTION DU SCRIPT
#exec > /home/scripts/execution.log  ## Fichier a creer au prealable

#### LES ERREURS DURANT L'ÉXÉCUTION DU SCRIPT SERONT RENSEIGNÉES DANS LE FICHIER errors.log
exec 2> /home/scripts/errors.log ## Fichier a créer au prealable

#date du jour
date_backup=$(date +%Y-%m-%d)

#répertoire de sauvegarde
directory_backup=/home/backups/backup-$date_backup
#création du répertoire de backup
/bin/mkdir -p $directory_backup

#### EXÉCUTION DE LA COMPRESSION DES FICHIERS DE WORDPRESS EN .tar.gz
/bin/tar -cvPf $directory_backup/wordpress-$date_backup.tar.gz /var/www/html/wordpress

#### IDENTIFIANTS DE LA BD MySQL: wordpress
userwp=userId
w2pass=password
#### EXÉCUTION DE LA COMPRESSION DES FICHIERS DE MySQL EN .sql.gz
/usr/bin/mysqldump -u $userwp -p$w2pass wordpress | /usr/bin/gzip > $directory_backup/mysqldump-$date_backup.sql.gz

echo " "
echo "Sauvegarde locale effectuée !"
echo " "
echo "Connexion au serveur distant !"

#### IDENTIFIANTS SERVEUR DISTANT POUR CONNECTION FTP
ftp_srv=192.168.1.161
login=userId
pwd=password
port=22
zip_wp=*.tar.gz
zip_bd=*.sql.gz

echo " "
#### RÉPERTOIRE DE DESTINATION DE LA SAUVEGADRE SUR LE SERVEUR DISTANT
destination_backup=/home/ftpuser/backups/site_wp/backup-wp-ftp-$date_backup

echo "Sauvegarde du site WordPress & de sa base de donnée sur le serveur distant : DÉMARRAGE !"

echo " "

#### INITIATION EN FTP DE LA CONNECTION DISTANTE POUR TRANSFERT DE LA SAUVEGARDE LOACALE

cd $directory_backup

lftp sftp://$login:$pwd@$ftp_srv:$port <<EOF
mkdir $destination_backup
cd $destination_backup
mput $zip_wp $zip_bd
bye
EOF

echo "Sauvegarde du site WordPress & de sa base de donnée sur le serveur distant : RÉUSSITE !"

echo " "

#### SUPPRESSION DE LA SAUVEGARDE LOCALE
rm -rf $directory_backup

echo "Connexion au serveur distant pour exécution de la rotation des sauvegardes !"

sshpass -p $pwd ssh $login@$ftp_srv 'cd /home/ftpuser/backups/site_wp/

cd /home/ftpuser/backups/site_wp/

echo " "

dirNumb=$(ls -l | grep ^d | wc -l) ## NOMBRE DE SAUVEGARDE SUR LE SERVEUR DISTANT

echo "Il y a présentement $dirNumb sauvegarde(s) sur le serveur distant !"

echo " "

oldDir=$(ls -tr | head -n 1) ## DÉTECTION DE LA SAUVEGARDE LA PLUS ANCIENNE

echo ".... $oldDir : est la sauvgarde la plus ancienne !"

echo " "
#### EXÉCUTION DE LA ROTATION DES SAUVEGARDES, UN MAXIMUN DE 7 SAUVEGARDES.
if [ "$dirNumb" -gt 7 ] ; then
	rm -rf "$oldDir"
	echo "Suppression de $oldDir"
	else
	echo "Aucune rotation à effectuer !"
fi'
echo " "
echo " FIN DU SCRIPT ! "
echo " "
