import os
path = "../Esercizio3"
os.chdir("../Reti/Layer7/Esercitazione1/Esercizio3")
ex = os.popen("ls")
ris = ex.read()
ciao = ris.split("\n")
print(ciao[0])
