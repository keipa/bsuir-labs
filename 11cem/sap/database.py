from Tkinter import *
import sqlite3


class App:
    def __init__(self, master):
        frame = Frame(master, bg="green")

        frame.pack(fill=BOTH)

        self.lb1 = Label(root, text="First Name")
        self.lb2 = Label(root, text="Last Name")

        self.lb1.place(x=10, y=40)
        self.lb2.place(x=10, y=60)
        self.e1 = Entry(root)
        self.e2 = Entry(root)

        self.e1.place(x=80, y=40)
        self.e2.place(x=80, y=60)

        self.button = Button(frame, text="QUIT", fg="red", command=self.exitt)
        self.button.pack(side=LEFT)
        self.hi_there = Button(frame, text="Select", fg="blue", command=self.say_hi)
        self.hi_there.pack(side=LEFT)

    def say_hi(self):
        print("First Name: %s\nLast Name: %s" % (self.e1.get(), self.e2.get()))

    def exitt(self):
        root.destroy()


root = Tk()
root.geometry("400x200")
app = App(root)
mainloop()
