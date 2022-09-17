from socket import *

serverPort = 6789

welcomeSocket = socket(AF_INET,SOCK_STREAM)
welcomeSocket.bind(('',serverPort)) 
welcomeSocket.listen(5)  
while 1:
  
    connectionSocket, addr = welcomeSocket.accept() 
    clientSentence = connectionSocket.makefile().readline()
    if clientSentence == "END":
        break
    capitalizedSentence = clientSentence.upper() 
    connectionSocket.makefile("w").writelines(capitalizedSentence+"\n")

connectionSocket.close()