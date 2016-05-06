#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *
import os
import pyganim
import block
import main
import upgrade_menu

MOVE_SPEED = 3
WIDTH = 25
HEIGHT = 25
COLOR = "#cc0000"
BLACK = "#000000"
JUMP_POWER = 1
move_speed = 7
dig_speed = 3
miner_color = "#888888"
ICON_DIR = os.path.dirname(__file__)
ANIMATION_DELAY = 0.1
GRAVITY = 0.55
ANIMATION_UP = [('%s/fly/miner_stay_flyl.png' % ICON_DIR), ('%s/fly/miner_stay_fly.png' % ICON_DIR)]
ANIMATION_UP_RIGHT = [('%s/fly/miner_rus.png' % ICON_DIR), ('%s/fly/miner_ruls.png' % ICON_DIR)]
ANIMATION_UP_LEFT = [('%s/fly/miner_lus.png' % ICON_DIR), ('%s/fly/miner_luls.png' % ICON_DIR)]
ANIMATION_FLY_RIGHT = [('%s/fly/miner_ru.png' % ICON_DIR), ('%s/fly/miner_ru.png' % ICON_DIR)]
ANIMATION_FLY_LEFT = [('%s/fly/miner_lu.png' % ICON_DIR), ('%s/fly/miner_lu.png' % ICON_DIR)]
ANIMATION_STAY = [('%s/miner_stay.png' % ICON_DIR),
                  ('%s/miner_stay_u.png' % ICON_DIR),
                  ('%s/miner_stay_c.png' % ICON_DIR),
                  ('%s/miner_stay_d.png' % ICON_DIR)]


class Miner(sprite.Sprite):
    def __init__(self, x, y):
        sprite.Sprite.__init__(self)
        self.vertical_speed = 0
        self.onGround = False
        self.horizontal_speed = 0
        self.start_x = x
        self.start_y = y
        self.image = Surface((WIDTH, HEIGHT))
        self.rect = Rect(x, y, WIDTH, HEIGHT)
        self.digging_vertical = False
        self.digging_horizontal = False
        self.cash = 0
        self.null_image = image.load("null.png")
        # characteristics
        self.critical_temperature = 70
        self.cooling_index = 1
        self.current_temperature = 25
        self.max_fuel = 1000
        self.current_fuel = self.max_fuel
        self.max_capacity = 10
        self.current_capacity = 0
        self.max_health = 100
        self.health = self.max_health
        self.overheat = 300
        self.teleports = 1
        self.gasoline_tank = 1
        self.isinfected = False

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
        temp_animation = []
        for frame in ANIMATION_STAY:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimStay = pyganim.PygAnimation(temp_animation)
        self.boltAnimStay.play()
        temp_animation = []
        for frame in ANIMATION_FLY_LEFT:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimFlyLeft = pyganim.PygAnimation(temp_animation)
        self.boltAnimFlyLeft.play()
        temp_animation = []
        for frame in ANIMATION_FLY_RIGHT:
            temp_animation.append((frame, ANIMATION_DELAY))
        self.boltAnimFlyRight = pyganim.PygAnimation(temp_animation)
        self.boltAnimFlyRight.play()

    def can_i_digg(self):
        if self.current_capacity >= self.max_capacity:
            return False
        else:
            return True

    def update(self, left, right, up, down, platforms):
        nullimage = image.load("null.png")
        if up:
            if self.vertical_speed > -10:
                self.vertical_speed += -JUMP_POWER
            self.image = nullimage
            self.boltAnimUp.blit(self.image, (0, 0))
            self.digging_vertical = False
            self.digging_horizontal = False

        if left:

            self.horizontal_speed = -MOVE_SPEED
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_l.png")
            if self.onGround and not up:
                self.boltAnimFlyLeft.blit(self.image, (0, 0))
            if self.can_i_digg():
                self.digging_horizontal = True
            if up:
                self.boltAnimUpLeft.blit(self.image, (0, 0))
                self.digging_horizontal = False

        if right:
            self.horizontal_speed = MOVE_SPEED
            self.image.fill(Color(COLOR))
            self.image = image.load("miner_r.png")
            if self.onGround and not up:
                self.boltAnimFlyRight.blit(self.image, (0, 0))
            if self.can_i_digg():
                self.digging_horizontal = True

            if up:
                self.boltAnimUpRight.blit(self.image, (0, 0))
                self.digging_horizontal = False

        if down:
            if self.onGround:
                self.vertical_speed = dig_speed
                if self.can_i_digg():
                    self.digging_vertical = True

        if not(left or right or up):
            self.horizontal_speed = 0
            self.image = nullimage
            self.boltAnimStay.blit(self.image, (0, 0))
            # self.image = image.load("miner_stay.png")
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
                if vertical_speed > 0:
                    if not isinstance(p, block.NullBlock):
                        if isinstance(p, block.FuelTriggerBlock):
                            if self.isinfected:
                                main.when_you_win_the_game()
                                self.isinfected = False
                            # percentage_lost_fuel = self.current_fuel/self.max_fuel
                            # percentage_lost_health = self.health/100
                            if self.current_fuel/self.max_fuel <= 0.99 or self.health/self.max_fuel <= 0.99:
                                # self.current_fuel = self.max_fuel
                                if self.current_fuel < self.max_fuel:
                                    self.current_fuel += 30
				    if self.current_fuel>self.max_fuel:
					self.current_fuel = self.max_fuel
                                if self.current_capacity > 0:
                                    self.current_capacity -= 1
                                # self.current_capacity = 0
                                if self.health < self.max_health:
                                    self.health += 1

                                # self.cash -= round(percentage_lost_fuel*200)
                        if isinstance(p, block.UpdateTriggerBlock):
                            data = upgrade_menu.main(self.cash)
                            self.cash = data[0]
                            if data[1] == "f":
                                self.max_fuel *= 2
                            if data[1] == "a":
                                self.max_health *= 2
                            if data[1] == "g":
                                self.max_capacity *= 2
                            if data[1] == "c":
                                self.cooling_index += 1
                            if data[1] == "g":
                                self.gasoline_tank += 1
                            if data[1] == "t":
                                self.teleports += 1
                            self.alive()
                            # self.cash -= round(percentage_lost_health*1000)
                            # print p.
                        if self.digging_vertical and \
                                not isinstance(p, block.Border) and \
                                not isinstance(p, block.FuelTriggerBlock) and \
                                not isinstance(p, block.GasolineStationBlock) and \
                                not isinstance(p, block.UpgradeStationBlock) and\
                                not isinstance(p, block.UpdateTriggerBlock):
                            self.digging_vertical = False
                            self.cash += p.value
                            if not isinstance(p, block.Platform):
                                self.current_capacity += 1
                            if isinstance(p, block.VirusBlock):
                                self.isinfected = True
                                print "I infected"
                                self.current_capacity = self.max_capacity
                                main.when_took_a_virus()

                            main.delete_level_particles(p)
                        else:
                            self.rect.bottom = p.rect.top
                            self.onGround = True
                            self.vertical_speed = 0
                if vertical_speed < 0:
                    if not isinstance(p, block.NullBlock):
                        self.rect.top = p.rect.bottom
                        self.vertical_speed = 0
                if horizontal_speed > 0:
                    if not isinstance(p, block.NullBlock):
                        self.rect.right = p.rect.left
                        if self.digging_horizontal and\
                                not isinstance(p, block.Border) and\
                                not isinstance(p, block.FuelTriggerBlock) and\
                                not isinstance(p, block.GasolineStationBlock) and \
                                not isinstance(p, block.UpgradeStationBlock) and\
                                not isinstance(p, block.UpdateTriggerBlock):
                            self.digging_horizontal = False
                            self.cash += p.value
                            if not isinstance(p, block.Platform):
                                self.current_capacity += 1
                            if isinstance(p, block.VirusBlock):
                                self.isinfected = True
                                print "I infected"
                                self.current_capacity = self.max_capacity
                                main.when_took_a_virus()

                            main.delete_level_particles(p)
                if horizontal_speed < 0:
                    if not isinstance(p, block.NullBlock):
                        self.rect.left = p.rect.right
                        if self.digging_horizontal and \
                                not isinstance(p, block.Border) and \
                                not isinstance(p, block.FuelTriggerBlock) and \
                                not isinstance(p, block.GasolineStationBlock) and \
                                not isinstance(p, block.UpgradeStationBlock) and\
                                not isinstance(p, block.UpdateTriggerBlock):
                            self.digging_horizontal = False
                            self.cash += p.value
                            if not isinstance(p, block.Platform):
                                self.current_capacity += 1
                            if isinstance(p, block.VirusBlock):
                                self.isinfected = True
                                print "I infected"
                                self.current_capacity = self.max_capacity
                                main.when_took_a_virus()
                            main.delete_level_particles(p)

                # if isinstance(p, block.NullBlock):
                #     break

    def alive(self):
        self.rect.x = self.start_x
        self.rect.y = self.start_y+20
        self.horizontal_speed = 0
