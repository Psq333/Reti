from socket import *
import os

os.chdir("./serverDirectory")

def checkDir(dirName):
    return os.path.exists(dirName) or os.path.isdir(dirName)

def sendContent(connectionSocket):
    connectionSocket.makefile("w").writelines("SENDING FOLDER CONTENT\n")
    currentDirectory = os.getcwd()
    listFiles = os.listdir(currentDirectory)
    for file in listFiles:
        connectionSocket.makefile("w").writelines(file+"\n")
    print ("SENT CONTENT")

def sendFile(filename, connectionSocket):
    connectionSocket.makefile("w").writelines("SEND FILE " + filename + "\n")
    if checkDir(filename):
        file = open(filename, "r")
        for line in file:
            connectionSocket.makefile("w").writelines(line)
        connectionSocket.makefile("w").writelines("\n")
    print("SENT FILE " + filename)

def switchFolder(newFolder, connectionSocket):
    if checkDir(newFolder):
       os.chdir(newFolder)
    connectionSocket.makefile("w").writelines("CURRENT FOLDER " + os.getcwd() + "\n")
    print("SWITCH FOLDER " + newFolder)

serverPort = 6889

welcomeSocket = socket(AF_INET, SOCK_STREAM)
welcomeSocket.bind(('', serverPort))
welcomeSocket.listen(5) # Parametro backlog --> numero di connessioni sospese prima di rifiutare la nuove connessioni
print ("SERVER LISTENING")

while 1:
    connectionSocket, addr = welcomeSocket.accept()

    cmd = connectionSocket.makefile().readline()
    while cmd.lower() != "<exit>\n" and cmd != '':

        if cmd.lower() == "ls\n":
            sendContent(connectionSocket)
        elif cmd.lower().startswith("cat"):
            filename = cmd[3:-1].strip()
            sendFile(filename, connectionSocket)
        elif cmd.lower().startswith("cd"):
            newFolder = cmd[2:-1].strip()
            switchFolder(newFolder, connectionSocket)
        else:
            connectionSocket.makefile("w").writelines("Errore, comando non supportato !\n")

        connectionSocket.makefile("w").writelines("<eof>\n")
        print("SENT EOF")
        cmd = connectionSocket.makefile().readline()
        if cmd == '':
            print("CLIENT STREAM INTERRUPTED")

    connectionSocket.close()


