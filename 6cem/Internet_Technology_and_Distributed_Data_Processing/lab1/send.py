import socket
import config


def send():
    while True:
        MESSAGE = input(">")
        sock = socket.socket(socket.AF_INET,  # Internet
                             socket.SOCK_DGRAM)  # UDP
        sock.sendto(MESSAGE.encode("utf-8"), (config.UDP_IP, config.UDP_PORT))


send()
