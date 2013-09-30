#!/usr/bin/python

#####################################################
# add a virtual host in a programatic way
#####################################################

import sys, getopt

def main(argv):
    domain = ''
    dbuser = False
    sysuser = True
    try:
        opt, args = getopt.getopt(argv,"hd:us", ["help", "domain=", "dbuser", "sysuser"])
    except getopt.GetoptError, err:
        print str(err)
        usage()
        sys.exit(2)
    dbuser = None
    sysuser = None
    for o, a in opt:
        if o in ("-h", "--help"):
            usage()
            sys.exit()
        elif o in ("-d", "--domain"):
            print str(a), "supplied as domain"
        elif o in ("-u", "--dbuser"):
            dbuser = True
            print "dbuser selected"
        elif o in ("-s", "--sysuser"):
            sysuser = True
            print "sysuser selected"
        else:
            assert False, "exception"
             
def usage():
    usage = """
    -h --help                 Prints this message
    -d --domain (arugment)    Domain name
    -d --dbuser               Database user
    -s --sysuser              System user
    """
    print usage    

if __name__ == "__main__":
    main(sys.argv[1:])
