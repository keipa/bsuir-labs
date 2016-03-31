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
    ilosc_pol = 0
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
        self.ilosc_pol = len(self.list)
        self.stworz_strukture()
        
    def draw(self, przesun=0):
        if przesun:
            self.current_position += przesun
            if self.current_position == -1:
                self.current_position = self.ilosc_pol - 1
            self.current_position %= self.ilosc_pol
        menu = pygame.Surface((self.menu_width, self.menu_height))
        menu.fill(self.color_background)
        selected_rect= self.pos[self.current_position].zaznaczenie_rect
        pygame.draw.rect(menu, self.color_back_of_text, selected_rect)

        for i in xrange(self.ilosc_pol):
            menu.blit(self.pos[i].pole, self.pos[i].pole_rect)
        self.dest_surface.blit(menu, self.position_tuple)
        return self.current_position

    def stworz_strukture(self):
        self.menu_height = 0
        self.font = pygame.font.Font(self.font_path, self.font_size)
        for i in xrange(self.ilosc_pol):
            self.pos.append(self.rectang())
            self.pos[i].tekst = self.list[i]
            self.pos[i].pole = self.font.render(self.pos[i].tekst, 1, self.color_text)

            self.pos[i].pole_rect = self.pos[i].pole.get_rect()
            przesuniecie = int(self.font_size * 0.2)

            height = self.pos[i].pole_rect.height
            self.pos[i].pole_rect.left = przesuniecie
            self.pos[i].pole_rect.top = przesuniecie + (przesuniecie * 2 + height) * i

            width = self.pos[i].pole_rect.width + przesuniecie * 2
            height = self.pos[i].pole_rect.height + przesuniecie * 2
            left = self.pos[i].pole_rect.left - przesuniecie
            top = self.pos[i].pole_rect.top - przesuniecie

            self.pos[i].zaznaczenie_rect = (left, top, width, height)
            if width > self.menu_width:
                    self.menu_width = width
            self.menu_height += height
        x = self.dest_surface.get_rect().centerx - self.menu_width / 2
        y = self.dest_surface.get_rect().centery - self.menu_height / 2
        mx, my = self.position_tuple
        self.position_tuple = (x + mx, y + my)


def main(cash):
    import sys
    pygame.init()
    surface = pygame.display.set_mode((800, 640))
    pygame.display.set_caption("[DEEP DECENT]")  # Пишем в шапку
    icon = pygame.image.load("icon.png")
    pygame.display.set_icon(icon)
    surface.fill((0, 0, 0))
    my_menu = Menu()
    my_menu.set_font_size(64)
    my_menu.init(['FUEL ' +str(int(cash*0.75))+"$",
                  'COOLING SYSTEM ' +str(int(cash*0.75))+"$",
                  'ARMOR ' +str(int(cash*0.75))+"$",
                  'CAPACITY ' +str(int(cash*0.75))+"$",
                  'return'], surface)
    # menu.draw()
    font = pygame.font.Font('data/coders_crux/coders_crux (5).ttf', 65)
    pygame.key.set_repeat(199, 69)
    pygame.display.update()
    text = font.render("STORE", 1, (190, 3, 10))
    surface.blit(text, (280, 40))
    pygame.display.update()
    pygame.time.wait(150)
    font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 65)
    pygame.display.update()
    text = font.render("cash: " + str(cash)+"$", 1, (250, 250, 0))
    surface.blit(text, (280, 500))
    my_menu.draw()
    pygame.display.update()

    while 1:
        for event in pygame.event.get():
            if event.type == KEYDOWN:
                if event.key == K_UP:
                    my_menu.draw(-1)
                if event.key == K_DOWN:
                    my_menu.draw(1)
                if event.key == K_RETURN:
                    if my_menu.get_position() == 0:
                        return int(cash*0.25), "f"
                    if my_menu.get_position() == 1:
                        return int(cash*0.25), "c"
                    if my_menu.get_position() == 2:
                        return int(cash*0.25), "a"
                    if my_menu.get_position() == 3:
                        return int(cash*0.25), "g"
                    if my_menu.get_position() == 4:
                        return cash, "n"

                if event.key == K_ESCAPE:
                    pygame.display.quit()
                    sys.exit()
                font = pygame.font.Font('data/coders_crux/coders_crux.ttf', 65)
                pygame.display.update()
                text = font.render("cash: " + str(cash)+"$", 1, (250, 250, 0))
                surface.blit(text, (280, 500))
                pygame.display.update()
            elif event.type == QUIT:
                pygame.display.quit()
                sys.exit()
        pygame.time.wait(8)
