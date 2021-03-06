#!/bin/bash

usage()
{
cat << EOF
This script will configure a salt master or minion.

usage: $0 [-m, --master ] [-s, --minion]

INCLUDED
 minion: salt 
 master: salt, salt-cloud, salt-api
EOF
}

# Execute getopt on the arguments passed to this program, identified by the special character $@
PARSED_OPTIONS=$(getopt -n "$0"  -o hms --long "help,master,minion:"  -- "$@")
 
#Bad arguments, something has gone wrong with the getopt command.
if [ $? -ne 0 ];
then
  exit 1
fi
 
# A little magic, necessary when using getopt.
eval set -- "$PARSED_OPTIONS"
 
 
# Now goes through all the options with a case and using shift to analyse 1 argument at a time.
#$1 identifies the first argument, and when we use shift we discard the first argument, so $2 becomes $1 and goes again through the case.
while true;
do
  case "$1" in
 
    -h|--help)
     usage
     shift;;
 
    -m|--master)
      MASTER=1
      shift;;
 
    -s|--minion)
      MINION=1
      shift;;

    --)
      shift
      break;;

    ?)
      usage
      exit;;
  esac
done

# Check that we have one install option selected
if [[ $MASTER -ne 1 ]] && [[ $MINION -ne 1 ]]; then
    usage
    exit
else
  if [[ $MASTER = 1 ]] && [[ $MINION = 1 ]]; then
    usage
    exit
  fi
fi

# Check what distribution we are using
OS=`/usr/bin/lsb_release -i | awk -F ":" '{gsub(/\s+/, "");print $2}' | tr '[:upper:]' '[:lower:]'`

if [ $OS = 'ubuntu' ]; then
    echo "OS is $OS"
    INSTALL='/usr/bin/apt-get'
elif [ $OS =  'centos' ]; then
    echo "OS is $OS"
    INSTALL='/usr/bin/yum'
else
    echo "OS is $OS"
    echo 'Unsupported OS'
    exit 1
fi

# Check if we want to configure a minion or master
if [[ $MASTER = 1 ]]; then
    echo "Installing Salt Master"
    # Reminders of what need to be done
    #/usr/bin/curl -L http://bootstrap.saltstack.org | sh -s -- -M -N
    #pip install git+https://github.com/saltstack/salt-cloud.git#egg=salt_cloud
    #$INSTALL salt-api
    #pip install -U halite
fi

if [[ $MINION = 1 ]]; then
    echo "Installing Salt Minion"
    # Reminders of what need to be done
    #/usr/bin/curl -L http://bootstrap.saltstack.org | sh
fi
