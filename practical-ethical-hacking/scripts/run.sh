#!/bin/bash

url=$1

if [ ! -d "$url" ];then 
		mkdir $url
fi

if [ ! -d "$url/recon" ];then
		mkdir $url/recon
fi

echo "[+] Harvesting subdomains with assetfinder..."
assetfinder $url >> $url/recon/assets.txt
grep $1 $url/recon/assets.txt >> $url/recon/subdomains.txt
rm $url/recon/assets.txt

#echo "[+] Harvesting subdomains with Amass..."
#amass enum -d $url >> $url/recon/amass.txt
#sort -u $url/recon/amass.txt >> $url/recon/subdomains.txt
#rm $url/recon/amass.txt

echo "[+] Probing for alive domains..."
cat $url/recon/subdomains.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/alive.txt
