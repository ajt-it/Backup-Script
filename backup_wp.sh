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

echo "Sauvegarde du site WordPress & de sa base de donnée sur le serveur distant : RÉUSSITE !"

echo " "

#### SUPPRESSION DE LA SAUVEGARDE LOCALE
rm -rf $directory_backup

echo "Connexion au serveur distant pour exécution de la rotation des sauvegardes !"

sshpass -p $pwd ssh $login@$ftp_srv 'cd /home/ftpuser/backups/site_wp/

cd /home/ftpuser/backups/site_wp/

echo " "
echo " FIN DU SCRIPT ! "
echo " "
