#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Импортируем библиотеку pygame
import pygame
import miner
from pygame import *

#Объявляем переменные
window_width = 800 #Ширина создаваемого окна
window_height = 600 # Высота
display_dict = (window_width, window_height) # Группируем ширину и высоту в одну переменную
background_color = "#003300"

def main():
    pygame.init() # Инициация PyGame, обязательная строчка
    screen = pygame.display.set_mode(display_dict) # Создаем окошко
    pygame.display.set_caption("Space Miner") # Пишем в шапку
    bg = Surface(display_dict) # Создание видимой поверхности
    bg.fill(Color(background_color))
    hero = miner.Miner(55, 55)
    left = right = False
    level = [
           "-------------------------",
           "-                       -",
           "-                       -",
           "-                       -",
           "-            --         -",
           "-                       -",
           "--                      -",
           "-                       -",
           "-                   --- -",
           "-                       -",
           "-                       -",
           "-      ---              -",
           "-                       -",
           "-   -----------         -",
           "-                       -",
           "-                -      -",
           "-                   --  -",
           "-                       -",
           "-                       -",
           "-***********************-"]
    platform_width = 32
    platform_height = 32
    platform_color = "#006262"
    ground_color = "#124315"
    x = y = 0
    for row in level:
        for col in row:
            if col == "-":
                bg = Surface(display_dict)
                bg.fill(Color(platform_color))
                screen.blit(bg, (x, y))
            if col == "*":
                bg = Surface(display_dict)
                bg.fill(Color(ground_color))
                screen.blit(bg, (x, y))
            x += platform_width
        y += platform_height
        x = 0

    while 1:
        for e in pygame.event.get():
            if e.type == QUIT:
                raise SystemExit, "QUIT"
            if e.type == KEYDOWN and e.key == K_LEFT:
                left = True
            if e.type == KEYDOWN and e.key == K_RIGHT:
                right = True
            if e.type == KEYUP and e.key == K_RIGHT:
                right = False
            if e.type == KEYUP and e.key == K_LEFT:
                left = False

        screen.blit(bg, (0, 0))      # Каждую итерацию необходимо всё перерисовывать
        hero.update(left, right)
        hero.draw(screen)
        pygame.display.update()     # обновление и вывод всех изменений на экран

if __name__ == "__main__":
    main()
