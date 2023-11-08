# Escalation Path: RunAs

### Overview of RunAs

Using HTB Access - write up here: https://github.com/lukepatterson31/htb/tree/main/machines/access/access.md

Check credentials with `cmdkey /list` that can be used with runas

### Gaining a Foothold

Anonymous FTP access is enabled and the file share contains a .mdb backup and a password protected .zip file

Switch to binary mode in FTP to download the files

Using `mdbtools` we can dump the table names 

`mdb-tables backup.mdb`

One of the tables is called auth_user, we can dump the table contents using mdb-export

`mdb-export backup.mdb auth_user > users.txt`

The table contains usernames and passwords, none work for telnet but one of the passwords works for the zip 
file

The zip file contains a .pst file, a Personal Storage Table used to store calendar events, contacts and email 
messages

Convert the pst file with `readpst` and view it with `cat`

`readpst 'Access Control.pst'`

The .pst file contains an email with credentials for a security account which can be used to log in via telnet

`telnet -l security 10.10.10.98`

### Escalation via RunAs

Use runas to copy the root.txt file to security's home directory

`C:\Windows\System32\runas.exe /user:ACCESS\Administrator /savecred "C:\Windows\System32\cmd.exe /c TYPE C:\Users\Administrator\Desktop\root.txt > C:\Users\security\root.txt"`
