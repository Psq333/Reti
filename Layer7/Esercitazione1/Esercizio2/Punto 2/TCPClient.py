from socket import *

serverName = '127.0.0.1'
serverPort = 6789

clientSocket = socket(AF_INET, SOCK_STREAM) 
clientSocket.connect((serverName,serverPort))

i = 0

while 1:
    sentence = input('Frase in minuscolo:')
    clientSocket.makefile("w").writelines(sentence+"\n")
    if sentence == "END":
        clientSocket.close() 
        break
    i += 1
    if i == 3:
        for j in range(i):
            modifiedSentence = clientSocket.makefile().readline() 
            print("FROM SERVER: ", modifiedSentence)
        i = 0
    



