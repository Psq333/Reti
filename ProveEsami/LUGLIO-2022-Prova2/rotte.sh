#Rotte F1
post-up -net add subnetAccorpamentoDMZ/maskAccorpamentoDMZ gw IP[F2[eth2]] dev eth2
post-up -net add subnetAccorpamentoGreen/maskAccorpamentoGreen gw IP[F2[eth2]] dev eth2

#Rotte F2
post-up -net add subnetAccorpamentoGreen/maskAccorpamentoGreen gw IP[R2[eth0]] dev eth0
