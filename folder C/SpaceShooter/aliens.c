#include <stdio.h>

#include "game.h"
#include "display.h"
#include "sprites.h"
#include "shot.h"
#include "fx.h"
#include "aliens.h"

ALIEN *aliens = NULL;

static const char* errorMsg = "Something strange !";

static void set_shot_timer( ALIEN* alien ,int cx ,int cy );
static void set_alien_life( ALIEN* alien );
static void set_alien_move( ALIEN* alien );
static void set_alien_score( ALIEN* alien ,int cx ,int cy);

void aliens_init()
{
	aliens = ( ALIEN* )malloc( ALIENS_N*sizeof(ALIEN) );
    for(int i = 0; i < ALIENS_N; i++)
        aliens[i].used = false;
}

void aliens_update()
{
	if( running == state || game_over == state ){
		int new_quota =
			(frames % 120)
			? 0
			: between(2, 4);
		int new_x = between(10, BUFFER_W-50);

		for(int i = 0; i < ALIENS_N; i++){
			if(!aliens[i].used){

				if(new_quota > 0){
					new_x += between(40, 80);
					if(new_x > (BUFFER_W - 60))
						new_x -= (BUFFER_W - 60);

					aliens[i].x = new_x;

					aliens[i].y = between(-40, -30);
					aliens[i].type = between(0, ALIEN_TYPE_N);
					aliens[i].shot_timer = between(1, 99);
					aliens[i].blink = 0;
					aliens[i].used = true;
					
					set_alien_life( &aliens[i] );
					
					new_quota--;
				}
				continue;
			}
			
			set_alien_move( &aliens[i] );

			if(aliens[i].y >= BUFFER_H){
				aliens[i].used = false;
				continue;
			}

			if(aliens[i].blink)
				aliens[i].blink--;

			if(shots_collide(false, aliens[i].x, aliens[i].y, ALIEN_W[aliens[i].type], ALIEN_H[aliens[i].type])){
				aliens[i].life--;
				aliens[i].blink = ALIENS_BLINK;
			}

			int cx = aliens[i].x + (ALIEN_W[aliens[i].type] / 2);
			int cy = aliens[i].y + (ALIEN_H[aliens[i].type] / 2);

			if(aliens[i].life <= 0){
				fx_add(false, cx, cy);
				set_alien_score( &aliens[i] ,cx ,cy );
				aliens[i].used = false;
				continue;
			}

			aliens[i].shot_timer--;
			if(aliens[i].shot_timer == 0){
				set_shot_timer( &aliens[i] ,cx ,cy);
			}
		}
	}
}

void aliens_draw()
{
	if( running == state || game_over == state  ){
		for(int i = 0; i < ALIENS_N; i++){
			if(!aliens[i].used)
				continue;
			if(aliens[i].blink % 2)
				continue;

			al_draw_bitmap(sprites.alien[aliens[i].type], aliens[i].x, aliens[i].y, 0);
		}
	}
}

void aliens_deinit(){
	free( aliens );
	aliens = NULL;
}

static void set_shot_timer( ALIEN* alien ,int cx ,int cy ){
	
	int bug;
	int arrow;
	int boi;
	
	if( score < SCORE_LIMIT_ONE ){
		bug    = BUG_TIMER_TIER_ONE ;
		arrow = ARROW_TIMER_TIER_ONE ;
		boi     = THICCBOI_TIMER_TIER_ONE;
	}
	else if( score < SCORE_LIMIT_TWO ){
		bug    = BUG_TIMER_TIER_TWO ;
		arrow = ARROW_TIMER_TIER_TWO;
		boi     = THICCBOI_TIMER_TIER_TWO;
	}
	else{
		bug    = BUG_TIMER_TIER_THREE ;
		arrow = ARROW_TIMER_TIER_THREE;
		boi     = THICCBOI_TIMER_TIER_THREE;
	}
	
	switch( alien->type ){
		case ALIEN_TYPE_BUG:
			shots_add(false, false, cx, cy);
			alien->shot_timer = bug;
			break;
		case ALIEN_TYPE_ARROW:
			shots_add(false, true, cx, alien->y);
			alien->shot_timer = arrow;
			break;
		case ALIEN_TYPE_THICCBOI:
			shots_add(false, true, cx-5, cy);
			shots_add(false, true, cx+5, cy);
			shots_add(false, true, cx-5, cy + 8);
			shots_add(false, true, cx+5, cy + 8);
			alien->shot_timer = boi;
			break;
		default :
			fprintf( stderr ,errorMsg );
			exit(1);
			break;
	}
}

static void set_alien_life( ALIEN* alien ){
	switch(alien->type){
		case ALIEN_TYPE_BUG:
			alien->life = BUG_LIFE;
			break;
		case ALIEN_TYPE_ARROW:
			alien->life = ARROW_LIFE;
			break;
		case ALIEN_TYPE_THICCBOI:
			alien->life = THICCBOI_LIFE;
			break;
		default :
			fprintf( stderr ,errorMsg);
			exit(1);
			break;
	}
}

static void set_alien_move( ALIEN* alien ){
	switch(alien->type){
		case ALIEN_TYPE_BUG:
			if(frames % 2)
				alien->y++;
			break;
		case ALIEN_TYPE_ARROW:
			alien->y++;
			break;

		case ALIEN_TYPE_THICCBOI:
			if(!(frames % 4))
				alien->y++;
			break;
		default :
				fprintf( stderr , errorMsg);
				exit(1);
				break;
	}
}

static void set_alien_score( ALIEN* alien ,int cx ,int cy){
	switch(alien->type){
		case ALIEN_TYPE_BUG:
			score += BUG_SCORE;
			break;
		case ALIEN_TYPE_ARROW:
			score += ARROW_SCORE;
			break;
		case ALIEN_TYPE_THICCBOI:
			score += THICCBOI_SCORE;
			fx_add(false, cx-10, cy-4);
			fx_add(false, cx+4, cy+10);
			fx_add(false, cx+8, cy+8);
			break;
		default :
			fprintf( stderr ,errorMsg );
			exit(1);
			break;
	}
}