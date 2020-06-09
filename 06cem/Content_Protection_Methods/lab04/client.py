import security_core as kt
from configuration import *

CLIENT_NAME = input("Username: ")
CLIENT_PASSWORD = input("password: ")
server_key = None
server_ticket = None


def run():
    global server_key, server_ticket
    print("KERBEROS Client start complete.")
    while True:
        command = input(":")
        if command == 'exit':
            break

        if not server_key and not server_ticket:
            session_key, session_ticket = kt.authentication(CLIENT_PASSWORD, AS_ADDR, CLIENT_NAME, TGS_NAME)
            if session_key == '' and session_ticket == '':
                print('Client', CLIENT_NAME, 'is not found!')
                break

            server_key, server_ticket = kt.accessing(TGS_ADDR, CLIENT_NAME, SERVER_NAME, session_key, session_ticket)
            if server_key == '' and server_ticket == '':
                print('Access denied!')
                server_key = None
                server_ticket = None
                break

        time_mark, response = kt.requesting(command, SERVER_ADDR, CLIENT_NAME, server_key, server_ticket)
        if time_mark == '' and response == '':
            print('Ticket is expired!')
            server_key = None
            server_ticket = None
            break

        print(response)


if __name__ == '__main__':
    run()
