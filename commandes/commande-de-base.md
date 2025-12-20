# Commande de base Linux (Linux Fondamentals-TryHackMe)

## 1. Navigation et Système

### Commande : `pwd`

**Print Working Directory**. Cette commande te permet de savoir exactement où l'on se trouve dans l'arborescence du système.

```shell
pwd
```

**Exemple d'exécution :**

```shell
$ pwd
/home/tryhackme/Documents
```

---

### Commande : `ls`

**List**. Liste les fichiers et dossiers du répertoire actuel.

- Option utile : `-la` (liste tous les fichiers, y compris les cachés, avec les détails).
    

Bash

```shell
ls [options]
```

**Exemple d'exécution :**

```shell
$ ls -la
drwxr-xr-x 2 user user 4096 Jan 01 12:00 .
-rw-r--r-- 1 user user  220 Jan 01 11:00 .bashrc
-rw-r--r-- 1 user user   15 Jan 01 12:00 notes.txt
```

---

### Commande : `cd`

**Change Directory**. Permet de naviguer d'un dossier à un autre.


```shell
cd <chemin_du_dossier>
```

**Exemple d'exécution :**

```shell
$cd /var/www/html$ pwd
/var/www/html
```

> **Note :** `cd ..` permet de revenir au dossier précédent (parent), et `cd ~` ramène au dossier personnel.

---

## 2. Manipulation de Fichiers

### Commande : `cat`

**Concatenate**. Affiche le contenu complet d'un fichier dans le terminal.

```shell
cat <nom_du_fichier>
```

**Exemple d'exécution :**

```shell
$ cat flag.txt
THM{L1nux_1s_Aw3som3}
```

---

### Commande : `touch`

Crée un fichier vide s'il n'existe pas, ou met à jour la date de modification s'il existe déjà.

```shell
touch <nom_du_fichier>
```

**Exemple d'exécution :**

```shell
$touch scan_resultats.txt$ ls
scan_resultats.txt
```

---

### Commande : `mkdir`

**Make Directory**. Crée un nouveau dossier.

```shell
mkdir <nom_du_dossier>
```

**Exemple d'exécution :**

```shell
$ mkdir backups
```

---

### Commande : `cp`

**Copy**. Copie un fichier ou un dossier.

Option obligatoire pour copier un dossier : `-r` (récursif).

```shell
cp <source> <destination>
```

**Exemple d'exécution :**

```shell
$ cp rapport.txt /home/user/Documents/
```

---

### Commande : `mv`

**Move**. Sert à deux choses : déplacer un fichier OU le renommer.

```shell
mv <source> <destination>
```

**Exemple d'exécution (Renommer) :**

```shell
$ mv ancien_nom.txt nouveau_nom.txt
```

**Exemple d'exécution (Déplacer) :**

```shell
$ mv fichier.txt /tmp/
```

---

## 3. Recherche et Outils Puissants

### Commande : `grep`

Cherche une chaîne de caractères spécifique à l'intérieur d'un fichier. C'est l'outil indispensable pour trouver des informations dans des logs.

```shell
grep "<texte_a_chercher>" <fichier>
```

**Exemple d'exécution :**

```shell
$ grep "password" access.log
Login attempt: user=admin password=secret123
```

---

### Commande : `find`

Cherche des fichiers dans le système selon des critères (nom, taille, permissions).

```shell
find <dossier_de_depart> -name "<nom_du_fichier>"
```

**Exemple d'exécution :**

```shell
$ find / -name "flag.txt" 2>/dev/null
/root/secret/flag.txt
/var/www/html/assets/flag.txt
```

> _Note : `2>/dev/null` cache les erreurs "Permission denied"._

---

## 4. Permissions et Privilèges

### Commande : `chmod`

**Change Mode**. Modifie les permissions de lecture (r), écriture (w) et exécution (x) d'un fichier.

```shell
chmod <permissions> <fichier>
```

**Exemple d'exécution :**

```shell
$ ls -l script.sh
-rw-r--r-- 1 user user 0 Jan 01 12:00 script.sh

$ chmod +x script.sh

$ ls -l script.sh
-rwxr-xr-x 1 user user 0 Jan 01 12:00 script.sh
```

---

### Commande : `sudo`

**SuperUser DO**. Exécute la commande qui suit avec les droits d'administrateur (root). Nécessaire pour installer des logiciels ou modifier des fichiers système.

```shell
sudo <commande>
```

**Exemple d'exécution :**

```shell
$ sudo apt update
[sudo] password for user: 
Hit:1 http://eu-west-1.ec2.archive.ubuntu.com/ubuntu focal InRelease
...
```

---

## 5. Les Opérateurs (Shell Operators)

Ils permettent de manipuler les flux de données entre les commandes.

### L'Opérateur `>` (Redirection)

Prend la sortie d'une commande et l'écrit dans un fichier (écrase le contenu existant).

```shell
echo "Ceci est un test" > test.txt
```

### L'Opérateur `>>` (Ajout)

Prend la sortie d'une commande et l'ajoute à la fin d'un fichier (sans effacer le contenu précédent).

```shell
echo "Ligne suivante" >> test.txt
```

### L'Opérateur `|` (Pipe)

Prend le résultat de la commande de gauche et l'envoie comme entrée à la commande de droite.

```shell
cat access.log | grep "admin"
```
