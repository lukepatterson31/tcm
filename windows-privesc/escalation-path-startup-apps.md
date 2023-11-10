# Escalation path: Startup Applciations

### Overview of TryHackMe Labs

Windows PrivEsc Lab - https://tryhackme.com/room/windowsprivescarena

Built with lpeworkshop - https://github.com/sagishahar/lpeworkshop

### Startup Applications Overview

icacls Documentation - https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/icacls

Similar concept to autorun, when the machine boots startup apps start

Use `icacls.exe` to check permissions of the Startup directory

`icacls.exe "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup`

If the user has write permissions we can create a malicious executable and place it in the Startup directory,
causing the executable to run on startup

### Escalation via Startup Applications
