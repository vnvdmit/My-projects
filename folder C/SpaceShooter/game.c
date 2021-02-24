#include <stdio.h>
#include <allegro5/allegro_primitives.h>
#include <allegro5/allegro_audio.h>
#include <allegro5/allegro_image.h>

#include "game.h"
#include "keyboard.h"
#include "display.h"
#include "sprites.h"
#include "audio.h"
#include "fx.h"
#include "shot.h"
#include "ship.h"
#include "aliens.h"
#include "stars.h"
#include "hud.h"

enum error_messages{
	allegro_error,
	keyboard_error,
	timer_error,
	queue_error,
	image_error,
	primitives_error,
	total_errors
};

char* error_msg[total_errors] = {
	"allegro",
	"keyboard",
	"timer",
	"queue",
	"image",
	"primitives"
};

long frames = 0;
long score    = 0;

enum game_state state = new_game;

int main()
{
    must_init( al_init(), error_msg[allegro_error] );
    must_init( al_install_keyboard(), error_msg[keyboard_error] );

    ALLEGRO_TIMER* timer = al_create_timer(1.0 / FPS);
    must_init( timer, error_msg[timer_error] );

    ALLEGRO_EVENT_QUEUE* queue = al_create_event_queue();
    must_init( queue, error_msg[queue_error] );

    disp_init();

    audio_init();

    must_init( al_init_image_addon(), error_msg[image_error] );
    sprites_init();

    hud_init();

    must_init( al_init_primitives_addon(), error_msg[primitives_error] );

    al_register_event_source(queue, al_get_keyboard_event_source());
    al_register_event_source(queue, al_get_display_event_source(disp));
    al_register_event_source(queue, al_get_timer_event_source(timer));

    keyboard_init();
    fx_init();
    shots_init();
    ship_init();
    aliens_init();
    stars_init();

    bool redraw = true;
    ALLEGRO_EVENT event;

    al_start_timer(timer);

    while(exit_game != state)
    {
        al_wait_for_event(queue, &event);
        switch( event.type ){
            case ALLEGRO_EVENT_TIMER:
                fx_update();
                shots_update();
                stars_update();
                ship_update();
                aliens_update();
                hud_update();

                if( key[ALLEGRO_KEY_ESCAPE] ){
                    state = exit_game;
				}

                redraw = true;
                frames++;
                break;

            case ALLEGRO_EVENT_DISPLAY_CLOSE:
                state = exit_game;
                break;
        }

        keyboard_update( &event );

        if( redraw && al_is_event_queue_empty(queue) ){
            disp_pre_draw();
            al_clear_to_color( al_map_rgb(1.0 ,1.0 ,1.0) );
            stars_draw();
            aliens_draw();
            shots_draw();
            fx_draw();
            ship_draw();
            hud_draw();
            disp_post_draw();
            redraw = false;
        }
    }

    sprites_deinit();
    hud_deinit();
    audio_deinit();
    disp_deinit();
	fx_deinit();
	shots_deinit();
	aliens_deinit();
	stars_deinit();
    al_destroy_timer(timer);
    al_destroy_event_queue(queue);

    return 0;
}

void must_init(bool test, const char *description){
    if(test) return;

    fprintf(stderr ,"couldn't initialize %s\n" ,description);
    exit(1);
}