#include <ncurses.h>
#include "main.h"

void choose_action( int key )
{
	switch(key){
			case KEY_UP: case 'j':
				if (game.velocity.vx)
				{
					set_snake_speed(0, -1);
				}
				break;
			case KEY_DOWN: case 'k':
				if (game.velocity.vx)
				{
					set_snake_speed(0, 1);
				}
				break;
			case KEY_LEFT: case 'h':
				if (game.velocity.vy)
				{
					set_snake_speed(-1, 0);
				}
				break;
			case KEY_RIGHT: case 'l':
				if (game.velocity.vy)
				{
					set_snake_speed(1, 0);
				}
				break;
			case 'q':
				game.done = TRUE;
				break;
			case ERR:
				break;
			default:
				break;
		}
}

void set_snake_speed( int vx, int vy )
{
	game.velocity.vx = vx;
	game.velocity.vy = vy;
}
