#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>
#include <time.h>
#include <unistd.h>
#include "menu.h"
#include "main.h"

struct Game game;

int main()
{
	int c;

	srand(time(NULL));
	if (!initscr()) /* ncurses initialization */
	{
		perror("Can't initialize ncurses!\n");
		exit(1);
	}
	start_color();
	if (!has_colors())
	{
		perror("There is no colors!\nToo boring to play ...");
		exit(2);
	}
	cbreak();       /* Disable line buffering */  
	curs_set(0);	/* Make cursor invisible */
	noecho();   	/* Symbols are not shown on screen */
	nodelay(stdscr, TRUE);
	keypad(stdscr, TRUE);
	
	while(TRUE){
		getmaxyx(stdscr, game.MAX.Ny, game.MAX.Nx);
		clear();
		wtimeout(stdscr, -1);
#ifdef DEBUG_MEMORY
		if (test( game.MAX.Nx, game.MAX.Ny ))
		{
			endwin();
			exit(0);
		}
#endif
		menu( game.MAX.Nx, game.MAX.Ny );
		clear();
		wtimeout(stdscr, 1000/FPS);
		init_snake();
		box(stdscr, 0, 0); /* Show box around main window */
		draw_scores();
		draw_food();
	
		while(!game.done){
			c = wgetch(stdscr);
			choose_action(c);
			erase_old_frames();
			move_snake();
			draw_new_frames();
#ifdef DEBUG
			mvprintw(0, 0, "tail_x=%2d, tail_y=%2d, maxX=%2d, maxY=%2d"
												,game.tail.x
												,game.tail.y
												,game.MAX.Nx
												,game.MAX.Ny
												);
#endif
			wrefresh(stdscr);
		}
		clean();
		clear();
		draw_game_over();
		sleep(3);
	}
	endwin();   /* Close ncurses */
	return 0;
}

void init_snake()
{
	int i;
	int j;
	
	game.tail = ( struct snake * )malloc( sizeof( struct snake ) );
	game.head = game.tail;
	
	game.tail->x     = 1+rand()%(game.MAX.Nx-2);
	game.tail->y     = 1+rand()%(game.MAX.Ny-2);
	game.tail->prev  = NULL;
	game.velocity.vx = 1;
	game.velocity.vy = 0;
	game.done        = FALSE;
	
	game.field = (struct Cell **)malloc((game.MAX.Nx-1)*sizeof(struct Cell *));
	for( i=1 ; i<(game.MAX.Nx-1) ; i++ )
	{
		game.field[i] = (struct Cell *)malloc((game.MAX.Ny-1)*sizeof(struct Cell));
	}
	
	for( i=1 ; i<(game.MAX.Nx-2) ; i++ )
	{
		for( j=1 ; j<(game.MAX.Ny-2) ; j++ )
		{
			game.field[i][j].is_used = 0;
		}
	}
	
	game.score = 0;
	
	set_food();
	
	game.MAX.Nx -= 2;
	game.MAX.Ny -= 2;

}

void set_food()
{
	int x;
	int y;
	
	x = 1+rand()%(game.MAX.Nx-1);
	y = 1+rand()%(game.MAX.Ny-1);
	
	if ( game.field[x][y].is_used )
	{
		for( x=1 ; x<game.MAX.Nx ; x++ )
		{
			for( y=1 ; y<game.MAX.Ny ; y++ )
			{
				if ( !(game.field[x][y].is_used) )
				{
					/*goto END;*/
					game.food.x = x;
					game.food.y = y;
					return;
				}
			}
		}
		game.done = 1;
	}
	
END:game.food.x = x;
	game.food.y = y;
}

void clean()
{
	int i;
	struct snake *tmp;
	struct snake *tmp_next;
	tmp = game.tail->prev;
	while(tmp){
		tmp_next = tmp->prev;
		free(tmp);
		tmp = tmp_next;
	}
	free(game.tail);
	
	for( i=0 ; i<(game.MAX.Nx+1) ; i++ )
	{
		free(game.field[i]);
	}
	free(game.field);
}
