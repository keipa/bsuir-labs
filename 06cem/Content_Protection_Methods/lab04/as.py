import socket
import sqlite3 as db
import time
from configuration import *
import security_core as sc

working = True

def stop():
    working = False


def create_sub_table(db_conn):
    cursor = db_conn.cursor()
    cursor.execute('CREATE TABLE IF NOT EXISTS Subscribers (id INTEGER PRIMARY KEY, name TEXT, password TEXT)')
    db_conn.commit()
    db_conn.close()


def register_client(db_conn, name, password):
    cursor = db_conn.cursor()
    cursor.execute("INSERT INTO Subscribers VALUES (NULL, ?, ?)", (name, password))
    db_conn.commit()
    db_conn.close()


def run():
    sock = socket.socket()
    sock.bind((HOST, AS_PORT))

    sock.listen(1)
    conn, addr = sock.accept()

    print('Connected:', addr)
    while True:
        client_request = conn.recv(1024)
        if not client_request:
            break

        client_name, tgs_name = client_request.decode().split(',')
        print('Recieved client name:', client_name)
        print('Received TGS name:', tgs_name)

        db_conn = db.connect('subscribers.sqlite')
        cursor = db_conn.cursor()
        cursor.execute('SELECT * FROM Subscribers WHERE name = ?', (client_name,))

        client = cursor.fetchone()
        if not client:
            conn.send(sc.encrypt(''.encode(), ''))
            conn.send(b'')
            break

        password = client[2]
        session_key = sc.generate_key()
        client_addr = addr[0] + ':' + str(addr[1])
        exp_date = time.time() + ticket_expire_time
        session_ticket = sc.create_ticket(tgs_name, client_name, client_addr, exp_date, session_key, tgs_key)

        conn.send(sc.encrypt(session_key.encode(), password))
        conn.send(session_ticket)

    conn.close()


if __name__ == '__main__':
    print("Authentication Server launch complete")
    while working:
        run()
