#!/bin/bash
#
######################################################################################
# A simple script to authenticate with Rackspace identity and show the service catalog
#  -Duncan Murray
######################################################################################

usage()
{
cat << EOF
This script will authenticate with Rackspace identity and show the service catalog. 
-- Please provide a username along with a password OR api key --

OPTIONS:
   -h      Show this message
   -u      Rackspace username
   -p      Rackspace password
   -k      Rackspace API key
   -v      Verbose (not implemented)
EOF
}

# Declare some variables
USERNAME=
PASSWORD=
API_KEY=
VERBOSE=

# Read in arguments
while getopts "hu:p:k:v" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         u)
             USERNAME=$OPTARG
             ;;
         p)
             PASSWORD=$OPTARG
             ;;
         k)
             API_KEY=$OPTARG
             ;;
         v)
             VERBOSE=1
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

# If no username provided then exit
if [[ -z $USERNAME ]]; then
    echo -e "\nNO username provided\n"
    usage
    exit 1
fi

# If no password or api key provided then exit
if [[ -z $PASSWORD ]] && [[ -z $API_KEY ]]; then
    echo -e "\nONLY username provided\n"
    usage
    exit 1
fi

# if both password and api key provided then exit
if ! [[ -z $PASSWORD ]] && ! [[ -z $API_KEY ]]; then
    echo -e "\nBOTH username and api key provided\n"
    usage
    exit 1
fi


#if ! [[ -z $USERNAME ]]  
#    then
#        if ! [[ -z $PASSWORD ]]; then
#        echo "username and password"
#        fi
#        if ! [[ -z $API_KEY ]]; then
#        echo "username and api_key"
#        fi
#fi

# If combination of username and password 
if ! [[ -z $USERNAME ]] && ! [[ -z $PASSWORD ]]; then
    # Authenticate  
    curl -s -k -X POST https://identity.api.rackspacecloud.com/v2.0/tokens -d '{"auth":{"passwordCredentials":{"username":"'$USERNAME'","password":"'$PASSWORD'"}}}' -H "Content-type: application/json" | python -m json.tool
    exit 0
fi

# If combination of username and api key
if ! [[ -z $USERNAME ]] && ! [[ -z $API_KEY ]]; then
    # Authenticate
    curl -s -k -X POST https://identity.api.rackspacecloud.com/v2.0/tokens -d '{ "auth":{ "RAX-KSKEY:apiKeyCredentials":{ "username":"'$USERNAME'", "apiKey":"'$API_KEY'" } } }' -H "Content-type: application/json" | python -m json.tool
    exit 0
fi

