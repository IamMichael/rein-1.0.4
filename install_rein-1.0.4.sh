#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE}")" ; pwd -P )
cd "$parent_path"

if [[ $UID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

cp -r rein  /usr/local
cp rein.service /etc/systemd/system

systemctl daemon-reload
systemctl start  rein.service
systemctl enable rein.service
systemctl status rein.service

