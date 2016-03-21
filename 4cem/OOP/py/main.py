#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pygame
import miner
import block
from pygame import *

window_width = 800
window_height = 640
display_dict = (window_width, window_height)
background_color = "#000000"


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


def main():
    pygame.init()  # Инициация PyGame, обязательная строчка
    screen = pygame.display.set_mode(display_dict)  # Создаем окошко
    pygame.display.set_caption("Space Miner")  # Пишем в шапку
    timer = pygame.time.Clock()
    bg = Surface(display_dict)  # Создание видимой поверхности

    bg.fill(Color(background_color))

    hero = miner.Miner(455, 455)
    left = right = False
    up = False

    entities = pygame.sprite.Group()
    platforms = []
    entities.add(hero)
    level = [
       "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
       "b                                b",
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
       "b                            --- b",
       "----------------- ----------------",
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
       "-----       ----  ---------------",
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
    platform_width = 32
    platform_height = 32

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
            x += platform_width
        y += platform_height
        x = 0

    total_level_width = len(level[0])*platform_width
    total_level_height = len(level)*platform_height   # высоту

    camera = Camera(camera_configure, total_level_width, total_level_height)
    while 1:
        timer.tick(60)
        for e in pygame.event.get():
            if e.type == QUIT:
                raise (SystemExit, "QUIT")
            if e.type == KEYDOWN and e.key == K_UP:
                up = True
            if e.type == KEYUP and e.key == K_UP:
                up = False
            if e.type == KEYDOWN and e.key == K_LEFT:
                print "hero turn left"
                left = True
            if e.type == KEYDOWN and e.key == K_RIGHT:
                print "hero turn right"
                right = True
            if e.type == KEYUP and e.key == K_RIGHT:
                right = False
            if e.type == KEYUP and e.key == K_LEFT:
                left = False

        screen.blit(bg, (0, 0))      # Каждую итерацию необходимо всё перерисовывать
        for e in entities:
            screen.blit(e.image, camera.apply(e))
        camera.update(hero)  # центризируем камеру относительно персонажа

        hero.update(left, right, up, platforms)
        pygame.display.update()

if __name__ == "__main__":
    main()
