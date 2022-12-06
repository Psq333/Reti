#!/bin/sh
tutctl -g netdev -t tap0
ifconfig tap0 10.0.14.9
ifconfig tap0 netmask 255.255.255.252
ifconfig tap0 broadcast 10.0.14.11
ifconfig tap0 up
iptables -t nat -A POSTROUTING -o [devconnessoadinternet] -j MAQUERADE
iptables -A FORWARD -i tap0 -j ACCEPT
sysctl -w net.ipv4.ip_forward = 1
route add -net 10.0.0.0/8 gw 10.0.14.10 dev tap0
