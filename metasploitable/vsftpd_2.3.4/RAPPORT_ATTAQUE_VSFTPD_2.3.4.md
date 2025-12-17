# RAPPORT ATTAQUE SUR METASPLOITABLE AVEC LA VERSION vsftpd 2.3.4 DU PORT 21 
---
machine attaquante : Kali Linux (ip : 192.168.1.97).

machine cible : Metasploitable 2, machine virtuelle Linux volontairement vulnérable conçue pour l'entraînement au pentesting.

<img width="900" height="498" alt="image" src="https://github.com/user-attachments/assets/d48648e4-4ec1-4c44-9d4b-cda2590f97ba" />

 Comme le montre la capture ci-dessus avec la commande ifconfig , la cible est active et connectée au réseau local avec l'adresse IP : 192.168.1.189.

Ensuite, on ping l’adresse de notre machine cible depuis notre terminal Kali pour voir si celle-ci nous réponds :

<img width="945" height="217" alt="image" src="https://github.com/user-attachments/assets/88ffd47b-f249-416e-a784-43ff4fca1956" />

Résultat : 3 paquets reçus sur 3 transmis, les machines sont reliées.

Nous pouvons ainsi ensuite faire un test de nmap type aggresive (pour avoir l’OS , les versions des logiciels et lancer des scripts de détection ) : 

<img width="945" height="381" alt="image" src="https://github.com/user-attachments/assets/7972e127-5a98-4cc0-83e0-6221a449518b" />


On observe ici que le port 21 est ouvert, correspondant au service FTP (file-transfer-protocol) avec la version vsftpd 2.3.4 . D'après les bases de données de vulnérabilités (CVE), la version 2.3.4 de vsftpd est connue pour contenir une backdoor critique permettant une exécution de code à distance. (« le 30 juin 2011 et le 3 juillet 2011, un backdoor a été ajouté dans ce code source. Ce backdoor détecte si le nom de login commence par ":)", et ouvre un shell sur le port 6200/tcp. Un attaquant distant peut donc employer ce backdoor, afin d'accéder au système » Source : viglance.fr)

Ensuite , on lance le framework metasploitable sur notre terminal Kali :

<img width="945" height="656" alt="image" src="https://github.com/user-attachments/assets/223cffae-958a-4f71-ad31-b280ac1dfcec" />


On cherche le module vsftpd (`search vsftpd`) :

<img width="945" height="306" alt="image" src="https://github.com/user-attachments/assets/93c9d16e-b892-4962-8497-763984ab4a1c" />


On charge le module avec le backdoor (`use exploit/unix/ftp/vsftpd_234_backdoor`), en lui indiquant la machine cible à attaquer (`set RHOSTS 192.168.1.189`).Et on lance l’attaque (`run`).

Malheureusement, le framework a affiché le message `Exploit completed, but no session was created `. En effet, ce module utilise une attaque de type Bind Shell. Cela veut dire que l'attaque a bien fonctionné et a ouvert une "porte" sur la victime (le port 6200), mais que mon logiciel n'a pas réussi à entrer dedans automatiquement (sans doute un problème de délai de connexion).

<img width="753" height="201" alt="image" src="https://github.com/user-attachments/assets/0e6d0afb-5f67-41ec-b7b0-654eb5c04469" />

J'ai donc décidé de finir l'intrusion manuellement. Puisque je savais que le port 6200 était maintenant ouvert grâce à l'attaque, j'ai utilisé l'outil Netcat pour m'y connecter directement avec la commande nc 192.168.1.189 6200. La connexion s'est faite immédiatement, et même sans avoir d'affichage classique, j'ai pu taper whoami et confirmer que j'avais bien pris le contrôle de la machine en tant que root.

<img width="703" height="165" alt="image" src="https://github.com/user-attachments/assets/e67c972b-cfc7-4857-98e8-5e08360fad6c" />

