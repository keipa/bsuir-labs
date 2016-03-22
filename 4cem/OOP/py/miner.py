#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *
import os
import pyganim
import block

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
ANIMATION_DELAY = 0.1
GRAVITY = 0.55
ANIMATION_UP = [('%s/fly/miner_stay_flyl.png' % ICON_DIR), ('%s/fly/miner_stay_fly.png' % ICON_DIR)]
ANIMATION_UP_RIGHT = [('%s/fly/miner_ru.png' % ICON_DIR), ('%s/fly/miner_rul.png' % ICON_DIR)]
ANIMATION_UP_LEFT = [('%s/fly/miner_lu.png' % ICON_DIR), ('%s/fly/miner_lul.png' % ICON_DIR)]


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.vertical_speed = 0
        self.onGround = False
        self.horizontal_speed = 0
        self.start_x = x
        self.start_y = y
        self.fuel = full_tank
        self.image = Surface((WIDTH, HEIGHT))
        self.rect = Rect(x, y, WIDTH, HEIGHT)
        self.digging = False

        temp_animation = []
        for frame in ANIMATION_UP:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimUp = pyganim.PygAnimation(temp_animation)
        self.boltAnimUp.play()
        temp_animation = []
        for frame in ANIMATION_UP_LEFT:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimUpLeft = pyganim.PygAnimation(temp_animation)
        self.boltAnimUpLeft.play()
        temp_animation = []
        for frame in ANIMATION_UP_RIGHT:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimUpRight = pyganim.PygAnimation(temp_animation)
        self.boltAnimUpRight.play()

    def update(self, left, right, up, down, platforms):
        nullImage = image.load("null.png")
        print "----------",self.rect.x, self.rect.y
        if up:
            if self.vertical_speed > -10:
                self.vertical_speed += -JUMP_POWER
            self.image = nullImage
            # self.image.fill(Color(BLACK))# делаем фон прозрачным
            self.boltAnimUp.blit(self.image, (0, 0))
            # self.boltAnimJump.blit(self.image, (0, 0))

        if left:

            self.horizontal_speed = -MOVE_SPEED # Лево = x- n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_l.png")

            if up:
                self.boltAnimUpLeft.blit(self.image, (0, 0))

        if right:
            self.horizontal_speed = MOVE_SPEED # Право = x + n
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_r.png")
            if up:
                self.boltAnimUpRight.blit(self.image, (0, 0))
        if down:
            self.vertical_speed = dig_speed
            self.digging = True

            # platforms[]
        if not(left or right or up): # стоим, когда нет указаний идти
            self.horizontal_speed = 0
            self.image = image.load("miner_stay.png")
            # if not up:
            #     self.image.fill(Color(COLOR))
        if not self.onGround:
            self.vertical_speed += GRAVITY

        self.onGround = False
        self.rect.y += self.vertical_speed
        self.collide(0, self.vertical_speed, platforms)

        self.rect.x += self.horizontal_speed
        self.collide(self.horizontal_speed, 0, platforms)

    def collide(self, horizontal_speed, vertical_speed, platforms):
        for p in platforms:
            if sprite.collide_rect(self, p):
                if horizontal_speed > 0:
                    self.rect.right = p.rect.left
                if horizontal_speed < 0:
                    self.rect.left = p.rect.right
                if vertical_speed > 0:
                    if isinstance(p, block.ValueBlock):
                        self.fuel = full_tank
                    if self.digging:
                        self.digging = False
                        print "digging"
                    else:
                        self.rect.bottom = p.rect.top
                        self.onGround = True
                        self.vertical_speed = 0
                if vertical_speed < 0:
                    self.rect.top = p.rect.bottom
                    self.vertical_speed = 0

    def alive(self):
        self.rect.x = self.start_x
        self.rect.y = self.start_y
