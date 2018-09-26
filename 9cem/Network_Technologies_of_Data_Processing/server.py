import socket
import config
from time import sleep

def listening(port):
    print("TCP target IP:", config.UDP_IP)
    print("TCP target port:", port)

    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((config.TCP_IP, port))
    sock.listen(1)
    conn, addr = sock.accept()
    print('Connection address:', addr)
    while True:
        data = conn.recv(1024)  # buffer size is 1024 bytes
        if not data: continue
        print("received data:", data)
        sleep(5)

listening(int(input("enter your port: ")))
