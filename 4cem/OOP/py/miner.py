#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *
import os
import pyganim
import  block

MOVE_SPEED = 3
WIDTH = 25
HEIGHT = 25
COLOR = "#cc0000"
BLACK = "#000000"
JUMP_POWER = 1
move_speed = 7
dig_speed = 3
full_tank = 1000
miner_color = "#888888"
ICON_DIR = os.path.dirname(__file__)
ANIMATION_DELAY = 0.1 # скорость смены кадров
GRAVITY = 0.55
ANIMATION_UP = [('%s/fly/miner_stay_flyl.png' % ICON_DIR),
                ('%s/fly/miner_stay_fly.png' % ICON_DIR)]
ANIMATION_UP_RIGHT = [('%s/fly/miner_ru.png' % ICON_DIR),
                     ('%s/fly/miner_rul.png' % ICON_DIR)]
ANIMATION_UP_LEFT = [('%s/fly/miner_lu.png' % ICON_DIR),
                      ('%s/fly/miner_lul.png' % ICON_DIR)]


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.vertical_speed = 0  # скорость вертикального перемещения
        self.onGround = False    # На земле ли я?
        self.horizontal_speed = 0
        self.start_x = x
        self.start_y = y
        self.fuel = full_tank
        self.image = Surface((WIDTH, HEIGHT))
        self.rect = Rect(x, y, WIDTH, HEIGHT)
        self.digging = False

        boltAnim = []
        for anim in ANIMATION_UP:
            boltAnim.append((anim, ANIMATION_DELAY))
        self.boltAnimUp = pyganim.PygAnimation(boltAnim)
        self.boltAnimUp.play()
        boltAnim = []
        for anim in ANIMATION_UP_LEFT:
            boltAnim.append((anim, ANIMATION_DELAY))
        self.boltAnimUpLeft = pyganim.PygAnimation(boltAnim)
        self.boltAnimUpLeft.play()
        boltAnim = []
        for anim in ANIMATION_UP_RIGHT:
            boltAnim.append((anim, ANIMATION_DELAY))
        self.boltAnimUpRight = pyganim.PygAnimation(boltAnim)
        self.boltAnimUpRight.play()

    def update(self, left, right, up, down, platforms):
        nullImage = image.load("null.png")
        if up:
            if self.vertical_speed > -10:
                self.vertical_speed += -JUMP_POWER
            print 'speed =', self.vertical_speed
            self.image = nullImage
            # self.image.fill(Color(BLACK))# делаем фон прозрачным
            self.boltAnimUp.blit(self.image, (0, 0))
            # self.boltAnimJump.blit(self.image, (0, 0))

        if left:

            self.horizontal_speed = -MOVE_SPEED # Лево = x- n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_l.png")

            if up: # для прыжка влево есть отдельная анимация
                # self.image = nullImage
                self.boltAnimUpLeft.blit(self.image, (0, 0))


        if right:
            self.horizontal_speed = MOVE_SPEED # Право = x + n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_r.png")
            if up: # для прыжка влево есть отдельная анимация
                # self.image = nullImage
                self.boltAnimUpRight.blit(self.image, (0, 0))
        if down:
            self.vertical_speed = dig_speed
            self.digging = True
            print "hero doing down"
        if not(left or right or up): # стоим, когда нет указаний идти
            self.horizontal_speed = 0
            self.image = image.load("miner_stay.png")
            # if not up:
            #     self.image.fill(Color(COLOR))
        if not self.onGround:
            self.vertical_speed += GRAVITY

        self.onGround = False # Мы не знаем, когда мы на земле((
        self.rect.y += self.vertical_speed
        self.collide(0, self.vertical_speed, platforms)

        self.rect.x += self.horizontal_speed # переносим свои положение на xvel
        self.collide(self.horizontal_speed, 0, platforms)

    def collide(self, horizontal_speed, vertical_speed, platforms):
        for p in platforms:
            if sprite.collide_rect(self, p): # если есть пересечение платформы с игроком
                if horizontal_speed > 0:                      # если движется вправо
                    self.rect.right = p.rect.left # то не движется вправо
                if horizontal_speed < 0:                      # если движется влево
                    self.rect.left = p.rect.right # то не движется влево
                if vertical_speed > 0:
                    if isinstance(p, block.ValueBlock):
                        self.fuel = full_tank
                    if self.digging:
                        self.digging = False
                        print "digging"
                    else:
                        self.rect.bottom = p.rect.top # то не падает вниз
                        self.onGround = True          # и становится на что-то твердое
                        self.vertical_speed = 0                 # и энергия падения пропадает
                if vertical_speed < 0:                      # если движется вверх
                    self.rect.top = p.rect.bottom # то не движется вверх
                    self.vertical_speed = 0                 # и энергия прыжка пропадает

    def alive(self):
        self.rect.x = self.start_x
        self.rect.y = self.start_y