#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pygame
from pygame.locals import *
import main

if not pygame.display.get_init():
    pygame.display.init()

if not pygame.font.get_init():
    pygame.font.init()


class Menu:
    list = []
    pos = []
    font_size = 32
    font_path = 'data/coders_crux/coders_crux.ttf'
    font = pygame.font.Font
    dest_surface = pygame.Surface
    count_pol = 0
    color_background = (0, 0, 0)
    color_text = (252, 214, 27)
    color_back_of_text = (190, 3, 10)
    current_position = 0
    position_tuple = (0, 0)
    menu_width = 0
    menu_height = 0

    class rectang:
        text = ''
        pole = pygame.Surface
        pole_rect = pygame.Rect
        rect = pygame.Rect

    def move_menu(self, top, left):
        self.position_tuple = (top, left)

    def set_colors(self, text, selection, background):
        self.color_background = background
        self.color_text = text
        self.color_back_of_text = selection
        
    def set_font_size(self, font_size):
        self.font_size = font_size
        
    def set_font(self, path):
        self.font_path = path
        
    def get_position(self):
        return self.current_position
    
    def init(self, list, dest_surface):
        self.list = list
        self.dest_surface = dest_surface
        self.count_pol = len(self.list)
        self.create_structure()
        
    def draw(self, moving=0):
        if moving:
            self.current_position += moving
            if self.current_position == -1:
                self.current_position = self.count_pol - 1
            self.current_position %= self.count_pol
        menu = pygame.Surface((self.menu_width, self.menu_height))
        menu.fill(self.color_background)
        selected_rect= self.pos[self.current_position].zaznaczenie_rect
        pygame.draw.rect(menu, self.color_back_of_text, selected_rect)

        for i in xrange(self.count_pol):
            menu.blit(self.pos[i].pole, self.pos[i].pole_rect)
        self.dest_surface.blit(menu, self.position_tuple)
        return self.current_position

    def create_structure(self):
        self.menu_height = 0
        self.font = pygame.font.Font(self.font_path, self.font_size)
        for i in xrange(self.count_pol):
            self.pos.append(self.rectang())
            self.pos[i].tekst = self.list[i]
            self.pos[i].pole = self.font.render(self.pos[i].tekst, 1, self.color_text)

            self.pos[i].pole_rect = self.pos[i].pole.get_rect()
            shift = int(self.font_size * 0.2)

            height = self.pos[i].pole_rect.height
            self.pos[i].pole_rect.left = shift
            self.pos[i].pole_rect.top = shift + (shift * 2 + height) * i

            width = self.pos[i].pole_rect.width + shift * 2
            height = self.pos[i].pole_rect.height + shift * 2
            left = self.pos[i].pole_rect.left - shift
            top = self.pos[i].pole_rect.top - shift

            self.pos[i].zaznaczenie_rect = (left, top , width, height)
            if width > self.menu_width:
                    self.menu_width = width
            self.menu_height += height
        x = self.dest_surface.get_rect().centerx - self.menu_width / 2
        y = self.dest_surface.get_rect().centery - self.menu_height / 2
        mx, my = self.position_tuple
        self.position_tuple = (x + mx, y + my)


if __name__ == "__main__":

    import sys
    pygame.init()
    surface = pygame.display.set_mode((800, 640))
    pygame.display.set_caption("[DEEP DECENT]")  # Пишем в шапку
    icon = pygame.image.load("icon.png")
    pygame.display.set_icon(icon)
    surface.fill((0, 0, 0))
    menu = Menu()
    menu.set_font_size(64)
    menu.init(['NEW GAME', 'LOAD', 'SETTINGS', 'EXIT'], surface)
    # menu.draw()

    pygame.key.set_repeat(199, 69)
    pygame.display.update()

    font = pygame.font.Font('data/coders_crux/coders_crux (5).ttf', 65)
    # выводим надпись
    text = font.render(("DEEPDECENT"), 1, (117, 47, 13))
    surface.blit(text, (170, 25))
    pygame.display.update()
    pygame.time.wait(150)
    # выводим надпись
    text = font.render(("DEEPDECENT"), 1, (190, 3, 10))
    surface.blit(text, (170, 40))
    pygame.display.update()
    pygame.time.wait(150)
    # выводим надпись
    text = font.render(("DEEPDECENT"), 1, (230, 134, 11))
    surface.blit(text, (170, 55))
    pygame.display.update()
    pygame.time.wait(150)
    # выводим надпись
    text = font.render(("DEEPDECENT"), 1, (252, 214, 27))
    surface.blit(text, (170, 70))
    pygame.display.update()
    pygame.time.wait(400)
    menu.draw()
    pygame.display.update()

    while 1:
        for event in pygame.event.get():
            if event.type == KEYDOWN:
                if event.key == K_UP:
                    menu.draw(-1)
                if event.key == K_DOWN:
                    menu.draw(1)
                if event.key == K_RETURN:

                    if menu.get_position() == 2:
                        main.main("test")
                    if menu.get_position() == 1:
                        main.main("load")
                    if menu.get_position() == 0:
                        main.main("generate")
                    if menu.get_position() == 3:
                        pygame.display.quit()
                        sys.exit()
                if event.key == K_ESCAPE:
                    pygame.display.quit()
                    sys.exit()
                pygame.display.update()
            elif event.type == QUIT:
                pygame.display.quit()
                sys.exit()
        pygame.time.wait(8)
