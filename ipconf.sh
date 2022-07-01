#!/bin/bash

if_path=/etc/net/ifaces
read -p 'Enter network interface name: ' interface

if ! [[ $interface =~ ^[a-zA-Z0-9]+$ ]]; then
echo 'Not valid interface name'
exit 1
fi
if ! [ -d $if_path/$interface ]; then
echo 'Network interface not configured'
exit 1
fi

# format 10.2.0.4/24
current_ip=$(cut -d '/' -f 1 $if_path/$interface/ipv4address)
echo "Checked IP address by $interface: $current_ip"

read -p "Enter new IP address for $interface: " new_ip
# simple validation for ip address
if ! [[ $new_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
echo 'Not valid IP address'
exit 1
fi

read -p "Enter new subnetwork mask (0-32) for $interface: " new_mask
# simple validation for subnetwork mask
if ! [[ $new_mask =~ ^[0-3]*[0-9]$ ]]; then
echo 'Not valid subnetwork mask'
exit 1
fi

ip a flush dev $interface
ip a add $new_ip dev $interface
echo "$new_ip/$new_mask" > $if_path/$interface/ipv4address

sed -i "s/ListenAddress $current_ip/ListenAddress $new_ip/" /etc/openssh/sshd_config
sed -i "s/server_name $current_ip;/server_name $new_ip;/" /etc/nginx/sites-available.d/engine.conf

systemctl restart network.service
systemctl restart sshd.service
systemctl restart nginx.service
