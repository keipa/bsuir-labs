import socket
from configuration import *
import security_core as kt



working = True


def stop():
    working = False


def run():
    sock = socket.socket()
    sock.bind((HOST, TGS_PORT))

    sock.listen(1)
    conn, addr = sock.accept()

    print('Connected:', addr)

    while True:
        client_request = conn.recv(1024)
        if not client_request:
            break

        server_name, authenticator, session_ticket = kt.parse_request(client_request)
        session_ticket = kt.decode_ticket(session_ticket, tgs_key)

        tgs_name = session_ticket[0]
        client_name = session_ticket[1][0]
        client_addr = session_ticket[1][1]
        exp_date = session_ticket[1][2]
        session_key = session_ticket[1][3]

        authenticator = kt.decode_authenticator(authenticator, session_key)

        print('Received server name:', server_name)
        print('Received authenticator:', authenticator)
        print('Received session ticket:', session_ticket)

        if kt.check_request(TGS_NAME, tgs_name, client_name, client_addr, exp_date, authenticator, addr):
            session_server_key = kt.generate_key(seed_offset=1)
            client_addr = addr[0] + ':' + str(addr[1])
            server_ticket = kt.create_ticket(server_name, client_name, client_addr, exp_date, session_server_key,
                                             server_key)

            conn.send(kt.encrypt(session_server_key.encode(), session_key))
            conn.send(server_ticket)
        else:
            conn.send(kt.encrypt(''.encode(), session_key))
            conn.send(b'')
            break

    conn.close()


if __name__ == '__main__':
    print("Ticket-Granting Server launch complete.")

    while working:
        run()
