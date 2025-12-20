# Informations publiques

Cours basé sur la vidéo "Informations publiques" du Youtubeur *Formation en Ligne*

## 1. Récupération Passive (Sites Web)

### Site : `Whois (.net)`

Ces sites permettent une récupération passive d'informations sans interagir directement avec le serveur cible (pas de logs sur la cible).

Utilité : Trouver le propriétaire d'un site, l'hébergeur, les serveurs DNS et les coordonnées de contact.

```
Site Web : http://www.whois.net
```

Résultat attendu :

Affichage des informations administratives (Registrar, dates de création, emails de contact).

---

### Site : `Alexa`

Outil d'analyse du trafic web mondial.

Utilité : Obtenir des statistiques sur les visiteurs, les mots-clés utilisés pour trouver le site et la localisation géographique du trafic.

```
Site Web : http://www.alexa.com
```

---

## 2. Informations d'Enregistrement

### Commande : `whois`

L'équivalent en ligne de commande du site web. Elle interroge les bases de données d'enregistrement pour obtenir les détails techniques et administratifs.

```shell
whois <nom_du_site>
```

**Exemple d'exécution :**

```shell
$ whois google.com
   Domain Name: GOOGLE.COM
   Registry Domain ID: 2138514_DOMAIN_COM-VRSN
   Registrar WHOIS Server: whois.markmonitor.com
   Registrar URL: http://www.markmonitor.com
   Updated Date: 2018-02-21T18:36:40Z
   Creation Date: 1997-09-15T04:00:00Z
   Registrar: MarkMonitor Inc.
```

---

## 3. Résolution de Nom

### Commande : `host`

Traduit un nom de domaine en adresse IP. Elle retourne l'adresse IPv4 et IPv6 (si disponible) assignée au serveur.

```shell
host <nom_du_site>
```

**Exemple d'exécution :**

```shell
$ host google.com
google.com has address 142.250.74.206
google.com has IPv6 address 2a00:1450:4007:80b::200e
google.com mail is handled by 10 aspmx.l.google.com.
```

---

## 4. Analyse DNS Approfondie

### Commande : `dig`

Outil puissant pour interroger les serveurs DNS. Il permet de vérifier les enregistrements DNS et de confirmer les résultats obtenus avec d'autres outils.

```shell
dig <nom_du_site>
```

**Exemple d'exécution :**

```shell
$ dig google.com
; <<>> DiG 9.16.1-Ubuntu <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 1827
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             258     IN      A       142.250.179.78
```

---

## 5. Énumération DNS Complète

### Commande : `dnsenum`

Récupère une liste complète des enregistrements DNS, y compris les serveurs de messagerie (MX). C'est un outil dédié à l'énumération DNS.

```shell
dnsenum <nom_du_site>
```

**Exemple d'exécution :**

```shell
$ dnsenum google.com
-----   google.com   -----
Host's addresses:
__________________
google.com.                              219      IN    A        172.217.16.206

Name Servers:
______________
ns1.google.com.                          1369     IN    A        216.239.32.10
ns2.google.com.                          1369     IN    A        216.239.34.10

Mail (MX) Servers:
___________________
aspmx.l.google.com.                      287      IN    A        74.125.133.26
```

---

## 6. Scan Tout-en-un

### Commande : `dmitry`

Deepmagic Information Gathering Tool. Un outil très rapide qui combine plusieurs recherches.

Options utilisées : -winse (Whois IP, Whois Domaine, Netcraft info, Sous-domaines, Emails).

```shell
dmitry -winse <site>
```

**Exemple d'exécution :**

```shell
$ dmitry -winse example.com
Deepmagic Information Gathering Tool
"There be some deep magic going on"

HostIP:192.0.43.10
HostName:example.com

Gathering Whois information...
Gathering Netcraft information...
Gathering Subdomain information...
Gathering E-Mail information...
Found E-Mail: webmaster@example.com
```

---

## 7. Traçage de Route (Mode TCP)

### Commande : `tcptraceroute`

Trace la route des paquets vers la cible en utilisant des paquets TCP.

Utilité : Permet de contourner certains pare-feux qui bloquent le traceroute classique (ICMP/UDP).

```shell
tcptraceroute <nom_du_site>
```

**Exemple d'exécution :**

```shell
$ tcptraceroute google.com
Selected device eth0, address 192.168.1.5, port 54321
Tracing the path to google.com (142.250.74.206) on TCP port 80, 30 hops max
 1  192.168.1.1  0.584 ms  0.512 ms  0.490 ms
 2  10.20.30.1   12.30 ms  11.50 ms  14.20 ms
 3  142.250.74.206 [open]  15.20 ms  14.80 ms  15.10 ms
```

---

## 8. Récolte d'Informations (OSINT)

### Commande : `theharvester`

Scanne les moteurs de recherche (Google, Bing, LinkedIn, etc.) pour "récolter" (harvest) des emails, des noms d'employés et des sous-domaines.

-d : Domaine cible.

-l : Limite de résultats.

-b : Source (google, linkedin, twitter, etc.).

```shell
theharvester -d <domaine> -l <limite> -b <source>
```

**Exemple d'exécution :**

```shell
$ theharvester -d kali.org -l 50 -b google
[*] Target: kali.org
[*] Searching Google...
[*] Searching LinkedIn...

[*] Users found:
---------------------
admin@kali.org
support@kali.org

[*] Hosts found:
---------------------
docs.kali.org
forums.kali.org
```

---
## 9. Analyse Graphique

### Outil : `Maltego`

Logiciel avec interface graphique (GUI) très puissant. Nécessite une inscription.

Utilité : Permet de visualiser les liens entre différentes entités (personnes, domaines, serveurs, emails) sous forme de graphiques et d'automatiser le croisement de données.
