# Web Application Enumeration, Revisited

### Finding Subdomains with Assetfinder

[tomnomnom/assetfinder](https://github.com/tomnomnom/assetfinder)

Find subdomains and assets of a domain

`assetfinder <DOMAIN>` 

Find only subdomains

`assetfinder --subs-only <DOMAIN>`

*Apparently we get better results from listing all subdomains and assets then filtering the subdomains with 
grep*

Use automated script to find and filter the subdomains

[run.sh](../scripts/run.sh)

### Finding Subdomains with Amass

Install with go

Takes a while to run

`amass enum -d tesla.com`

### Finding Alive Domains with Httprobe

Install with go

Verify domains with httprobe

`cat subdomains.txt | httprobe`

Use `-s` to skip default ports (80 and 443) and `-p https:443` to add ports

### Screenshotting Websites with GoWitness

Install with go

Creates screenshots of websites and places them in a directory for easy viewing

`gowitness single https://google.com`

### Automating the Enumeration Process

sumrecon: https://github.com/thatonetester/sumrecon

TCM's modified script - https://pastebin.com/MhE6zXVt

### Additional Resources

The Bug Hunter's Methodology - https://www.youtube.com/watch?v=uKWu6yhnhbQ

Nahamsec Recon Playlist - https://www.youtube.com/watch?v=MIujSpuDtFY&list=PLKAaMVNxvLmAkqBkzFaOxqs3L66z2n8LA

