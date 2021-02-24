#include "game.h"
#include "sprites.h"
#include "ship.h"
#include "display.h"
#include "hud.h"
#include "keyboard.h"
#include "aliens.h"
#include "shot.h"

ALLEGRO_FONT* font;
long score_display;

void press_enter();

void hud_init()
{
    font = al_create_builtin_font();
    must_init(font, "font");

    score_display = 0;
}

void hud_deinit()
{
    al_destroy_font(font);
}

void hud_update(){
	if( running == state ){
		if(frames % 2)
			return;

		for(long i = 5; i > 0; i--){
			long diff = 1 << i;
			if(score_display <= (score - diff))
				score_display += diff;
		}
	}
}

void hud_draw(){
	static int blink = BLINK;
	if( running == state ){
		al_draw_textf(
			font,
			al_map_rgb_f(1,1,1),
			0, 
			0,
			ALLEGRO_ALIGN_LEFT,
			"%06ld",
			score_display
		);

		int spacing = LIFE_W + 1;
		for(int i = 0; i < ship.lives; i++)
			al_draw_bitmap(sprites.life, 1 + (i * spacing), 10, NO_FLAGS);

		if( ship.lives < 0 ){
			state = game_over;
		}
	}
	if( new_game == state || game_over == state){
		blink--;
		if( blink <= 0 ){
			blink = BLINK;
		}
		press_enter();
	}
	if( new_game == state && (blink>BLINK_LEVEL) ){
		al_draw_textf(
			                                    font,
			         al_map_rgb_f(1,1,1),
			                     BUFFER_W/2, 
								  BUFFER_H/2,
			ALLEGRO_ALIGN_CENTRE,
			        "Press Enter to start"
		);
	}
	if( game_over == state  ){
		al_draw_text(
                                               font,
                    al_map_rgb_f(1,1,1),
							  BUFFER_W / 2, 
							BUFFER_H / 2+8,
			ALLEGRO_ALIGN_CENTER,
			      "Press Enter to restart"
		);
		if( blink>BLINK_LEVEL ){
			al_draw_text(
													font,
						al_map_rgb_f(1,1,1),
								BUFFER_W / 2, 
									BUFFER_H / 2,
				ALLEGRO_ALIGN_CENTER,
							"G A M E  O V E R"
			);
		}
	}
}

void press_enter(){
	if( key[ALLEGRO_KEY_ENTER] ){
		ship.x                        = (BUFFER_W / 2) - (SHIP_W / 2);
		ship.y                        = (BUFFER_H / 2) - (SHIP_H / 2);
		ship.lives                  = INITIAL_SHIP_LIVES;
		ship.respawn_timer = 0;
		score                         = 0;
		score_display           = 0;
		
		for(int i = 0; i < ALIENS_N; i++)
			aliens[i].used = false;
		for(int i = 0; i < SHOTS_N; i++)
			shots[i].used = false;
		
		state = running;
	}
}