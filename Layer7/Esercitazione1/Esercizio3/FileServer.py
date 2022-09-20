import os
from socket import *

serverPort = 6789

welcomeSocket = socket((AF_INET, SOCK_STREAM))
welcomeSocket.bind(('', serverPort))
welcomeSocket.listen(5)
path = "../Esercizio3/file.txt"

while 1:
    connSocket, addr = welcomeSocket.accept()
    comand = connSocket.makefile().readline()
    divisione = comand.split()
    match divisione[0]:
        case "ls":
            esecuzione = os.popen("ls")
        case "cat":
            pass
        case "cd":
            pass
        case _:
            connSocket.makefile("w").writeline("comando sconosciuto\n")
