from socket import *

serverPort = 6789

welcomeSocket = socket(AF_INET,SOCK_STREAM)
welcomeSocket.bind(('',serverPort)) 
welcomeSocket.listen(5)  

line = []
connectionSocket, addr = welcomeSocket.accept() 

while 1:
    clientSentence = connectionSocket.makefile().readline()
    if clientSentence == "END\n":
        connectionSocket.close()
        line = []
        print("In attesa di una connessione")
        connectionSocket, addr = welcomeSocket.accept() 
    else:
        line.append(clientSentence)
        print(line)
        if len(line) == 3:
            for i in line:
                capitalizedSentence = i.upper() 
                print(capitalizedSentence)  #Senza questa print, il for non fa l'ultimo ciclo
                connectionSocket.makefile("w").writelines(capitalizedSentence+"\n")
            line = []