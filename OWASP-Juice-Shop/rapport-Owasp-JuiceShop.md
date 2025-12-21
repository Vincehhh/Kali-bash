# RAPPORT ATTAQUE JUICE-SHOP KALI

## Installion de docker sur la VM Kali 

<img width="1920" height="923" alt="image" src="https://github.com/user-attachments/assets/b23e7ed9-963b-491a-b5d7-ab1ed479963a" />

`sudo` execution de la commande avec privilège root 

`apt` gestionnaire paquets kali 

`-y` repond automatiquement oui à toutes les questions de confirmation 

`docker.io` nom du paquet dans le dépot kali


<img width="1738" height="222" alt="image" src="https://github.com/user-attachments/assets/badee5c3-e356-4814-92d5-1d9925c134f7" />

`systemctl` permet de gérer le cycle de vie des services

`enable` configure docker pour qu'il se lance automatiquement

`now` permet de demarrer le service instantanément

<img width="1197" height="267" alt="image" src="https://github.com/user-attachments/assets/1b031582-4402-42da-bf6e-39bda81f7809" />

`--rm` : nettoyage automatique. Indique à Docker de supprimer le conteneur et ses fichiers dès qu'il sera arrêté

`-p 3000:3000` : redirection de port (Port Forwarding). Connecte le port 3000 de notre machine Kali au port 3000 du conteneur. C'est ce qui nous permet d'accéder au site via localhost:3000

`bkimminich/juice-shop` : nom de l'image officielle à télécharger et exécuter

## Lancement de juice shop
