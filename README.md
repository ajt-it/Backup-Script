# Backup-Script
Ce script (bash) permet de sauvegarder des données et de les copier sur un serveur FTP externe. 
Le script assurera une rotation (7 jours) des sauvegardes afin d’éviter une accumulation de ces fichiers..

Représentation de l'infrastructure :

![p4](https://user-images.githubusercontent.com/46109209/120953802-581a8e80-c73d-11eb-98c5-d3161e6ce3a4.png)


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
