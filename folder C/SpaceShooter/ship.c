#include "game.h"
#include "display.h"
#include "shot.h"
#include "keyboard.h"
#include "fx.h"
#include "ship.h"

SHIP ship;

void ship_init()
{
    ship.x = (BUFFER_W / 2) - (SHIP_W / 2);
    ship.y = (BUFFER_H / 2) - (SHIP_H / 2);
    ship.shot_timer = 0;
    ship.lives = INITIAL_SHIP_LIVES;
    ship.respawn_timer = 0;
    ship.invincible_timer = 120;
}

void ship_update()
{
	if( running == state ){
		if(ship.lives < 0)
			return;

		if(ship.respawn_timer){
			ship.respawn_timer--;
			return;
		}

		if(key[ALLEGRO_KEY_LEFT])
			ship.x -= SHIP_SPEED;
		if(key[ALLEGRO_KEY_RIGHT])
			ship.x += SHIP_SPEED;
		if(key[ALLEGRO_KEY_UP])
			ship.y -= SHIP_SPEED;
		if(key[ALLEGRO_KEY_DOWN])
			ship.y += SHIP_SPEED;

		if(ship.x < 0)
			ship.x = 0;
		if(ship.y < 0)
			ship.y = 0;

		if(ship.x > SHIP_MAX_X)
			ship.x = SHIP_MAX_X;
		if(ship.y > SHIP_MAX_Y)
			ship.y = SHIP_MAX_Y;

		if(ship.invincible_timer)
			ship.invincible_timer--;
		else{
			if(shots_collide(true, ship.x, ship.y, SHIP_W, SHIP_H)){
				int x = ship.x + (SHIP_W / 2);
				int y = ship.y + (SHIP_H / 2);
				fx_add(false, x, y);
				fx_add(false, x+4, y+2);
				fx_add(false, x-2, y-4);
				fx_add(false, x+1, y-5);

				ship.lives--;
				ship.respawn_timer   = SHIP_RESPAWN_TIMER;
				ship.invincible_timer = SHIP_INVINCIBLE_TIMER;
			}
		}

		if(ship.shot_timer)
			ship.shot_timer--;
		else if(key[ALLEGRO_KEY_SPACE]){
		int x = ship.x + (SHIP_W / 2);
		if(shots_add(true, false, x, ship.y))
			ship.shot_timer = SHIP_SHOT_TIMER;
		}
	}
}

void ship_draw(){
	if( running == state ){
		if(ship.lives < 0)
			return;
		if(ship.respawn_timer)
			return;
		if(((ship.invincible_timer / 2) % 3) == 1)
			return;
		al_draw_bitmap(sprites.ship, ship.x, ship.y, NO_FLAGS);
	}
}