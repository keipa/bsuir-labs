#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *

move_speed = 7
width = 22
height = 32
miner_color = "#888888"
JUMP_POWER = 10
GRAVITY = 0.35


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.vertical_speed = 0 # скорость вертикального перемещения
        self.onGround = False # На земле ли я?
        self.current_speed = 0
        self.start_x = x
        self.start_y = y
        self.image = Surface((width, height))
        self.image.fill(Color(miner_color))
        self.rect = Rect(x, y, width, height)

    def update(self,  left, right, up):
        if up:
            if self.onGround:  # прыгаем, только когда можем оттолкнуться от земли
                self.vertical_speed = -JUMP_POWER
            if not self.onGround:
                self.vertical_speed += GRAVITY
            self.onGround = False  # Мы не знаем, когда мы на земле((
            self.rect.y += self.vertical_speed
        if left:
            self.current_speed = -move_speed
        if right:
            self.current_speed = move_speed
        if not(left or right):
            self.current_speed = 0
        self.rect.x += self.current_speed

    def draw(self, screen):
        screen.blit(self.image, (self.rect.x, self.rect.y))
