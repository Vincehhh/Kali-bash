# Enumération des machines

Cours basé sur la vidéo "Enumération des machines" du Youtubeur *Formation en Ligne*
## 1. Vérification de base (ICMP)

### Commande : `ping`
L'outil standard pour vérifier si une machine est en ligne via le protocole ICMP.
`-c` permet de définir un nombre précis de paquets (évite la boucle infinie par défaut sous Linux).

```bash
ping -c <nombre> <IP>
```
**Exemple d'exécution :**

```shell
$ ping -c 3 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=1.02 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=0.98 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=1.05 ms

--- 192.168.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss
```

---

## 2. Analyse de Trafic

### Outil : `wireshark`

Analyseur de paquets réseau (Sniffer). C'est une interface graphique qui permet de capturer et visualiser "sous le capot" tout le trafic (ARP, TCP, HTTP, etc.).

```
wireshark
```

**Exemple d'exécution :**

```
$ wireshark &
[1] 1234
(Lancement de l'interface graphique...)
```

---

## 3. Découverte Réseau Local (Layer 2)

### Commande : `arping`

Outil de découverte pour le réseau local (LAN). Il utilise le protocole ARP (couche 2) au lieu de l'ICMP.
 **Utilité :** Permet détecter des machines qui bloquent le ping classique via un pare-feu.

```shell
arping -I <interface> <IP>
```

**Exemple d'exécution :**

```shell
$ arping -I eth0 192.168.1.15
ARPING 192.168.1.15 from 192.168.1.5 eth0
Unicast reply from 192.168.1.15 [00:11:22:33:44:55]  0.785ms
Unicast reply from 192.168.1.15 [00:11:22:33:44:55]  0.810ms
```

---

## 4. Scan de Plages IP

### Commande : `fping`

Similaire au ping, mais optimisé pour scanner rapidement des plages d'adresses entières.
Option `-g` :Génère une liste de cibles à partir d'un masque CIDR.
Option `-r` : Limite le nombre d'essais (retries).

```shell
fping -g <CIDR>
```

**Exemple d'exécution :**

```shell
$ fping -g 192.168.1.0/24
192.168.1.1 is alive
192.168.1.5 is alive
192.168.1.15 is alive
192.168.1.20 is unreachable
```

---

## 5. Forger des Paquets (Avancé)

### Commande : `hping3`

Générateur de paquets puissant. Permet de "forger" des paquets sur mesure (TCP, UDP, ICMP) pour tester les pare-feux.

#### Mode ICMP (Ping classique)

```shell
hping3 -1 <IP>
```

#### Mode TCP (Test de port / Pare-feu)

Envoie des paquets SYN sur un port spécifique.
`-S` : Flag SYN.
`-p` : Port cible.

```shell
hping3 -S -p <port> -c <nombre> <IP>
```

**Exemple d'exécution (Test du port SSH) :**

```shell
$ hping3 -S -p 22 -c 3 192.168.1.15
HPING 192.168.1.15 (eth0 192.168.1.15): S set, 40 headers + 0 data bytes
len=46 ip=192.168.1.15 ttl=64 DF id=0 sport=22 flags=SA seq=0 win=29200
len=46 ip=192.168.1.15 ttl=64 DF id=0 sport=22 flags=SA seq=1 win=29200
```

_(flags=SA signifie SYN/ACK, donc le port est ouvert)._

---

## 6. Suite Nmap

### Commande : `nping`

Fait partie de la suite Nmap. Similaire à Hping3, permet de générer des paquets pour l'analyse de protocole.

```shell
nping --tcp -p <port> <IP>
```

**Exemple d'exécution :**

```shell
$ nping --tcp -p 80 192.168.1.1

Starting Nping ( [https://nmap.org/nping](https://nmap.org/nping) )
SENT (0.0050s) TCP 192.168.1.5:4321 > 192.168.1.1:80 S ttl=64 id=1234
RCVD (0.0060s) TCP 192.168.1.1:80 > 192.168.1.5:4321 SA ttl=64 id=5678
Max rtt: 1.0ms | Min rtt: 1.0ms | Avg rtt: 1.0ms
```
