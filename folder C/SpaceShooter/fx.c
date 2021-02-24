#include <allegro5/allegro5.h>
#include <allegro5/allegro_audio.h>
#include <allegro5/allegro_acodec.h>

#include "game.h"
#include "sprites.h"
#include "audio.h"
#include "fx.h"

FX* fx;

void fx_init()
{
	fx = ( FX* )malloc( FX_N * sizeof(FX) );
    for(int i = 0; i < FX_N; i++)
        fx[i].used = false;
}

void fx_add(bool spark, int x, int y)
{
    if(!spark)
        al_play_sample(sample_explode[between(0, 2)], 0.75, 0, 1, ALLEGRO_PLAYMODE_ONCE, NULL);

    for(int i = 0; i < FX_N; i++)
    {
        if(fx[i].used)
            continue;

        fx[i].x = x;
        fx[i].y = y;
        fx[i].frame = 0;
        fx[i].spark = spark;
        fx[i].used = true;
        return;
    }
}

void fx_update()
{
	if ( running == state || game_over == state ){
		for(int i = 0; i < FX_N; i++){
			if(!fx[i].used)
				continue;

			fx[i].frame++;

			if((!fx[i].spark && (fx[i].frame == (EXPLOSION_FRAMES * 2)))
			|| ( fx[i].spark && (fx[i].frame == (SPARKS_FRAMES * 2)))
			)
				fx[i].used = false;
		}
	}
}

void fx_draw(){
	if( running == state || game_over == state ){
		for(int i = 0; i < FX_N; i++){
			if(!fx[i].used)
				continue;

			int frame_display = fx[i].frame / 2;
			ALLEGRO_BITMAP* bmp =
				fx[i].spark
				? sprites.sparks[frame_display]
				: sprites.explosion[frame_display];

			int x = fx[i].x - (al_get_bitmap_width(bmp) / 2);
			int y = fx[i].y - (al_get_bitmap_height(bmp) / 2);
			al_draw_bitmap(bmp, x, y, 0);
		}
	}
}

void fx_deinit(){
	free( fx );
	fx = NULL;
}