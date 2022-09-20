from ast import Is
from contextlib import nullcontext
from socket import *
from time import sleep

serverPort = 6789

welcomeSocket = socket(AF_INET,SOCK_STREAM)
welcomeSocket.bind(('',serverPort)) 
welcomeSocket.listen(5)  
connectionSocket, addr = welcomeSocket.accept() 
print(" addr: " + str(addr))
while 1:
    clientSentence = connectionSocket.makefile().readline()
    if clientSentence == "END\n":
        connectionSocket.close()
        print("Fine connessione - attesa nuova connessione")
        connectionSocket, addr = welcomeSocket.accept()
        print(" addr: " + str(addr))
    else:
        print ("Client sentence: " + clientSentence)
        capitalizedSentence = clientSentence.upper() 
        connectionSocket.makefile("w").writelines(capitalizedSentence+"\n")



