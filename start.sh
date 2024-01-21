#!/bin/bash

/usr/sbin/run-vsftpd.sh&
cd /home/vsftpd/admin/
yarn install
yarn start