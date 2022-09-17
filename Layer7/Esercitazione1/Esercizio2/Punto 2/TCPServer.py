from socket import *

serverPort = 6789

welcomeSocket = socket(AF_INET,SOCK_STREAM)
welcomeSocket.bind(('',serverPort)) 
welcomeSocket.listen(5)  

line = []

while 1:
  
    connectionSocket, addr = welcomeSocket.accept() 
    clientSentence = connectionSocket.makefile().readline()
    if clientSentence == "END":
        break
    line.append(clientSentence)
    if len(line) == 3:
        for i in line:
            capitalizedSentence = i.upper() 
            connectionSocket.makefile("w").writelines(capitalizedSentence+"\n")
    
    line = []

connectionSocket.close()