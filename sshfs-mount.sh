#!/bin/bash

# Mounting volume using ssh key via ssh protocol
#Requirements: id_rsa key and hosts.list file (Structure: IP Hostname in this case) 

SSH_KEY_OPTIONS="IdentityFile=id_rsa"
RECONNECT_OPTIONS="reconnect,ServerAliveInterval=15,ServerAliveCountMax=20480"
MOUNT_OPTIONS="nonempty,StrictHostKeyChecking=no"
REMOTE_FOLDER="/opt/escenic"
USER="unitb"

# works with hostnames as they are already in /etc/hosts
awk '{ print $2 }' hosts.list |  while read output
do

  #echo "Mounting sshfs..."
  echo "Mounting $output "
  mkdir -p "/mounts/$output"
  #echo "Mountpoint $MOUNTPOINT"
  sshfs -o "$MOUNT_OPTIONS" -o "$SSH_KEY_OPTIONS" -o "$RECONNECT_OPTIONS" "$USER@$output:$REMOTE_FOLDER" "/mounts/$output"
  sleep 1
done
