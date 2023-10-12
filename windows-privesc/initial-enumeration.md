# Initial Enumeration

### Sytem Enumeration

Looking at system info, OS name and version, architecture, patching, hostname, drives, etc.

**System Info (OS name, version, and arch:**

`C:\> systeminfo`

```
C:\> systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"

OS Name:                   Microsoft Windows 7 Enterprise 
OS Version:                6.1.7600 N/A Build 7600
System Type:               X86-based PC
```

**Hostname:**

`C:\> hostname`

**Patching:**

`C:\> wmic qfe`

Filter by category

`C:\> wmic qfe get Caption,Description,HotFix,ID,InstalledOn`

**Drives:**

`C:\> wmic logicaldisk`

Filter by category

`C:\> wmic logicaldisk get Caption,Description,ProviderName`

### User Enumeration

Check current user:

`C:\> whoami`

Check current user privileges:

`C:\> whoami /priv`

Check current user groups:

`C:\> whoami /groups`

List users:

`C:\> net user`

Look at user information:

`C:\> net user Administrator`

Look at local groups:

`C:\> net localgroup`

Look at user group information:

`C:\> net localgroup Administrators`

### Network Enumeration

Check network interfaces:

Look for other NICs for pivoting

`C:\> ipconfig`

More detail:

`C:\> ipconfig /all`

Show arp table:

Look for additional IP addresses worth investigation

`C:\> arp -a`

Show route table:

Look for additional networks to pivot to

`C:\> route print`

Show connections:

`C:\> netstat -ano`

### Password Hunting

Files to look for:

SAM backups, Unattend.xml, WiFi passwords (password reuse), registry, .config files, etc.

Search for passwords in files with the matching extensions in the current directory:

`C:\> findstr /si password *.txt`

[PayloadsAllTheThings - Looting Passwords](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md#eop---looting-for-passwords)

### AV Enumeration

Firewall and AV configuration

Query Windows Defender information with ServiceControl (`sc`):

`C:\> sc query windefend`

Query services to find AV services:

`C:\> sc queryex type= service`

Check Firewall state/config

`C:\> netsh advfirewall firewall dump`

`C:\> netsh firewall show state`

`C:\> netsh firewall show config`
