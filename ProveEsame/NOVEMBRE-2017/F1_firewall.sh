#!/bin/sh

iptables -F
iptables -X

iptables -P INPUT REJECT
iptables -P OUTPUT REJECT
iptables -P FORWARD REJECT

iptables -A FORWARD -i eth0 -o eth1 -s 10.0.2.0/25 -d 10.0.0.0/23 -p icmp --icmp-type 8 -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -s 10.0.0.0/23 -d 10.0.2.0/25 -p icmp --icmp-type 0 -j ACCEPT
