#!/usr/bin/python

"""
This script will count unique IP's in an apache log file. 
It will take input form a file provided on the command line 
or stdin. At the moment it just counts unique strings in 
the first field.
"""

#import sys
from collections import Counter
import fileinput

## Not needed with fileinput.input()
#if len(sys.argv) > 1:
#    logfile = open(sys.argv[1])
#else: 
# Open file if supplied otherwise read from stdin
logfile = fileinput.input()

# Create empty list
ips = []

# Loop through input
for line in logfile:
    # Split on white space
    l = line.split(' ')
    # Append first field to list
    ips.append(l[0])

# Count and print unique ip's and count    
unique_ips = Counter(ips)
print unique_ips.items()

