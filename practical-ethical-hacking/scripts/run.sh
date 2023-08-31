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