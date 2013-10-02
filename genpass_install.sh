#!/bin/bash

# Append to .bashrc
cat <<EOF >> ~/.bashrc

# Generate random password
genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
EOF

# Source .bashrc
source ~/.bashrc
