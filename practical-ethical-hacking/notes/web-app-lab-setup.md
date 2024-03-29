# Web App Lab Setup

```
sudo apt update

sudo apt upgrade

sudo apt install docker.io

sudo apt install docker-compose
```

RESTART YOUR VM

Copy the labs to a directory in your system, then open a terminal to that directory

```
tar -xf peh-web-labs.tar.gz

cd labs

sudo docker-compose up
```

The first time it runs, it will need to download some things, it may take a while depending on your 
connection. Next time you run it though, it will be much faster.

Once you see the databases are 'ready for connections' the containers should be ready to go.

The final step is to set some permissions for the webserver, this is needed for the file upload labs and the capstone challenge.

`./set-permissions.sh`

Browse to http://localhost

The first time you load the lab the database will need to be initialized, just follow the instructions in the 
red box by clicking the link, then coming back to the homepage.

Reset lab by navigating to /init.php

