from Tkinter import *
import sqlite3


class App:
    def __init__(self, master):

        frame = Frame(master, bg="green")

        frame.pack(fill=BOTH)

        self.button = Button(frame, text="QUIT", fg="red", command=self.exitt)
        self.button.pack(side=LEFT)
        self.hi_there = Button(frame, text="Select", fg="blue", command=self.say_hi)
        self.hi_there.pack(side=LEFT)

        self.select = Button(frame, text="Find", fg="green", command=self.dbase)
        self.select.pack(side=LEFT)

        self.w = Text(frame, height=1, width=35, font='Arial 10', wrap=WORD)
        self.w.pack(side=RIGHT)

        self.li = ['Carl', 'Patrick', 'Lindsay', 'Helmut', 'Chris', 'Gwen']
        self.listb = Listbox(root)  # Create 2 listbox widgets
        for item in self.li:
            self.listb.insert(0, item)

        self.listb.place(x=22, y=40)

    def say_hi(self):
        item = self.listb.curselection()
        self.w.delete('1.0', END)
        self.w.insert(1.0, self.li[len(self.li) - 1 - item[0]])

    def exitt(self):
        root.destroy()

        # ++++++++++++++++++++++++++++

        # conn = sqlite3.connect('example.db')
        # c = conn.cursor()
        # try:
        #     c.execute('CREATE TABLE stocks2 (date text, trans text, symbol text, qty real, price real)')
        # except:
        #     pass
        # s = StringVar()
        # item = self.listb.curselection()
        #
        # s = self.li[len(self.li) - 1 - item[0]]
        # c.execute("INSERT INTO stocks2 VALUES ('2006-01-05','BUY','" + s + "'" + ",100,35.14)")
        # conn.commit()
        # conn.close()

    def dbase(self):
        conn = sqlite3.connect('example.db')
        c = conn.cursor()
        symbol = s
        for _ in c.execute("SELECT * FROM stocks2 WHERE symbol = '%s'" % symbol):
            print c.fetchone()
            break


# ++++++++++++++++++++++++++++
root = Tk()
root.geometry("400x200")
app = App(root)

root.mainloop()

