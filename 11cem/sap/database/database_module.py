import sqlite3


database_name = 'example.db'


def create_if_not_exists():
    conn = sqlite3.connect(database_name)
    c = conn.cursor()
    c.execute('CREATE TABLE if not exists students (surname text, [group] real, faculty text)')
    c.close()


def get_all_records():
    conn = sqlite3.connect(database_name)
    c = conn.cursor()
    c.execute('SELECT * from students')
    records = c.fetchall()

    print("Total rows are:  ", len(records))
    for row in records:
        print("surname: ", row[0])
        print("group: ", row[1])
        print("faculty: ", row[2])
        print("\n")
    c.close()
    return records

def find_record(surname):
    conn = sqlite3.connect(database_name)
    c = conn.cursor()
    c.execute('SELECT * from students WHERE surname = \'' + surname.strip() + '\'')
    records = c.fetchall()

    print("Records found:  ", len(records))
    for row in records:
        print("surname: ", row[0])
        print("group: ", row[1])
        print("faculty: ", row[2])
        print("\n")
    c.close()
    return records


def seed_records():
    conn = sqlite3.connect(database_name)
    c = conn.cursor()
    c.execute('insert into students (surname, [group], faculty) VALUES (\'Pupkin\', 5615, \'Physics\')')
    c.execute('insert into students (surname, [group], faculty) VALUES (\'Zaikin\', 32, \'Chemistry\')')
    c.execute('insert into students (surname, [group], faculty) VALUES (\'Malyavin\', 414, \'Mathematics\')')
    c.execute('insert into students (surname, [group], faculty) VALUES (\'Zolotov\', 4141, \'Philisofy\')')
    c.execute('insert into students (surname, [group], faculty) VALUES (\'Volkov\', 2, \'Computer Science\')')

    conn.commit()


def insert_records(surname, group, faculty):
    conn = sqlite3.connect(database_name)
    c = conn.cursor()
    c.execute("insert into students (surname, [group], faculty) VALUES (\'" +surname+"\', " + str(group) + ", \'" +faculty +"\')")
    conn.commit()
    c.close()



# use that commands to create db
# create_if_not_exists()
# seed_records()
# get_all_records()