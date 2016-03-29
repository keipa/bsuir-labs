#!/usr/bin/env python
# -*- coding: utf-8 -*-


import miner
import block
from pygame import *
from menu import *
from random import *

window_width = 800
window_height = 640
display_dict = (window_width, window_height)
background_color = "#000000"
platform_width = 32
platform_height = 32
level = []
platforms = []
entities = pygame.sprite.Group()



class Camera(object):
    def __init__(self, camera_func, width, height):
        self.camera_func = camera_func
        self.state = Rect(0, 0, width, height)

    def apply(self, target):
        return target.rect.move(self.state.topleft)

    def update(self, target):
        self.state = self.camera_func(self.state, target.rect)


def camera_configure(camera, target_rect):
    l, t, _, _ = target_rect
    _, _, w, h = camera
    l, t = -l+window_width / 2, -t+window_height / 2

    l = min(0, l)
    l = max(-(camera.width-window_width), l)
    t = max(-(camera.height-window_height), t)
    t = min(0, t)
    return Rect(l, t, w, h)


def delete_level_particles(digged_block):
    platforms.remove(digged_block)
    x = digged_block.x
    y = digged_block.y
    digged_block = block.NullBlock(x, y)
    platforms.append(digged_block)
    entities.add(digged_block)



def generate_level():
    random_level = []
    level_width = randint(30, 40)
    level_height = randint(100, 200)
    line = ""
    for _ in range(level_width):
        line += "b"
    random_level.append(line)
    for i in range(level_height):
        line = ""
        line += "b"
        for j in range(level_width):
            if i < 10:
                line += " "
            if 10 <= i < 35:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10<ground_or_nothing < 20:
                    line += "f"
                else:
                    line += "-"

            if 35 <= i < 65:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 20:
                    line += "s"
                if 20 < ground_or_nothing < 30:
                    line += "f"
                else:
                    line += "-"
            if 65 <= i < 75:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 20:
                    line += "s"
                if 20 < ground_or_nothing < 30:
                    line += "f"
                if 30 < ground_or_nothing < 50:
                    line += "o"
                else:
                    line += "-"
            if 75 <= i < 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 15:
                    line += "s"
                if 15 < ground_or_nothing < 20:
                    line += "f"
                if 20 < ground_or_nothing < 50:
                    line += "o"
                if 50 < ground_or_nothing < 60:
                    line += "m"
                else:
                    line += "-"
            if i > 80:
                ground_or_nothing = randint(0, 100)
                if ground_or_nothing < 10:
                    line += " "
                if 10 < ground_or_nothing < 15:
                    line += "s"
                if 15 < ground_or_nothing < 20:
                    line += "f"
                if 20 < ground_or_nothing < 30:
                    line += "o"
                if 50 < ground_or_nothing < 70:
                    line += "m"
                if 70 < ground_or_nothing < 80:
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
       "b                                b",
       "b           b  g             --- b",
       "----------------- ---- -----------",
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


def back_to_menu():
    pass


def main(selected_level):
    pygame.init()  # Инициация PyGame, обязательная строчка
    screen = pygame.display.set_mode(display_dict)  # Создаем окошко

    timer = pygame.time.Clock()
    bg = Surface(display_dict)  # Создание видимой поверхности

    bg.fill(Color(background_color))

    hero = miner.Miner(350, 255)
    left = right = down = up = False

    entities.add(hero)

    # b - border
    # g - gasoline
    # - - ground
    if selected_level == "generate":
        level = generate_level()
    if selected_level == "test":
        level = custom_level()
    font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 72)
    # выводим надпись
    text = font.render("loading...", 1, (250, 250, 250))
    screen.blit(text, (300, 300))
    pygame.display.update()
    x = y = 0
    for row in level:
        for col in row:
            if col == "-":
                pf = block.Platform(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "b":
                pf = block.Border(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "g":
                pf = block.ValueBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "f":
                pf = block.FerrumBlock(x,y)
                entities.add(pf)
                platforms.append(pf)
            if col == "s":
                pf = block.SilverBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "m":
                pf = block.MalahitBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "r":
                pf = block.RubyBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "o":
                pf = block.GoldBlock(x, y)
                entities.add(pf)
                platforms.append(pf)

            else:
                pf = block.NullBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            x += platform_width
        y += platform_height
        x = 0


    total_level_width = len(level[0])*platform_width
    total_level_height = len(level)*platform_height   # высоту

    camera = Camera(camera_configure, total_level_width, total_level_height)
    while 1:
        timer.tick(60)
        hero.fuel -= 0.5
        print "Fuel: ", hero.fuel
        for e in pygame.event.get():
            if e.type == QUIT:
                raise (SystemExit, "QUIT")
            if e.type == KEYDOWN and e.key == K_UP:
                up = True
                hero.fuel -= 1.25
            if e.type == KEYUP and e.key == K_UP:
                up = False
            if e.type == KEYDOWN and e.key == K_LEFT:
                print "hero turn left"
                left = True
                hero.fuel -= 1
            if e.type == KEYDOWN and e.key == K_RIGHT:
                print "hero turn right"
                right = True
                hero.fuel -= 1
            if e.type == KEYUP and e.key == K_RIGHT:
                right = False
            if e.type == KEYUP and e.key == K_LEFT:
                left = False
            if e.type == KEYDOWN and e.key == K_DOWN:
                down = True
                hero.fuel -= 1.5
            if e.type == KEYUP and e.key == K_DOWN:
                down = False
            if e.type == KEYDOWN and e.key == K_g:
                # menu.init()
                hero.alive()

            if e.type == KEYDOWN and e.key == K_ESCAPE:
                # menu.initiate()
                # font_path =
                # font = pygame.font.Font
                font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 72)
                # выводим надпись
                text = font.render(("Exit..."), 1, (250, 250, 200))
                screen.blit(text, (150, 100))
                pygame.display.update()
                time.wait(1000)
                back_to_menu()
        if hero.fuel < 0:
            font = pygame.font.Font(None, 72)
            # выводим надпись
            text = font.render("You lose", 1, (200, 0, 0))
            screen.blit(text, (150, 100))
            pygame.display.update()
            time.wait(5000)
            hero.alive()
            hero.fuel = 1000

        camera.update(hero)  # центризируем камеру относительно персонажа
        hero.update(left, right, up, down, platforms)
        screen.blit(bg, (0, 0))

        for e in entities:
            screen.blit(e.image, camera.apply(e))


        pygame.display.update()

if __name__ == "__main__":
    main()
