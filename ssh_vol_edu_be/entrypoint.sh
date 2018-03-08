#!/bin/dumb-init /bin/sh
set -e

umount_nfs () {
  echo "Unmounting sshfs..."
  umount "$MOUNTPOINT"
  exit
}

echo "Mounting sshfs..."

mkdir -p "$MOUNTPOINT"
sshfs -o "$MOUNT_OPTIONS" -o "$SSH_KEY_OPTIONS" -o "$RECONNECT_OPTIONS" "$USER@$SERVER:$REMOTE_FOLDER" "$MOUNTPOINT"
mount | grep sshfs

trap umount_nfs SIGHUP SIGINT SIGTERM

while true; do sleep 1000; done
