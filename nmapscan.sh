#!/bin/bash

echo "
███████████████████████████████████
█─▄▄▄─█─▄▄─█▄─█─▄█─▄▄─█─▄─▄─█▄─▄▄─█
█─███▀█─██─██▄─▄██─██─███─████─▄█▀█
▀▄▄▄▄▄▀▄▄▄▄▀▀▄▄▄▀▀▄▄▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀
"

if [[ $# -eq 0 ]]
then
	echo -e "You need to specify the target domain.\n"
	echo -e "Usage:"
	echo -e "\t$0 <domain>"
	exit 1
else
    echo "Prepare for the enums!"

if [ $2 == S ]
then
    echo "INTIATING STEALTH SCAN, SNEAKY BOI"
    sudo nmap -sS -Pn --disable-arp-ping -vv -n -oN data -D RND:5 $1
elif [ $2 == Si ]
then
    echo "INTIATING STEALTH SCAN, SNEAKY BOI + more info"
    sudo nmap -sS -Pn --disable-arp-ping -vv -n --packet-trace -oN data -D RND:5 $1
elif [ $2 == A ]
then
    echo "INTIATING AGGRESSIVE SCAN, LIVE FAST DIE HARD"
    sudo nmap -A -vv -oN data -D RND:5 $1

elif [ $2 == SV ]
then
    echo "INTIATING STEALTH 'N VERSION SCAN, YE"
    sudo nmap -sS -sV -Pn --disable-arp-ping -vv -n -oN data -D RND:5 $1 
else 
    echo "Ugh, no input? Or Error maybe"
fi


fi
