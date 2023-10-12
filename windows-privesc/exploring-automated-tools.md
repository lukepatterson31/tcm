# Exploring Automated Tools

### Automated Tools Overview

| **Executables** |  **PowerShell** | **Other** |
|-----------------|-----------------|-----------|
| winPEAS.exe | Sherlock.ps1 | windows-exploit-suggester.py (local) |
| SeatBelt.exe (compile) | PowerUp.ps1 | Exploit Suggester (Metasploit) |
| Watson.exe (compile) | jaws-enum.ps1 | |
| SharpUp.exe (compile) |  |  |

WinPEAS - https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/winPEAS

Windows PrivEsc Checklist - https://book.hacktricks.xyz/windows/checklist-windows-privilege-escalation

Sherlock - https://github.com/rasta-mouse/Sherlock

- deprecated, predecessor to Watson

Watson - https://github.com/rasta-mouse/Watson

- needs to be compiled for the target version of .Net

PowerUp - https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc

JAWS - https://github.com/411Hall/JAWS

Windows Exploit Suggester - https://github.com/AonCyberLabs/Windows-Exploit-Suggester

- uses a syteminfo txt file to find potential vulnerabilities of the target

Metasploit Local Exploit Suggester - https://blog.rapid7.com/2015/08/11/metasploit-local-exploit-suggester-do-less-get-more/

Seatbelt - https://github.com/GhostPack/Seatbelt

- needs to be compiled for the target version of .Net

SharpUp - https://github.com/GhostPack/SharpUp

- needs to be compiled for the target version of .Net

### Exploring Automated Tools

If scripts/exe/PowerShell don't work, use Metasploit or Windows Exploit Suggester!

**Metasploit:**

`run post/multi/recon/local_exploit_suggester`

**Windows Exploit Suggester:**

Save systeminfo to a txt file

Run the exploit suggester (Python 2.7)

`python2.7 windows-exploit-suggester.py --update`

Install xlrd v1.2.0 (Python 2.7)

`pip install xlrd==1.2.0`

Run

`python2.7 windows-exploit-suggester.py --database database.xls --systeminfo systeminfo.txt`
