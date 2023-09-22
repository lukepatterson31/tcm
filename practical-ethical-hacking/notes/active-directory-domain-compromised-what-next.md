# We've Compromised the Domain - Now What?

### Post-Domain Compromise Attack Strategy

We own the domain, now what?

**Provide as much value to the client as possible:**

- Put your blinders on and do it again
- Dump the NTDS.dit
- Enumerate shares for sensitive information

**Persistence can be important:**

- What happens if our DA access is lost?
- Creating a DA account can be useful (Do not forget to delete it!), should be detected!
- Creating a Golden Ticket can be useful

### Dumping the NTDS.dit

What is the NTDS.dit?

A database used to store AD data, including:

- User information
- Group information
- Security descriptors
- Password hashes

Use `secretsdump` against the DC with a known DA account

`impacket-secretsdump domain/user:password@10.10.10.1 -just-dc-ntlm`

Extract the NT from the hashes (username:id:NT:LM:::) for cracking with `-m 1000` in hashcat

Use excel or bash to split the hashes and pair the usernames with the cracked values for reference/reporting

### Golden Ticket Attacks Overview

What is it?

- When we compromise the krbtgt account, we own the domain
- We can request access to any resource or system on the domain
- Golden Tickets grant complete access to every machine

We can use mimikatz to obtain the information to perform the attack

We need:

- The krbtgt NTLM hash
- The domain SID

### Golden Ticket Attacks

As DA on the DC, run mimikatz and set debug privileges

Then dump the krbtgt hash

`lsadump::lsa /inject /name:krbtgt`

`kerberos::golden /User:Administrator /domain:MARVEL.local /sid:SID /krbtgt:NTLM-HASH /id:500 /ptt`

`/id` is the relative identifier (RID) of the admin account

The ticket will now be available for the current session

Run `misc::cmd` to run a shell with the Golden Ticket giving us full access to the domain

With PsExec64.exe, a legitimate Windows admin tool, we can gain remote shells on any machine on the domain,
potentially without triggering any alerts or looking suspicious

Most organizations will pick up on DAs being added whereas Golden Tickets may go undetected

To be even stealthier use a Silver Ticket instead

