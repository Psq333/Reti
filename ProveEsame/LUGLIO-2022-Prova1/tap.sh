#!/bin/bash

sudo su
tunctl -g netdev -t tap0
ifconfig tap0 200.0.0.1
ifconfig tap0 netmask 255.255.255.252
ifconfig tap0 broadcast 200.0.0.3
ifconfig tap0 up
iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
iptables -A FORWARD -i tap0 -j ACCEPT
sysctl -w net.ipv4.ip_forward = 1
route add -net 10.0.0.0/8 gw 200.0.0.2 dev tap0
