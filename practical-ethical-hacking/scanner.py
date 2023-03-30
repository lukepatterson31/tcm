#!/usr/bin/env python3

import sys
from datetime import datetime
import socket

try:
    if len(sys.argv) == 2:
        target = socket.gethostbyname(sys.argv[1])
    else:
        print("Not enough arguments")
        print("python3 scanner.py <ip>")
    
    print("-"*50)
    print(f"Scanning: {target}")
    print(f"Started: {str(datetime.now())}")
    print("-"*50)

    for port in range(50, 85):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        socket.setdefaulttimeout(1)
        result = s.connect_ex((target, port))
        if result == 0:
            print(f"Port {port} is open")
        s.close()

except KeyboardInterrupt:
    print("\n Exiting program.")
    sys.exit()

except socket.gaierror:
    print("Hostname could not be resolved!")
    sys.exit()

except socket.error:
    print("Could not connect to the server!")
    sys.exit()
