#ifndef SHIPM_H
#define SHIPM_H

#include "sprites.h"

#define SHIP_SPEED 3
#define INITIAL_SHIP_LIVES 3

#define SHIP_RESPAWN_TIMER 90
#define SHIP_INVINCIBLE_TIMER 180

#define SHIP_SHOT_TIMER 5

#define SHIP_MAX_X (BUFFER_W - SHIP_W)
#define SHIP_MAX_Y (BUFFER_H - SHIP_H)

typedef struct SHIP
{
    int x, y;
    int shot_timer;
    int lives;
    int respawn_timer;
    int invincible_timer;
} SHIP;

extern SHIP ship;

void ship_init();
void ship_update();
void ship_draw();

#endif