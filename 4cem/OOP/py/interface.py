#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pygame import *
import pygame


def update(screen,
           deep,
           speed,
           capacity,
           max_capacity,
           health,
           max_healt,
           temperature,
           fuel,
           max_fuel,
           cash,
           teleport,
           gasoline_tank):
    font_32 = pygame.font.Font('data\coders_crux\DS-DIGIB.ttf', 32)
    font_60 = pygame.font.Font('data\coders_crux\DS-DIGIB.ttf', 60)
    font_45 = pygame.font.Font('data\coders_crux\DS-DIGIB.ttf', 45)
    deep_text = font_32.render(str(deep)+"m", 1, (255, 0, 0))
    if abs(speed) < 2:
        speed = 0
    speed_text = font_60.render(str(int(abs(round(speed)*2)))+"km/h", 1, (250, 250, 0))
    capacity_text = font_45.render(str(capacity)+"/"+str(max_capacity), 1, (250, 250, 0))
    health_text = font_32.render(str(int(100*health/max_healt))+"%", 1, (250, 250, 0))
    temperature_text = font_32.render(str(temperature)+"`C", 1, (250, 0, 0))
    fuel_text = font_45.render(str(int(round(100*fuel/max_fuel)))+"%", 1, (250, 250, 0))
    cash_text = font_32.render(str(cash)+"$", 1, (250, 250, 0))
    gasoline_tank_text = font_32.render(str(gasoline_tank), 1, (250, 250, 0))
    teleport_text = font_32.render(str(teleport), 1, (250, 250, 0))

    hud_image = image.load("interface.png")

    screen.blit(hud_image, (0, 0))
    screen.blit(deep_text, (62, 56))
    screen.blit(speed_text, (90, 550))
    screen.blit(capacity_text, (350, 577))
    screen.blit(cash_text, (300, 540))
    screen.blit(gasoline_tank_text, (768, 152))
    screen.blit(teleport_text, (18, 152))
    screen.blit(health_text, (615, 583))
    screen.blit(temperature_text, (670, 56))
    screen.blit(fuel_text, (600, 535))
