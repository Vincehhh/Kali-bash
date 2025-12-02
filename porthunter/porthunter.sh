#!/bin/bash

if [ -z "$1" ]; then
read -p "Ip a scanner: " ip 
else
	ip=$1
fi

echo "Scan sur $ip..."

lists_ports=(21 22 23 53 80 443 3306 8080)

for port in "${lists_ports[@]}"; do

timeout 0.5 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null

if [ $? -eq 0 ]; then 
echo " $port:  ouvert"
fi
done
