import socket
from threading import *
import config

serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
host = config.TCP_IP
port = config.TCP_PORT
print(host)
print(port)
serversocket.bind((host, port))


class Client(Thread):
    def __init__(self, socket, address):
        self.sock = socket
        self.addr = address

    def run(self):
        while True:
            data = self.sock.recv(30)
            if not data:
                continue
            print(current_thread())
            print(str(self.sock.getpeername()[0]) + ' sent:', data.decode())  # processing


serversocket.listen(5)
print('server started and listening')
while 1:
    clientsocket, address = serversocket.accept()
    a = Client(clientsocket, address)
    t1 = Thread(target=a.run).start()

