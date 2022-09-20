from socket import *
from time import sleep

nameServer = "127.0.0.1"
portServer = 6788

clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((nameServer, portServer))

comand = input("Inserisci comando: ")
clientSocket.makefile("w").writelines(comand + "\n")

print("Inizio comunicazione:")

cont = clientSocket.makefile().readline()
while cont != "":
    if cont != "":
        print(" - " + cont.strip())
    cont = clientSocket.makefile().readline()


clientSocket.close()