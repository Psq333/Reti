import os
path = "../Esercizio3"
ex = os.popen("ls ../Reti/Layer7/Esercitazione1/Esercizio3")
ris = ex.read()
print(ris)