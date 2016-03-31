from random import *


def random_level():
    random_level = []
    level_width = 30
    line = ""
    for _ in range(level_width):
        line += "b"
    random_level.append(line)
    for i in range(level_height):
        line = ""
        line += "b"
        for j in range(level_width):
                line += " "
            if i == 11:
                if j == 15:
                    line += "G"
                if j == 5:
                    line += "U"
                else:
                    line += " "
            if i == 12:
                line += " "
            if i == 13:
                if j == 15 or j == 16 or j == 17:
                    line += "g"
                elif j == 5 or j == 6 or j == 7:
                    line += "u"
                else:
                    line += "-"
            if 13 < i < 35:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                    line += "f"
                else:
                    line += "-"

            if 35 <= i < 65:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                    line += "s"
                    line += "f"
                else:
                    line += "-"
            if 65 <= i < 75:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                    line += "s"
                    line += "f"
                    line += "o"
                else:
                    line += "-"
            if 75 <= i < 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 15:
                    line += "s"
                    line += "f"
                    line += "o"
                    line += "m"
                else:
                    line += "-"
            if i > 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                    line += "s"
                    line += "f"
                    line += "o"
                    line += "m"
                    line += "r"
                else:
                    line += "-"
        line += "b"
        random_level.append(line)
    line = ""
    for _ in range(level_width):
        line += "b"
    random_level.append(line)
    return random_level


def custom_level():
     my_level = [
       "b-bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
       "-                                b",
       "b                       --       b",
       "b                                b",
       "b            --                  b",
       "b                                b",
       "b-                               b",
       "b                                b",
       "b                   ----     --- b",
       "b                                b",
       "b-                               b",
       "b     U      G                   b",
       "b                            --- b",
       "------uuu----ggg- ---- -----------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----- --    ----- ----------------",
       "----- -- -------- ----------------",
       "-----       ----  ----------------",
       "-------- -- ----- ----------------",
       "-----    -- ----- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------- ----------------",
       "----------------------------------",
       "----------------------------------",
       "----------------------------------",
       "----------------------------------",
       "----------------------------------",
       "----------------------------------"]
     return my_level
