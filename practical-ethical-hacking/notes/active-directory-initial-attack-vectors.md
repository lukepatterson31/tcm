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


