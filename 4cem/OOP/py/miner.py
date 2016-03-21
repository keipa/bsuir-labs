#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *
import os
import pyganim

MOVE_SPEED = 3
WIDTH = 25
HEIGHT = 25
COLOR = "#cc0000"
BLACK = "#000000"
JUMP_POWER = 1
move_speed = 7

miner_color = "#888888"
ICON_DIR = os.path.dirname(__file__)
ANIMATION_DELAY = 0.1 # скорость смены кадров

GRAVITY = 0.55
ANIMATION_UP = [('%s/fly/miner_ru.png' % ICON_DIR),
                ('%s/fly/miner_rul.png' % ICON_DIR)]

class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.yvel = 0  # скорость вертикального перемещения
        self.onGround = False    # На земле ли я?
        self.xvel = 0
        self.start_x = x
        self.start_y = y
        self.image = Surface((WIDTH, HEIGHT))
        # self.image.fill(Color(miner_color))
        self.rect = Rect(x, y, WIDTH, HEIGHT)
        boltAnim = []
        for anim in ANIMATION_UP:
            boltAnim.append((anim, ANIMATION_DELAY))
        self.boltAnimUp = pyganim.PygAnimation(boltAnim)
        self.boltAnimUp.play()
#
    def update(self, left, right, up, platforms):

        if up:
            if self.yvel > -10:
                self.yvel += -JUMP_POWER
            print 'speed =', self.yvel
            self.image.fill(Color(BLACK))# делаем фон прозрачным
            self.boltAnimUp.blit(self.image, (0, 0))



            # self.boltAnimJump.blit(self.image, (0, 0))


        if left:
            self.xvel = -MOVE_SPEED # Лево = x- n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_l.png")
            # if up: # для прыжка влево есть отдельная анимация
            #     self.boltAnimJumpLeft.blit(self.image, (0, 0))
            # else:
            #     self.boltAnimLeft.blit(self.image, (0, 0))

        if right:
            self.xvel = MOVE_SPEED # Право = x + n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_r.png")
        if not(left or right): # стоим, когда нет указаний идти
            self.xvel = 0
            # if not up:
            #     self.image.fill(Color(COLOR))
        if not self.onGround:
            self.yvel += GRAVITY

        self.onGround = False # Мы не знаем, когда мы на земле((
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
