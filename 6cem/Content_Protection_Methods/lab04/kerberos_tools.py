import socket
import random
import time
from Crypto.Cipher import AES
from Crypto import Random


def extend_password(password):
	extended_password = password
	if len(password) < 16:
		for i in range(16 - len(password)):
			extended_password += '0'
	return extended_password.encode()


def encrypt(text, password):
	iv = Random.new().read(16)
	obj = AES.new(extend_password(password), AES.MODE_CFB, iv)
	cipher = iv + obj.encrypt(text)
	return cipher


def decrypt(cipher, password):
	iv = cipher[:16]
	obj = AES.new(extend_password(password), AES.MODE_CFB, iv)
	text = obj.decrypt(cipher)[16:]
	return text


def generate_key(seed_offset=0):
	random.seed(time.time() + seed_offset)
	session_key = ""
	for i in range(16):
		session_key += chr(random.randint(97, 122))
	return session_key


def create_ticket(server_name, client_name, client_addr, exp_date, session_key, secret_key):
	client_info = "{0},{1},{2},{3}".format(client_name, client_addr, exp_date, session_key)
	client_info = encrypt(client_info.encode(), secret_key)
	ticket = bytes([len(server_name)]) + server_name.encode() + client_info
	return ticket


def decode_ticket(ticket, secret_key):
	server_name_len = ticket[0]
	server_name = ''.join([chr(ticket[i]) for i in range(1, server_name_len + 1)])
	client_info = decrypt(ticket[server_name_len + 1:], secret_key)
	return (server_name, client_info.decode().split(','))


def authentication(password, as_addr, client_name, tgs_name):
	socket_as = socket.socket()
	socket_as.connect(as_addr)

	message = client_name + ',' + tgs_name
	print('\nSending message to AS:', '\n-- client name -', client_name,
		'\n-- TGS name -', tgs_name)
	socket_as.send(message.encode())

	session_key = decrypt(socket_as.recv(1024), password).decode()
	session_ticket = socket_as.recv(1024)
	print('\nReceived from AS: \n-- session key -', session_key,
		', \n-- session ticket -', decode_ticket(session_ticket, 'tgssecretkey'))

	socket_as.close()

	return (session_key, session_ticket)


def create_authenticator(client_name, session_key):
	authenticator = "{0},{1}".format(client_name, time.time())
	authenticator = encrypt(authenticator.encode(), session_key)
	return authenticator


def decode_authenticator(authenticator, session_key):
	return decrypt(authenticator, session_key).decode().split(',')


def parse_request(client_request, data_included=True):
	if data_included:
		data_len = client_request[0]
		data = ''.join([chr(client_request[i]) for i in range(1, data_len + 1)])
		client_request = client_request[data_len + 1:]
	else:
		data = ''
	authenticator_len = client_request[0]
	authenticator = client_request[1: authenticator_len + 1]
	ticket = client_request[authenticator_len + 1:]
	return (data, authenticator, ticket)


def check_request(server_name, server_name_rec, client_name, client_addr, exp_date, authenticator, addr):
	check_server_name = server_name_rec == server_name
	check_client_name = client_name == authenticator[0]
	received_addr = addr[0] + ':' + client_addr.split(':')[1]
	check_client_addr = client_addr == received_addr
	is_expired = (float(exp_date) - float(authenticator[1])) <= 0
	return check_server_name and check_client_name and check_client_addr and not is_expired


def accessing(tgs_addr, client_name, server_name, session_key, session_ticket):
	socket_tgs = socket.socket()
	socket_tgs.connect(tgs_addr)

	authenticator = create_authenticator(client_name, session_key)
	message = bytes([len(server_name)]) + server_name.encode()
	message += bytes([len(authenticator)]) + authenticator
	message += session_ticket
	print('\nSending message to TGS: \n-- server name -', server_name,
		', \n-- authenticator -', decode_authenticator(authenticator, session_key),
		', \n-- session ticket -', decode_ticket(session_ticket, 'tgssecretkey'))

	socket_tgs.send(message)

	server_key = decrypt(socket_tgs.recv(1024), session_key).decode()
	server_ticket = socket_tgs.recv(1024)
	print('\nReceived from TGS: \n-- server key -', server_key,
		', \n-- server ticket -', decode_ticket(server_ticket, 'serversecretkey'))

	socket_tgs.close()

	return (server_key, server_ticket)


def requesting(command, server_addr, client_name, server_key, server_ticket):
	socket_server = socket.socket()
	socket_server.connect(server_addr)

	authenticator = create_authenticator(client_name, server_key)
	message = bytes([len(command)]) + command.encode()
	message += bytes([len(authenticator)]) + authenticator
	message += server_ticket
	print('\nSending message to Server: ', '\n-- message -', command,
		', \n-- authenticator -', decode_authenticator(authenticator, server_key),
		', \n-- session ticket -', decode_ticket(server_ticket, 'serversecretkey'))

	socket_server.send(message)

	time_mark = float(decrypt(socket_server.recv(1024), server_key))
	response = socket_server.recv(1024).decode()
	print('\nReceived from Server: \n-- time mark -', time_mark,
		', \n-- response -', response)

	socket_server.close()

	if time_mark != (float(decode_authenticator(authenticator, server_key)[1]) + 1):
		time_mark = ''
		response = ''

	return (time_mark, response)
