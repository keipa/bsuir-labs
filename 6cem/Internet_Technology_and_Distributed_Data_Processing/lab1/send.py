import socket
import config
import random


def send():
    username = get_username()
    port = int(input("enter your friend's port: "))
    send_udp(username + " enters the chat.", port)
    print("\n Chat room is opened. Type something...\n")
    while True:
        message = input()
        send_udp(username + " says: " + message, port)


def get_username():
    file = open("nicknames.txt", "r")
    a = []
    for line in file:
        a.append(line)
    username = random.choice(a).replace("\n", "")
    return username


def send_udp(message, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    sock.sendto(message.encode("utf-8"), (config.UDP_IP, port))



