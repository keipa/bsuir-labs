from Tkinter import *
import database_module as data


class App:
    def __init__(self, master):
        frame = Frame(master, bg="green")
        frame.pack(fill=BOTH)

        self.quit_button = Button(frame, text="QUIT", fg="red", command=self.close_window)
        self.quit_button.pack(side=LEFT)

        self.select_button = Button(frame, text="Select All", fg="blue", command=self.get_all_records)
        self.select_button.pack(side=LEFT)

        self.find_button = Button(frame, text="Find", fg="green", command=self.find_records)
        self.find_button.pack(side=LEFT)

        # find records by name
        self.text_box = Text(frame, height=1, width=15, font='Arial 10', wrap=WORD)
        self.text_box.pack(side=LEFT)
        self.text_box.insert(END, "Pupkin")

        self.list_box = Listbox(root, width=30)  # Create 2 listbox widgets
        # self.list_box.place(x=22, y=40)
        self.list_box.pack(side=LEFT)

        self.text_box_surname = Text(frame, height=1, width=6, font='Arial 10', wrap=WORD)
        self.text_box_surname.pack(side=RIGHT)
        self.text_box_surname.insert(END, "Kolkin")

        self.text_box_group = Text(frame, height=1, width=5, font='Arial 10', wrap=WORD)
        self.text_box_group.insert(END, "123")
        self.text_box_group.pack(side=RIGHT)

        self.text_box_faculty = Text(frame, height=1, width=5, font='Arial 10', wrap=WORD)
        self.text_box_faculty.insert(END, "Agra")
        self.text_box_faculty.pack(side=RIGHT)

        self.insert_button = Button(frame, text="Insert", fg="black", command=self.insert_records)
        self.insert_button.pack(side=RIGHT)

    def insert_records(self):
        data.insert_records(self.text_box_surname.get("1.0", END).strip(),int(self.text_box_group.get("1.0", END).strip()),self.text_box_faculty.get("1.0", END).strip())
        self.get_all_records()

    def clear_list_box(self):
        self.list_box.delete(0, END)

    def add_values_into_list(self, values_list):
        for item in values_list:
            self.list_box.insert(0, item[0] + " " + str(item[1]) + " " + item[2])

    def get_all_records(self):
        self.clear_list_box()
        self.add_values_into_list(data.get_all_records())

    def close_window(self):
        root.destroy()

    def find_records(self):
        self.clear_list_box()
        self.add_values_into_list(data.find_record(self.text_box.get("1.0", END)))


root = Tk()
root.geometry("400x200")
app = App(root)

root.mainloop()

