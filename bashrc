# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

simple_ssh_copy_id() {
ip="192.168.$1.$2"
echo "copying key to $ip:"
ssh-copy-id root@$ip
}

simple_ssh_connection() {
ip="192.168.$1.$2"
echo "connecting to $ip:"
ssh root@$ip
}

simple_ping() {
ping "192.168.$1.$2"
}

alias s=simple_ssh_copy_id
alias c=simple_ssh_connection
alias p=simple_ping
