# Scan de ports et Prise d'empreinte des services


Cours basé sur la vidéo "Scan de ports et Prise d'empreinte des services" du Youtubeur _Formation en Ligne_

## 1. Le Scanner de Référence

### Commande : `nmap` (Network Mapper)

L'outil le plus reconnu pour le scan de réseau. Il détecte les hôtes, les ports ouverts, les services et les systèmes d'exploitation. **Options clés :**

`-sS` : Scan furtif (Stealth) via paquets TCP SYN.

`-sU` : Scan des ports UDP (plus lent).

`-sV` : Détection de version (crucial pour trouver les failles).

 `-A` : Scan agressif (OS + Version + Scripts + Traceroute

```shell
nmap [options] <IP>
```

**Exemple d'exécution (Scan Agressif) :**

```shell
$ nmap -A 192.168.1.15
Starting Nmap 7.91 scan...
Nmap scan report for 192.168.1.15
Host is up (0.00045s latency).
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 7.6p1 (Ubuntu)
80/tcp open  http    Apache httpd 2.4.29
|_http-server-header: Apache/2.4.29 (Ubuntu)
Device type: general purpose
OS details: Linux 4.15 - 5.6
```

---

## 2. Conversion de Rapports

### Commande : `xsltproc`

Outil permettant de convertir les rapports de scan Nmap (générés au format XML) en un fichier HTML lisible et présentable dans un navigateur.

```shell
xsltproc <fichier.xml> -o <fichier.html>
```

**Exemple d'exécution :**

```shell
$ xsltproc scan_result.xml -o rapport_final.html
Writing rapport_final.html...
```

---

## 3. Interface Graphique Nmap

### Outil : `zenmap`

L'interface officielle de Nmap. Elle permet de visualiser la topologie du réseau graphiquement (contrairement à nmap) , de sauvegarder des profils de scan et de comparer des résultats plus facilement qu'en ligne de commande.

```shell
zenmap
```

**Exemple d'exécution :**

```shell
$ zenmap &
(Lancement de l'interface graphique...)
```

---

## 4. Scan Ultra-Rapide (UDP)

### Commande : `unicornscan`

Un scanner asynchrone conçu pour la vitesse. Il est particulièrement efficace pour scanner de larges plages de ports UDP très rapidement grâce à sa gestion optimisée des paquets par seconde (PPS). `-mU` : Mode UDP. `-r` : Taux de paquets par seconde (Rate).

```shell
unicornscan -mU -r <pps> <IP>
```

**Exemple d'exécution :**

```shell
$ unicornscan -mU -r 300 192.168.1.15
scanning 192.168.1.15: total ports to scan: 65535
UDP open 192.168.1.15:161  ttl 64
UDP open 192.168.1.15:137  ttl 64
```

---

## 5. Identification de Service

### Commande : `amap`

Outil de "fingerprinting" applicatif. Il envoie des "triggers" (déclencheurs) spécifiques aux ports pour analyser les réponses et identifier le service réel, même si celui-ci tourne sur un port non standard (ex: SSH sur le port 80).

```shell
amap <IP> <port>
```

**Exemple d'exécution :**

```shell
$ amap 192.168.1.15 8080
Protocol-mapping 192.168.1.15:8080 matches:
http - Apache httpd 2.4.29
```

---

## 6. Scan NetBIOS (Windows)

### Commande : `nbtscan`

Scanne les réseaux pour récupérer les informations de noms NetBIOS. Très utile sur un réseau local pour obtenir les noms de machines (hostname), les utilisateurs connectés et les adresses MAC.

```shell
nbtscan -r <Réseau/CIDR>
```

**Exemple d'exécution :**

```shell
$ nbtscan -r 192.168.1.0/24
IP address       NetBIOS Name     Server    User             MAC address
------------------------------------------------------------------------------
192.168.1.15     DESKTOP-J7      <server>  ADMINISTRATEUR   00:0c:29:4f:5a:11
192.168.1.20     FILE-SRV        <server>  BACKUP-USER      00:50:56:c0:00:08
```

---

## 7. Scan SNMP

### Commande : `onesixtyone`

Scanner SNMP très rapide. Il utilise une liste de dictionnaires pour trouver les chaînes de communauté SNMP (comme "public" ou "private") afin d'extraire des informations système critiques.

```shell
onesixtyone <IP>
```

**Exemple d'exécution :**

```
$ onesixtyone 192.168.1.15
Scanning 1 hosts, 2 communities
192.168.1.15 [public] Linux server-ubuntu 4.15.0-20-generic
```

---

## 8. Scanner de Vulnérabilités

### Outil : `Nessus`

Outil complet et automatisé (nécessite installation et inscription). Il scanne les machines pour détecter des milliers de vulnérabilités connues (logiciels obsolètes, mauvaises configurations, mots de passe par défaut). Il génère des rapports détaillés avec des scores de risque et des solutions.

```shell
Accès : Via interface Web (généralement https://localhost:8834)
```

**Résultat attendu :** Tableau de bord affichant les vulnérabilités classées par sévérité (Critique, Élevée, Moyenne, Faible).


## 9.Scanner de façon inapercu

### Commande : `pOf`

Permet de récupérer l'OS d'une machine cible en interceptant les paquets réseaux qui circulent. Scan de façon passive par rapport à nmap pour ainsi être plus discret (mais scan donc plus long).

```shell
pof -i ethO -p -o pOf.log
```
