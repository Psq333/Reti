import os
from socket import *

os.chdir("../Reti/Layer7/Esercitazione1/Esercizio3")

def checkDir(dirName):
    return os.path.exists(dirName) or os.path.isdir(dirName)

serverPort = 6788

welcomeSocket = socket(AF_INET, SOCK_STREAM)
welcomeSocket.bind(('', serverPort))
welcomeSocket.listen(5)
path_corrente = "../Reti/Layer7/Esercitazione1/Esercizio3"

while 1:
    
    connSocket, addr = welcomeSocket.accept()
    comand = connSocket.makefile().readline()
    divisione = comand.split()
    match divisione[0]:
        case "ls":
            ex = os.popen("ls")
            ris = ex.read()
            div = ris.split("\n")
            for i in div:
                connSocket.makefile("w").writelines(i+"\n")
                print(i)
            connSocket.makefile("w").writelines("")
        case "cat":
            pass
        case "cd":
            pass
        case _:
            connSocket.makefile("w").writelines("comando sconosciuto\n")
    connSocket.close()
