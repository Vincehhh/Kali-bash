# RAPPORT ATTAQUE JUICE-SHOP KALI

L'objectif de ce projet est d'exploiter certaines failles du top 10 d'OWASP par la découverte du site de OWASP Juice Shop, une boutique en ligne volontairement vulnérable qui permet d'apprendre l'exploitation de ces failles à travers une série de défis pratiques."

## Installation de docker sur la VM Kali 

<img width="1920" height="923" alt="image" src="https://github.com/user-attachments/assets/b23e7ed9-963b-491a-b5d7-ab1ed479963a" />


`sudo`execution de la commande avec privilège root 


`apt`gestionnaire paquets kali


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

## Lancement de Juice Shop

<img width="1920" height="923" alt="image" src="https://github.com/user-attachments/assets/4ac812d2-fe33-4a60-b2fa-310d39f5b667" />


## Lancemenent Burp Suite

*Burp Suite est une application Java, développée par PortSwigger Ltd, qui peut être utilisée pour la sécurisation ou effectuer des tests de pénétration sur les applications web*

On lance Burp et on configure le proxy pour utiliser le navigateur intégré à Burp Suite.

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/e4e48f45-8973-423a-a736-a1d79aa65156" />


url : http://127.0.0.1:3000

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/15254487-feab-416f-8f10-1f80f63095a6" />

On navigue sur le site pour créer des requêtes HTTP qu'on intercepte depuis Burpsuite, et qu'on peut consulter en allant dans l'onglet "HTTP history".

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/c52b8700-93dc-4e44-989a-c57b721962d8" />

On change ensuite la route de l'url de juice shop pour accèder à une page secrète pour obtenir son score d'attaque sur le site. C'est une faille de type 
Broken Access Control et on exploite cette faille avec l'attaque Forced Browsing. En effet , l'application tente de sécuriser l'accès au tableau des scores en ne mettant pas de lien direct. Cependant, en modifiant directement l'URL dans le navigateur pour pointer vers la route /#/score-board (trouvée en analysant les fichiers JavaScript ou par déduction), on contourne cette protection . Aucune vérification de privilèges n'est effectuée par le serveur avant d'afficher cette page sensible.

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/77ab087a-0906-4fc7-b6ce-f4e3fe0ff1fd" />

On teste ensuite l'une des vulnérabilités les plus courantes, l'injection de code SQL dans un formulaire de connection. L'objectif de cette attaque, est d'injecter du code SQL dans une partie du site qui devrait ne pas en accueillir, afin d'obtenir une élévation de privilèges horizontal ou vertical.
Dans notre cas on injecte le code suivant : ' OR 1=1-- . En effet, les requetes SQL pour les mails sont souvent constituer de cette manière : SELECT * FROM users WHERE email = 'email' AND password = 'mdp'. Ainsi, en remplaçant l'email par du code sql qui teste s'il existe un nom d'utilisateurs vide ou si 1=1 (toujours vrai) , cela nous permet d'ignorer le mot de passe et d'accèder à une partie du site que nous devrions pas accèder, ici le compte administrateur.

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/911d0684-7a6b-479d-9cef-c98ca04fc04b" />

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/ff7b053c-94fc-400a-af40-fc39c2da3b4c" />



<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/57713782-9869-4b92-bed8-7b927780c88a" />

Après avoir testé l'injection sql, j'ai voulu vérifier si l'application mettait aussi en danger ses propres utilisateurs. En effet, j'ai ciblé la fonctionnalité de recherche de produits pour tester une faille de type XSS.
Le principe est de voir si le site affiche ce que j'écris sans le nettoyer. Si le site affiche mon texte tel quel, je peux remplacer le texte par du code informatique.
J'ai donc entré le payload suivant dans la barre de recherche : <iframe src="javascript:alert('xss')">. Ce code HTML demande au navigateur de créer un cadre (iframe) qui exécute une commande JavaScript d'alerte.
Le site n'a pas filtré ma commande et l'a incluse directement dans la page de résultats. Ainsi, une fenêtre d'alerte s'est ouverte sur mon écran. Si j'avais été un attaquant réel, j'aurais pu remplacer ce simple message d'alerte par un script invisible qui vole les cookies de session de n'importe quel utilisateur cliquant sur un lien piégé contenant cette recherche, me permettant de pirater leur compte sans même connaître leur mot de passe.

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/286adb02-749a-49a1-a431-66226e7ffcba" />

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/6302d6ef-dba2-4493-ba43-8d991e055cb2" />

Pour finir , j'ai cherché à voir si des fichiers confidentiels étaient stockés de manière non sécurisée sur le serveur me permettant ainsi de tester la faille Security Misconfiguration . J'ai utilisé une technique de "Fuzzing" manuel en testant des noms de répertoires standards (/admin, /backup, /ftp).
En accédant à l'URL /ftp, j'ai découvert que le serveur avait activé le "Directory Listing". Au lieu de m'afficher une erreur ou une page vide, il m'a affiché la liste brute de tous les fichiers contenus dans ce dossier.
J'ai ainsi pu télécharger le fichier acquisitions.md, qui semble contenir des informations imortantes sur l'entreprise. Cette faille est critique car elle permet à n'importe qui de récupérer des documents internes, des sauvegardes de base de données ou du code source sans aucune barrière technique, simplement en trouvant le bon dossier.

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/c7cd2bd5-795f-4c42-b682-f1d6e9c92a69" />

<img width="1100" height="690" alt="image" src="https://github.com/user-attachments/assets/cd0ce2e8-62e7-484a-be9f-15431c1e3c3d" />





