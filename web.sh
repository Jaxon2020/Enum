#!/bin/bash

echo "give me a bottle of rum!"

mapfile -t open_ports < open_ports.txt
mapfile -t IPs < ip.txt


for port in "${open_ports[@]}"; do
    if [ $port == "80" ]; then
        echo "Port 80 is open, proceeding with enumeration..."
        echo "Utilizing tools to find and map domain if possible..."

        domain=$(curl -s -i http://10.10.11.180:80 | grep "Location" | awk '{print $2}' | sed 's#http://##g')

        echo "$IP $domain" | sudo tee -a /etc/hosts
        echo $domain
    else
        echo "The port $port does not seem to be hosting a webservice.."
    fi
done
