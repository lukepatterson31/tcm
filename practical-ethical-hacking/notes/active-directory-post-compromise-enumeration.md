# Active Directory Post-Compromise Enumeration

### Introduction

Tools for quick, efficient enumeration:

- Bloodhound
- Plumhound
- Ldapdomaindump
- PingCastle

### Domain Enumeration with ldapdomaindump

Once we have credentials we can use ldapdomaindump to dump a lot of very useful information

`sudo ldapdomaindump -u 'DOMAIN\user' -p password -o dir`

- Domain Computers (look for older architecture/OS)
- Domain Users by group to find high value targets
- Domain User descriptions for potential information disclosure (passwords)
- Domain Trusts and Policies

### Domain Enumeration with Bloodhound

Update bloodhound to latest version with `pip3 install bloodhound`
Start neo4j `sudo neo4j console` and login with default creds neo4j:neo4j
Start bloodhound and login with neo4j creds `bloodhound`
Run the ingestor with `bloodhound-python -d DOMAIN.local -u user -p password -ns <DC-IP> -c all` to collect 
json files containing the Domain graph data
- `-d` The Domain name
- `-ns` Name server, the DC
- `-c` Data collection 

Use the Upload Graph button to upload the json files

In the Analysis tab there are pre-built queries to find Domain Admins, dangerous privileges, shortest paths 
to various objectives, kerberoastable targets, and many more

Each node has a huge amount of information, and can be right-clicked to set as a starting point, set as an 
ending point, set as owned, marked as high value, and more

### Domain Enumeration with Plumhound

Clone the PlumHound repo from github https://github.com/PlumHound/PlumHound
Move the repo to /opt
Install the using the requirements.txt `pip3 install -r requirements.txt`

With neo4j and BloodHound running, run PlumHound.py with --easy to check the domain data is available

`python3 PlumHound.py --easy -p neo4jpassword`

Then run a task with the `-x` option

`python3 PlumHound.py -x tasks/default.tasks -p neo4jpassword`

The full report and files will be in the PlumHound/reports folder

Open index.html in a browser to view all the available report files

### Domain Enumeration with PingCastle

https://www.pingcastle.com/

Run on a machine on the domain or remotely
