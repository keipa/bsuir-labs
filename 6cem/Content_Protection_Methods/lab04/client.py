import socket
import kerberos_tools as kt

HOST = 'localhost'

SERVER_ADDR = (HOST, 9090)
AS_ADDR = (HOST, 9091)
TGS_ADDR = (HOST, 9092)

CLIENT_NAME = 'alex'
CLIENT_PASSWORD = 'password'
TGS_NAME = 'localtgs'
SERVER_NAME = 'localserver'

server_key = None
server_ticket = None

def start():
	global server_key, server_ticket
	while True:
		command = input('>>')
		if command == 'exit':
			break

		if not server_key and not server_ticket:
			session_key, session_ticket = kt.authentication(CLIENT_PASSWORD, AS_ADDR, CLIENT_NAME, TGS_NAME)
			if session_key == '' and session_ticket == '':
				print('Client', alex, 'is not found!')
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
	start()
