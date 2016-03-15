#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *

move_speed = 7
width = 22
height = 32
miner_color = "#888888"


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.current_speed = 0
        self.start_x = x
        self.start_y = y
        self.image = Surface((width, height))
        self.image.fill(Color(miner_color))
        self.rect = Rect(x, y, width, height)

    def update(self,  left, right):
        if left:
            self.current_speed = -move_speed

        if right:
            self.current_speed = move_speed

        if not(left or right):
            self.current_speed = 0

        self.rect.x += self.current_speed

    def draw(self, screen):
        screen.blit(self.image, (self.rect.x, self.rect.y))
