from Tkinter import *
import sqlite3


class Database:
    def createTable(self):
        connect = sqlite3.connect('students.db')
        cursor = connect.cursor()
        try:
            cursor.execute('''CREATE TABLE students (firstName text, lastName text, groupNumber text, faculty text)''')
        except:
            pass

    def insertStudentInformation(self, studentInformation, listbox):
        connect = sqlite3.connect('students.db')
        cursor = connect.cursor()
        cursor.execute("INSERT INTO students VALUES ('{0}','{1}', '{2}', '{3}')".format(studentInformation.firstName,
                                                                                        studentInformation.lastName,
                                                                                        studentInformation.group,
                                                                                        studentInformation.faculty))
        listbox.insert(0, studentInformation.firstName)
        connect.commit()
        connect.close()

    def getAllStudentInformation(self):
        connect = sqlite3.connect('students.db')
        cursor = connect.cursor()
        students = []
        for item in cursor.execute("SELECT * FROM students"):
            students.append(StudentInformation(item[0], item[1], item[2], item[3]))
        return students

    def findStudents(self, firstName):
        connect = sqlite3.connect('students.db')
        cursor = connect.cursor()
        students = []
        for item in cursor.execute("SELECT * FROM students WHERE firstName = '%s'" % firstName):
            print item
            students.append(StudentInformation(item[0], item[1], item[2], item[3]))
        return students

    def removeStudent(self, student):
        connect = sqlite3.connect('students.db')
        cursor = connect.cursor()
        cursor.execute("DELETE FROM students WHERE firstName = '%s'" % student.firstName)
        connect.commit()
        connect.close()


class StudentInformation:
    def __init__(self, firstName, lastName, group, faculty):
        self.firstName = firstName
        self.lastName = lastName
        self.group = group
        self.faculty = faculty


class App:
    def __init__(self, master):
        entryAndLabelframe = self.createFrame(master, LEFT)

        self.firstName = self.createEntryWithLabel(entryAndLabelframe, "First Name", TOP)
        self.lastName = self.createEntryWithLabel(entryAndLabelframe, "Last Name", TOP)
        self.group = self.createEntryWithLabel(entryAndLabelframe, "Group", TOP)
        self.faculty = self.createEntryWithLabel(entryAndLabelframe, "Faculty", TOP)

        buttonFrame = self.createFrame(entryAndLabelframe, TOP)

        self.insertButton = self.createButton(buttonFrame, "Insert", self.insertAction)
        self.findButton = self.createButton(buttonFrame, "Find", self.findAction)

        databaseInformationFrame = self.createFrame(master, LEFT)

        self.databaseData = Database().getAllStudentInformation()
        self.databaseListbox = self.createListbox(databaseInformationFrame, self.databaseData)

        databaseButtonInformationFrame = self.createFrame(databaseInformationFrame, TOP)

        self.selectButton = self.createButton(databaseButtonInformationFrame, "Select", self.selectAction, DISABLED)
        self.removeButton = self.createButton(databaseButtonInformationFrame, "Remove", self.removeAction, DISABLED)

    def createFrame(self, parentFrame, side):
        currentFrame = Frame(parentFrame)
        currentFrame.pack(fill=BOTH, side=side)
        return currentFrame

    def createEntryWithLabel(self, parentFrame, text, side):
        currentFrame = Frame(parentFrame)
        currentLabel = Label(currentFrame, text=text)
        currentEntry = Entry(currentFrame)
        currentLabel.pack(side=LEFT)
        currentEntry.pack(side=LEFT)
        currentFrame.pack(fill=BOTH, side=TOP)
        return currentEntry

    def createButton(self, parentFrame, text, command, state=NORMAL):
        currentButton = Button(parentFrame, text=text, command=command, state=state)
        currentButton.pack(side=LEFT)
        return currentButton

    def createListbox(self, parentFrame, informationList):
        currentListbox = Listbox(parentFrame)
        currentListbox.bind('<<ListboxSelect>>', self.selectStudent)
        for item in informationList:
            currentListbox.insert(0, item.firstName)
        currentListbox.pack(side=TOP)
        return currentListbox

    def clearAllEntry(self):
        self.firstName.delete(0, END)
        self.lastName.delete(0, END)
        self.group.delete(0, END)
        self.faculty.delete(0, END)

    def selectStudent(self, event):
        widget = event.widget
        self.index = int(widget.curselection()[0])
        value = widget.get(self.index)
        self.students = Database().findStudents(value)
        self.selectButton.configure(state=NORMAL)
        self.removeButton.configure(state=NORMAL)

    def showStudentInformation(self, studentInformation):
        self.firstName.insert(0, studentInformation.firstName)
        self.lastName.insert(0, studentInformation.lastName)
        self.group.insert(0, studentInformation.group)
        self.faculty.insert(0, studentInformation.faculty)

    def selectAction(self):
        self.clearAllEntry()
        self.showStudentInformation(self.students[0])

    def exitAction(self):
        root.destroy()

    def findAction(self):
        students = Database().findStudents(self.firstName.get())

    def insertAction(self):
        student = StudentInformation(self.firstName.get(), self.lastName.get(), self.group.get(), self.faculty.get())
        Database().insertStudentInformation(student, self.databaseListbox)
        self.clearAllEntry()

    def removeAction(self):
        Database().removeStudent(self.students[0])
        self.databaseListbox.delete(self.index, self.index)


Database().createTable()

root = Tk()
root.geometry("500x270")
app = App(root)
mainloop()
