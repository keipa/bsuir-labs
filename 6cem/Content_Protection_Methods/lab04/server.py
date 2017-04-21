import socket
from configuration import *
import security_core as kt
import datetime
import time

working = True


def stop():
    working = False


def make_response(message):
    return str(time.time())


def run():
    sock = socket.socket()
    sock.bind((HOST, RESOURCE_PORT))

    sock.listen(1)
    conn, addr = sock.accept()

    print('Connected:', addr)

    while True:
        client_request = conn.recv(1024)
        if not client_request:
            break

        message, authenticator, server_ticket = kt.parse_request(client_request)
        server_ticket = kt.decode_ticket(server_ticket, server_key)

        server_name = server_ticket[0]
        client_name = server_ticket[1][0]
        client_addr = server_ticket[1][1]
        exp_date = server_ticket[1][2]
        session_server_key = server_ticket[1][3]

        authenticator = kt.decode_authenticator(authenticator, session_server_key)

        print('Recieved message:', message)
        print('Received authenticator:', authenticator)
        print('Received server ticket:', server_ticket)

        if kt.check_request(SERVER_NAME, server_name, client_name, client_addr, exp_date, authenticator, addr):
            time_mark = str(float(authenticator[1]) + 1)
            response = make_response(message)

            conn.send(kt.encrypt(time_mark.encode(), session_server_key))
            conn.send(response.encode())
        else:
            conn.send(kt.encrypt('0'.encode(), session_server_key))
            conn.send(b'')
            break

    conn.close()


if __name__ == '__main__':
    print("Main Resource Server launch complete.")
    while working:
        run()
