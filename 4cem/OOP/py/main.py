#!/usr/bin/env python
# -*- coding: utf-8 -*-

import miner
import block
from pygame import *
from menu import *
import level_generation
import interface
import pause_menu
import pickle

window_width = 800
window_height = 640
display_dict = (window_width, window_height)
background_color = "#000000"
platform_width = 32
platform_height = 32
level = []
platforms = []
entities = pygame.sprite.Group()


def level_string(level):
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
                pf = block.FuelTriggerBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "G":
                pf = block.GasolineStationBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "u":
                pf = block.UpdateTriggerBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "U":
                pf = block.UpgradeStationBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            if col == "f":
                pf = block.FerrumBlock(x, y)
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
            if col == "w":
                pf = block.WallpaperBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            else:
                pf = block.NullBlock(x, y)
                entities.add(pf)
                platforms.append(pf)
            x += platform_width
        y += platform_height
        x = 0

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
    entities.remove(digged_block)
    x = digged_block.x
    y = digged_block.y
    digged_block = block.NullBlock(x, y)
    platforms.append(digged_block)
    entities.add(digged_block)


def back_to_menu():
    pass


def load_level_from_file():
    hero = miner.Miner(350, 265)
    f = open('savings\hero.dd', 'wb')
    pickle.dump(hero, f, 2)
    f.close()
    l = open('savings\level.dd', 'wb')
    pickle.dump(platforms, l, 2)
    l.close()
    for each in platforms:
        entities.add(each)
    return hero


def main(selected_level):
    pygame.init()  # Инициация PyGame, обязательная строчка
    screen = pygame.display.set_mode(display_dict)  # Создаем окошко
    timer = pygame.time.Clock()
    bg = Surface(display_dict)  # Создание видимой поверхности
    bg.fill(Color(background_color))
    hero = miner.Miner(350, 265)
    left = right = down = up = False
    entities.add(hero)

    # b - border
    # g - gasoline
    # - - ground
    if selected_level == "generate":
        level = level_generation.random_level()
        level_string(level)
        total_level_width = len(level[0]) * platform_width
        total_level_height = len(level) * platform_height   # высоту
    if selected_level == "test":
        level = level_generation.custom_level()
        level_string(level)
        total_level_width = len(level[0]) * platform_width
        total_level_height = len(level) * platform_height   # высоту
    if selected_level == "load":
        hero = load_level_from_file()
        total_level_height = 150 * platform_height
        total_level_width = 45 * platform_width

    font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 72)
    # выводим надпись
    text = font.render("loading...", 1, (250, 250, 250))
    screen.blit(text, (300, 300))
    pygame.display.update()


    previous_speed = 0
    camera = Camera(camera_configure, total_level_width, total_level_height)
    pygame.mixer.music.load('ena.mp3')
    pygame.mixer.music.play(0)
    while 1:

        timer.tick(100)
        for e in pygame.event.get():
            if e.type == QUIT:
                raise (SystemExit, "QUIT")
            if e.type == KEYDOWN and e.key == K_UP:
                up = True
                hero.current_fuel -= 1.25
            if e.type == KEYUP and e.key == K_UP:
                up = False
            if e.type == KEYDOWN and e.key == K_LEFT:
                left = True
                hero.current_fuel -= 4
            if e.type == KEYDOWN and e.key == K_RIGHT:
                right = True
                hero.current_fuel -= 2
            if e.type == KEYUP and e.key == K_RIGHT:
                right = False
            if e.type == KEYUP and e.key == K_LEFT:
                left = False
            if e.type == KEYDOWN and e.key == K_DOWN:
                down = True
                hero.current_fuel -= 5
            if e.type == KEYUP and e.key == K_DOWN:
                down = False
            if e.type == KEYDOWN and e.key == K_t:
                # menu.init()
                if hero.teleports > 0:
                    hero.alive()
                    hero.teleports -= 1
            if e.type == KEYDOWN and e.key == K_g:
                # menu.init()
                if hero.gasoline_tank > 0:
                    hero.current_fuel += 750
                    hero.gasoline_tank -= 1
            if e.type == KEYDOWN and e.key == K_ESCAPE:

                pause_menu.main(hero, platforms)
        camera.update(hero)  # центризируем камеру относительно персонажа
        screen.blit(bg, (0, 0))
        if abs(previous_speed-hero.vertical_speed) >= 15:
            hero.health -= 50
        previous_speed = hero.vertical_speed

        for e in entities:
            screen.blit(e.image, camera.apply(e))
        hero.current_temperature = (hero.rect.y / 32)*2 /hero.cooling_index
        if hero.current_temperature > hero.critical_temperature:
            hero.health -= 0.4
        if hero.current_fuel < 0 or hero.health < 1:
            font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 72)
            # выводим надпись
            text = font.render("You lose", 1, (250, 250, 250))
            lose_image = image.load("rect.png")
            screen.blit(lose_image, (270, 270))
            screen.blit(text, (300, 300))
            pygame.display.update()
            time.wait(1000)
            hero.alive()
            hero.current_fuel = 1000
            hero.health = 100
        deep = ((hero.rect.y / 32)-10)*2
        hero.update(left, right, up, down, platforms)
        interface.update(screen,
                         deep,
                         hero.vertical_speed,
                         hero.current_capacity,
                         hero.max_capacity,
                         hero.health,
                         hero.max_health,
                         hero.current_temperature,
                         hero.current_fuel,
                         hero.max_fuel,
                         hero.cash,
                         hero.teleports,
                         hero.gasoline_tank)

        pygame.display.update()


if __name__ == "__main__":
    main()
