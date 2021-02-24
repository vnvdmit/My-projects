#ifndef SPRITES_H
#define SPRITES_H

#include "game.h"

#define SHIP_W 12
#define SHIP_H  13

#define SHIP_SHOT_W 2
#define SHIP_SHOT_H 9

#define LIFE_W 6
#define LIFE_H  6

#define ALIEN_BUG_W         14
#define ALIEN_BUG_H            9
#define ALIEN_ARROW_W    13
#define ALIEN_ARROW_H     10
#define ALIEN_THICCBOI_W 45
#define ALIEN_THICCBOI_H  27

#define ALIEN_SHOT_W 4
#define ALIEN_SHOT_H  4

#define EXPLOSION_FRAMES 4
#define SPARKS_FRAMES       3

typedef struct SPRITES
{
    ALLEGRO_BITMAP* _sheet;

    ALLEGRO_BITMAP* ship;
    ALLEGRO_BITMAP* ship_shot[2];
    ALLEGRO_BITMAP* life;

    ALLEGRO_BITMAP* alien[3];
    ALLEGRO_BITMAP* alien_shot;

    ALLEGRO_BITMAP* explosion[EXPLOSION_FRAMES];
    ALLEGRO_BITMAP* sparks[SPARKS_FRAMES];

    ALLEGRO_BITMAP* powerup[4];
} SPRITES;

extern SPRITES sprites;

enum {
		BUG_SHIP,
		ARROW_SHIP,
		THICCBOI_SHIP,
		TOTAL_SHIPS
	};

extern const int ALIEN_W[TOTAL_SHIPS];									  
extern const int ALIEN_H[TOTAL_SHIPS];

ALLEGRO_BITMAP* sprite_grab(int x, int y, int w, int h);
void sprites_init();
void sprites_deinit();

#endif