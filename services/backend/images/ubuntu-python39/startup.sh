#!/bin/bash

# Change the password for the vscode-server user
PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32}) 
sed -i "s\password: password-placement\password: $PASSWORD\g" /home/coder/.config/code-server/config.yaml
echo "Password generated: >> $PASSWORD << for host: $HOSTNAME" >> /proc/1/fd/1

# Start code-server
code-server --bind-addr 0.0.0.0:8080 .