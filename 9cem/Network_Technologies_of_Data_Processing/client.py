import socket
import config
import random


def send():
    username = get_username()
    port = int(input("enter your friend's port: "))
    send_tcp(username + " enters the chat.", port)
    print("\n Chat room is opened. Type something...\n")
    while True:
        
        message = input("$")
        send_tcp(username + " says: " + message, port)


def get_username():
    file = open("nicknames.txt", "r")
    a = []
    for line in file:
        a.append(line)
    username = random.choice(a).replace("\n", "")
    return username


def send_tcp(message, port):
    #use WITH keyword
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect((config.TCP_IP, port))
    sock.send(message.encode("utf-8"))
    print(sock.recv(1024))
    sock.close()

send()
