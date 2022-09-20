from contextlib import nullcontext
from socket import *
from time import sleep

serverPort = 6789

welcomeSocket = socket(AF_INET,SOCK_STREAM)
welcomeSocket.bind(('',serverPort)) 
welcomeSocket.listen(5)  
connectionSocket, addr = welcomeSocket.accept() 
clientSentence = "-"
while 1:
    if clientSentence == "END" or clientSentence == "":
        connectionSocket, addr = welcomeSocket.accept()
        print(" addr: " + str(addr))
        clientSentence = "-"
    else:
        clientSentence = connectionSocket.makefile().readline()
        print ("Client sentence: " + clientSentence)
        capitalizedSentence = clientSentence.upper() 
        connectionSocket.makefile("w").writelines(capitalizedSentence+"\n")


connectionSocket.close()
