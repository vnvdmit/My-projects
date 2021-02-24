#include <ncurses.h>
#include <string.h>
#include "main.h"

void erase_old_frames()
{
	
	mvwaddch(stdscr, game.tail->y, game.tail->x, BLANK);
	if ( !(game.tail == game.head) )
	{
		mvwaddch(stdscr, game.head->y, game.head->x, BODY_SYMBOL);
	}
}

void draw_new_frames()
{
#ifdef DEBUG
	int i;
	int j;
	for( i=0 ; i<MAX_X ; i++ )
	{
		for( j=0 ; j<MAX_Y ; j++ )
		{
			if ( game.field[i][j].is_used )
				mvwaddch(stdscr, j, i, '&');
		}
	}
#endif
	mvwaddch(stdscr, game.head->y, game.head->x, HEAD_SYMBOL);
}

void draw_food()
{
	mvwaddch(stdscr, game.food.y, game.food.x, FOOD_SYMBOL);
}

void draw_scores()
{
	char* message = "Score %*d";
	mvprintw(game.MAX.Ny+1, game.MAX.Nx-strlen(message)-SCORE_LENGTH+2
															,message
															,SCORE_LENGTH 
															,game.score);
}

void draw_game_over()
{
	mvprintw(game.MAX.Ny/2, game.MAX.Nx/2, "Game over!");
	mvprintw(game.MAX.Ny/2+1, game.MAX.Nx/2, "Score:%5d", game.score);
	refresh();
}
