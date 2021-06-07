# Backup-Script
This script (bash) is used to save data and copy it to an external FTP server. The script will rotate the backups (7 days) to avoid an accumulation of these files.
Ce script assiste l'administrateur réseau dans l'automatisation de certaines tâches répétitives de configuration des commutateurs (switchs) Cisco.

Représentation de l'infrastructure :

vb

Pré-requis
Vous aurez besoin d'un accès Telnet sur les cibles, ainsi que d'un même "Username" sur chacun d'entre eux.

Installation
apt install python

chmod +x./python-p6aic-switch.py

Configuration
Vous devez renseigner l'username dans la variable "Username" du fichier python-p6aic-switch.py :

Durant son exécution, le script fera appel au données des fichiers :

switches_list vlans_allowed_trunk vlans_interfaces vlans_number vlans_trunk_interfaces

Exemple de contenu du fichier : 'switches_list' : (il s'agit des adresses IP des équipements à configurer)

192.168.122.61

192.168.122.62

192.168.122.63

Renseignez également le nom (description) de vos vlans. Il s'agit de renseigner ces éléments en cohérence avec votre organisation.

Quelques exemples:
Réalisations de l'exécution des commandes du script :

2

Activités sur le switch:

5

Vérification de creation des vlans:

7
