# Active Directory Case Studies

### AD Case Study 1

Takeaways:

- Weak passwords
- Password reuse
- SMB signing disabled
- No account tiering
- Basics were lacking allowing compromise despite expensive security solutions

Blog post - https://tcm-sec.com/pentest-tales-001-you-spent-how-much-on-security/

### AD Case Study 2

Takeaways:

- Default credential use
- Cleartext passwords
- WDigest enabled (by default on Win 7 & 8, Win Server 2008 R2, and Win Server 2012)
- DA service accounts
- Password reuse

Blog post - https://tcm-sec.com/pentest-tales-002-digging-deep

### AD Case Study 3

Takeaways:

- Misconfiguration of user account allowing SMB share access
- Cleartext admin password in document on share
- Cleartext DA password found in secretsdump on machine using credentials from share
- Think outside the box, don't give up after common attacks fail!
