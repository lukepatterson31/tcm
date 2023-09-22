# Additional Active Directory Attacks

### Recent Vulnerabilities

Overview:

- Active Directory vulnerabilities occur all the time
- Recent major vulnerabilities include:
	- ZeroLogon
	- PrintNightmare
	- Sam the Admin
- It's worth checking for these vulnerabilities, but you should not attempt to exploit them unless your 
client approves

These vulnerabilities usually have checkers that can be run to determine if a target is vulnerable

### Abusing ZeroLogon

CVE-2020-1472

Very dangerous!

High level, we're setting the DC authentication to NULL so we can authenticate with no password

Run a checker script unless you have prior approval, this can destroy the domain

Resources:

What is ZeroLogon? - https://www.trendmicro.com/en_us/what-is/zerologon.html

dirkjanm CVE-2020-1472 - https://github.com/dirkjanm/CVE-2020-1472

SecuraBV ZeroLogon Checker - https://github.com/SecuraBV/CVE-2020-1472

### PrintNightmare

CVE-2021-1675

Post-compromise attack, a user account is required (doesn't have to be an admin)

Abuses printerspooler

Obfuscate the dll to bypass AVs

Resources:

cube0x0 RCE - https://github.com/cube0x0/CVE-2021-1675

calebstewart LPE - https://github.com/calebstewart/CVE-2021-1675
