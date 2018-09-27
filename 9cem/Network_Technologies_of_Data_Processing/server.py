import socket
from threading import *
import config

serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = "127.0.0.1"
port = config.TCP_PORT
print(host)
print(port)
serversocket.bind((host, port))

class client(Thread):
    def __init__(self, socket, address):
        Thread.__init__(self)
        self.sock = socket
        self.addr = address
        self.start()

    def run(self):
        while 1:
            data = self.sock.recv(20)
            if not data:
                continue
            print(self.sock.getpeername())
            print('Client sent:', data.decode())

serversocket.listen(5)
print('server started and listening')
while 1:
    clientsocket, address = serversocket.accept()
    client(clientsocket, address)
