import threading
import recieve
import send


b = threading.Thread(target=recieve.listening,  args=[int(input("enter your port: "))])
b.start()

a = threading.Thread(target=send.send)
a.start()

