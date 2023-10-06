# Attacking Authentication

### Attacking Authentication - Introduction

Logic based flaws

### Attacking Authentication - Brute Force

Burp Suite Intruder

ffuf

`ffuf -request req.txt -request-proto http -w /usr/share/wordlists/seclists/Passwords/xato-net-10-million-passwords-10000.txt`

Find failed password request length then use `-fs length` to filter the failed attempts

Hydra

`hydra -l jeremy -P /usr/share/wordlists/seclists/Passwords/xato-net-10-million-passwords-10000.txt 127.0.0.1 http-post-form "/labs/a0x01.php:username=^USER^&password=^PASS^:incorrect"`

### Attacking Authentication - MFA

Weakness in authentication flow

[Attacking MFA](https://appsecexplained.gitbook.io/appsecexplained/common-vulns/authentication/attacking-mfa)

Intercepting the MFA post request we can change the username to jeremy, using jessamy's credentials and MFA
code to log in as jeremy

Check MFA code length and implementation:

- if the code is weak it can be brute forced
- check if the code can be used for any user

###  Attacking Authentication - Challenge

Valid usernames give an account lockout warning, invalid usernames give no response

Password spraying with previous known usernames:

admin
jeremy
jessamy

Tried the following passwords:

Password
pasta
letmein

admin:letmein gave a successful login response

**Walkthrough**

Use a clusterbomb attack with only 4 passwords per username to avoid account lockout

Set req.txt payload with FUZZUSER FUZZPASS

`ffuf -request req.txt -request-proto http -mode clusterbomb -w pwd-wordlist.txt:FUZZPASS -w user-wordlist.txt:FUZZUSER -fs failed-request-lengths`
