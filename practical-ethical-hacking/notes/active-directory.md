# Active Directory

### AD Overview

Internal Penetration testing

**What is Active Directory?**

- Directory service developed by Microsoft to manage Windows domain networks
- Stores information related to objects, such as Computers, Users, Printers, etc. Think of it as a phone book 
for Windows
- Authenticates using Kerberos tickets. Non-Windows devices, such as linux machines, firewalls, etc. can also 
authenticate to AD via RADIUS or LDAP

**Why Active Directory?**

- Active Directory is the most commonly used identity management service in the world. 95% of Fortune 1000 
companies implement the service in their networks
- Can be exploited without ever attacking patchable exploits. Instead, we abuse features, trusts, components, 
and more

### Physical Active Directory Components

Active Directory Components

AD is composed of both physical and logical components

|Physical|
|---------|
|Data store|
|DCs|
|Global catalog server|
|Read-Only DC (RODC)|

Domain Controllers

![Domain Controllers](./pictures/domain-controllers.png)

AD DS Data Store

![AD DS](./pictures/ad-ds-data-store.png)

### Logical Active Directory Components

|Logical|
|-------|
|Partitions|
|Schema|
|Domains|
|Domain trees|
|Forests|
|Sites|
|Organisational units (OUs)|

![AD DS Schema](./pictures/ad-ds-schema.png)

![Domains](./pictures/domains.png)

![Trees](./pictures/trees.png)

![Forests](./pictures/forests.png)

![Organizational Units](./pictures/ous.png)

![Trusts](./pictures/trusts.png)

![Objects](./pictures/objects.png)

### Active Directory Lab Build

1 x Windows Server 2022
2 x Windows 10 Workstations

Cloud based Lab in Azure https://kamran-bilgrami.medium.com/ethical-hacking-lessons-building-free-active-directory-lab-in-azure-6c67a7eddd7f

### Necessary ISOs

Enter dummy data when asked. Real email, phone, etc. not needed

[Microsoft Evaluation Center](https://www.microsoft.com/en-us/evalcenter)

[Windows Server 2022](https://info.microsoft.com/ww-landing-windows-server-2022.html)
[Windows 10 Enterprise](https://www.microsoft.com/en-us/evalcenter/download-windows-10-enterprise)

### Setting Up the Domain Controller

Remove floppy from hardware after VM creation, increase memory to 4-8Gb

Windows Server 2022 Evaluation Standard (Desktop experience), custom installation.
At drive creation add New and apply then install

Install VMWare tools and rename the DC, then reboot

**Promote the server to Domain Controller**

Select Manage -> Add Roles and Features

**Add Roles and Features Wizard**

Before You Begin: Next
Installation type: Role based or Feature based
Server Selection: Next
Server Roles: Active Directory Domain Services
Features: Next
AD DS: Next
Confirmation: Check restart if required
Results: When finished, click "Promote this server to a domain controller"

**Deployment Configuration Wizard**

Deployment Configuration: Select "Add a new forest" and enter the Root domain name (domain_name.local)
Domain Controller Options: Set the Directory Services Restore Mode (DSRM) password (same as Admin password)
DNS Options: Next
Additional Options: Next after the NetBIOS domain name loads
Paths: Next
Review Options: Next
Prerequisites Check: Install

Server will reboot after installation

**Add Active Directory Certificate Services**

Allows us to use LDAPS instead of LDAP

Select Manage -> Add Roles and Features 

**Add Roles and Features Wizard**

Before You Begin: Next
Installation type: Role based or Feature based
Server Selection: Next
Server Roles: Active Directory Certificate Services
Features: Next
AD CS: Check Certification Authority is checked, then Next
Confirmation: Check restart if required
Results: Configure Active Directory Certificate Services

**AD CS Configuration**

Credentials: Next
Role Services: Check Certification Authority, then Next
Setup Type: Next
CA Type: Next
Private Key: New private key
Cryptography: Next
CA Name: Next
Validity Period: Increase to 99 years, then Next
Certificate Database: Next
Confirmation: Configure

Reboot the Server

### Setting Up the User Machines
