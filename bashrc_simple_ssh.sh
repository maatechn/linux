# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

simple_ssh_copy_id() {
	ip="$HALF_IP.$1.$2"
	echo "copying key to $ip:"
	ssh-copy-id root@$ip
}

simple_remove_ssh_key() {
	ip="$HALF_IP.$1.$2"
	path="/home/$(whoami)/.ssh/known_hosts"
	echo "removing key for $ip from $path:"
	ssh-keygen -f $path -R $ip
}

simple_ssh_connection() {
	ip="$HALF_IP.$1.$2"
	echo "connecting to $ip:"
	ssh root@$ip
}

simple_ping() {
	ping "$HALF_IP.$1.$2"
}

HALF_IP="192.168"

# USAGE:
# Only for netmask 255.255.0.0
# For IP 192.168.X.Y: <cmd> X Y
alias s=simple_ssh_copy_id
alias rk=simple_remove_ssh_key
alias c=simple_ssh_connection
alias p=simple_ping
