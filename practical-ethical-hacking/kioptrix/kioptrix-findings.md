# Kioptrix

### Ports open

**[Nmap scan](./kioptrix.nmap)**

Services:

- 22 SSH OpenSSH 2.9p2 (protocol 1.99)

- 80/443 HTTP/HTTPS Apache httpd 1.3.20 ((Unix) (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b)

- 111 RPC 

- 139 SMB

- 32768 RPC

### HTTP/S Enumeration

1. Default webpage disclosing OS and server software - Apache and PHP

2. Information disclosure - 404 page discloses host name and server software version
present

3. Information disclosure - Server headers disclose version information

4. Information disclosure - /usage/ pages disclose host name

**[Nikto scan](./kioptrix.nikto)**

Notable results:

- mod_ssl/2.8.4 - mod_ssl 2.8.7 and lower are vulnerable to a remote buffer overflow which 
may allow a remote shell.

**[dirbuster scan](./kioptrix.dirbuster.txt)**

- PHP4 - http://192.168.128.130/test.php

- Webalizer Version 2.01 - http://192.168.128.130/usage/usage_202304.html

### SMB Enumeration

- Unix (Samba 2.2.1a)

- Two file shares, ADMIN$ and IPC$ - Can connect to IPC$ anonymously

### SSH Enumeration

- OpenSSH 2.9p2

### Vulnerabilities

80/443 - Potentially vulnerable to OpenFxck (https://www.exploit-db.com/exploits/47080)

139 - Potentially vulnerable to trans2open (https://www.rapid7.com/db/modules/exploit/linux/samba/trans2open/), (https://www.exploit-db.com/exploits/7), (https://www.exploit-db.com/exploits/10)

22 - Potentially vulnerable to username enumeration (https://github.com/Sait-Nuri/CVE-2018-15473)

The [Nessus scan](./kioptrix-nessus-scan.pdf) shows multiple critical vulnerabilities.

### Exploitation

**SMB - trans2open**

Obtained root using the trans2open module in Metasploit to exploit a vulnerable Samba 
version.

Metasploit screenshot

**80 - modssl**

OpenLuck screenshot

### Post Exploitation

**Shadow file**

### Findings

**Default Webpage - Apache**

Screenshot of page

**Information Disclosure**

Host name, screenshot

**Undetected Malicious Activity**

Scanning, SSH brute force attempts
Screenshots

### Remediation

Update software and services to latest versions.
