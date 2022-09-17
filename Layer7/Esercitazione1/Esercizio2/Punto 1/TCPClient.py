from socket import *

serverName = '127.0.0.1'
serverPort = 6789

clientSocket = socket(AF_INET, SOCK_STREAM) 
clientSocket.connect((serverName,serverPort))

while 1:
    sentence = input('Frase in minuscolo:')
    if sentence == "END":
        break
    clientSocket.makefile("w").writelines(sentence+"\n") 
    modifiedSentence = clientSocket.makefile().readline() 
    print("FROM SERVER: ", modifiedSentence) 

clientSocket.close() 

