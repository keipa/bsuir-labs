from Tkinter import *
import sqlite3

conn = sqlite3.connect('example.db')
c = conn.cursor()
try:
   c.execute('''CREATE TABLE stocks2
             (date text, trans text, symbol text, qty real, price real)''')
except:
   pass
c.execute("INSERT INTO stocks2 VALUES ('2006-01-05','BUY','RHAT2',100,35.14)")
conn.commit()
conn.close()
conn = sqlite3.connect('example.db')
c = conn.cursor()
symbol = 'RHAT2'
for row in c.execute("SELECT * FROM stocks2 WHERE symbol = '%s'"%symbol):
   print row
