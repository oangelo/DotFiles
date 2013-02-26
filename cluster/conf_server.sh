#!/bin/bash
cp nodes /var/spool/torque/server_priv/
systemctl enable torque-server
systemctl enable torque-scheduler

pacman -S 
cp sshd_config /etc/ssh/
