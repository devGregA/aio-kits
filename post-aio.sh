#!/bin/bash

echo "source /etc/network/interfaces.d/*.cfg"  >> /etc/network/interfaces
ifup lxcbr0
ifup br-mgmt
ifup br-vxlan
ifup br-storage
ifup br-vlan

lxc-system-manage containers-start
cd /etc/haproxy/conf.d
pwd
ip_addr=$(ifconfig eth0 | grep "inet " | awk -F'[: ]+' '{ print $4 }')
echo $ip_addd
find . -type f -exec sed -i "s/162.242.209.102/$ip_addr/g" {} \;
/etc/init.d/haproxy restart

cd /etc/openstack_deploy
pwd
find . -type f -exec sed -i "s/162.242.209.102/$ip_addr/g" {} \;
