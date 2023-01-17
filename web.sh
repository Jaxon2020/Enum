#!/bin/bash

echo "Intiating Web enumeration..."

mapfile -t open_ports < open_ports.txt
mapfile -t IPs < ip.txt

IPmain=${IPs[0]}

for port in "${open_ports[@]}"; do
    if [ $port == "80" ]; then
        echo "Port 80 is open, proceeding with enumeration..."
        echo "Utilizing tools to find and map domain if possible..."

        domain=$(curl -s -i http://$IPmain:80 | grep "Location" | awk '{print $2}' | sed 's#http://##g')

        echo "$IPmain $domain" | sudo tee -a /etc/hosts
    
        echo "Domain found and successfully mapped!"

        echo "Looking for subdomains..."

        ffuf -w /opt/useful/SecLists/Discovery/DNS/bitquark-subdomains-top100000.txt:FUZZ -u http://FUZZ.github.com:80/ 


    else
        echo "The port $port does not seem to be hosting a webservice.."
    fi
done
