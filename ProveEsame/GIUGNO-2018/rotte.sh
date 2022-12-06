
#F1
#CD1 -> CD3
route add -net 10.0.4.0/24 gw F2[eth1] dev eth1
#CD1 -> CD4
route add -net 10.0.0.0/23 gw F2[eth1] dev eth1


#F2
#CD2 -> CD1
route add -net 10.0.2.0/25 gw R1[eth1] dev eth0

