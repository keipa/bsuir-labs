#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *


MOVE_SPEED = 3
WIDTH = 32
HEIGHT = 32
COLOR = "#888888"
JUMP_POWER = 1
move_speed = 7
width = 32
height = 32
miner_color = "#888888"

GRAVITY = 0.55


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.yvel = 0  # скорость вертикального перемещения
        self.onGround = False    # На земле ли я?
        self.xvel = 0
        self.start_x = x
        self.start_y = y
        self.image = Surface((width, height))
        self.image.fill(Color(miner_color))
        self.rect = Rect(x, y, width, height)

    def update(self, left, right, up, platforms):

        if up:
            if self.yvel > -10: # прыгаем, только когда можем оттолкнуться от земли
                self.yvel += -JUMP_POWER
            print self.yvel
            self.image.fill(Color(COLOR))
            # self.boltAnimJump.blit(self.image, (0, 0))


        if left:
            self.xvel = -MOVE_SPEED # Лево = x- n
            self.image.fill(Color(COLOR))
            # if up: # для прыжка влево есть отдельная анимация
            #     self.boltAnimJumpLeft.blit(self.image, (0, 0))
            # else:
            #     self.boltAnimLeft.blit(self.image, (0, 0))

        if right:
            self.xvel = MOVE_SPEED # Право = x + n
            self.image.fill(Color(COLOR))
        if not(left or right): # стоим, когда нет указаний идти
            self.xvel = 0
            if not up:
                self.image.fill(Color(COLOR))
        if not self.onGround:
            self.yvel +=  GRAVITY

        self.onGround = False; # Мы не знаем, когда мы на земле((
        self.rect.y += self.yvel
        self.collide(0, self.yvel, platforms)

        self.rect.x += self.xvel # переносим свои положение на xvel
        self.collide(self.xvel, 0, platforms)

    def collide(self, xvel, yvel, platforms):
        for p in platforms:
            if sprite.collide_rect(self, p): # если есть пересечение платформы с игроком

                if xvel > 0:                      # если движется вправо
                    self.rect.right = p.rect.left # то не движется вправо

                if xvel < 0:                      # если движется влево
                    self.rect.left = p.rect.right # то не движется влево

                if yvel > 0:                      # если падает вниз
                    self.rect.bottom = p.rect.top # то не падает вниз
                    self.onGround = True          # и становится на что-то твердое
                    self.yvel = 0                 # и энергия падения пропадает

                if yvel < 0:                      # если движется вверх
                    self.rect.top = p.rect.bottom # то не движется вверх
                    self.yvel = 0                 # и энергия прыжка пропадает

