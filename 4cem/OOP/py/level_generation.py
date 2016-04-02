from random import *


def random_level():
    random_level = []
    level_width = 30
    level_height = 150
    line = ""
    for _ in range(level_width):
        line += "b"
    random_level.append(line)
    for i in range(level_height):
        line = ""
        line += "b"
        for j in range(level_width):
            if i <= 10:
                line += " "
            if i == 11:
                if j == 15:
                    line += "G"
                if j == 5:
                    line += "U"
                if j == 25:
                    line += "v"
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
                if 10< ground_or_nothing < 20:
                    line += "f"
                else:
                    line += "-"

            if 35 <= i < 65:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 <= ground_or_nothing < 20:
                    line += "s"
                if 20 <= ground_or_nothing < 30:
                    line += "f"
                else:
                    line += "-"
            if 65 <= i < 75:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 <= ground_or_nothing < 20:
                    line += "s"
                if 20 <= ground_or_nothing < 30:
                    line += "f"
                if 30 <= ground_or_nothing < 50:
                    line += "o"
                else:
                    line += "-"
            if 75 <= i < 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 15:
                    line += "s"
                if 15 <= ground_or_nothing < 20:
                    line += "f"
                if 20 <= ground_or_nothing < 50:
                    line += "o"
                if 50 <= ground_or_nothing < 60:
                    line += "m"
                else:
                    line += "-"
            if i > 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 <= ground_or_nothing < 15:
                    line += "s"
                if 15 <= ground_or_nothing < 20:
                    line += "f"
                if 20 <= ground_or_nothing < 30:
                    line += "o"
                if 50 <= ground_or_nothing < 70:
                    line += "m"
                if 70 <= ground_or_nothing < 80:
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
       "b                     v          b",
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
