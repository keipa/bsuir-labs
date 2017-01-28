import socket
import config


def receiving():
    print("UDP target IP:", config.UDP_IP)
    print("UDP target port:", config.UDP_PORT)
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.bind((config.UDP_IP, config.UDP_PORT))
    while True:
        data = sock.recvfrom(1024)  # buffer size is 1024 bytes
        print(data[0].decode("utf-8"))

receiving()