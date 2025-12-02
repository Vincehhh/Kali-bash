#!/bin/bash
clear
echo "========================================"
echo "      NET SWEEPER - SCANNER RESEAU      "
echo "========================================"

echo "Entrez les 3 premiers blocs de l'IP (ex: 10.0.2)"
read -p "> " prefix

echo "----------------------------------------"
echo "Scan lancé sur le réseau $prefix.0/24..."
echo "----------------------------------------"

for ip in {1..254}; do
    target="$prefix.$ip"
    if ping -c 1 -W 0.1 $target > /dev/null; then
        echo -e "\033[0;32m[+] MACHINE TROUVÉE : $target\033[0m"
    fi
done

echo "Terminé."
