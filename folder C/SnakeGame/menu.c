#include <ncurses.h>
#include <stdlib.h>
#include "menu.h"

static int key_read( menu_elements *, int * );
static int game_quit();
static int game_begin();

void menu( int x, int y )
{
	int done = 0;
	menu_elements pointer  = NEW_GAME;
	unsigned int WIDE = 6;
	
	int i;
	
	char* menu_messages[TOTAL_MENU_ELEMENTS] =
	{
		"New Game",
		"Exit"
	};
	
	init_pair(1, COLOR_WHITE, COLOR_RED);
	init_pair(2, COLOR_WHITE, COLOR_BLACK);
	
	color_set(2, NULL);
	
	mvprintw(y/2-WIDE-1, x/3, "                #             ");
	mvprintw(y/2-WIDE  , x/3, "##  #   # ### #  # # #    #   ");
	mvprintw(y/2-WIDE+1, x/3, "  # ## ## #   # ## # #   # #  ");
	mvprintw(y/2-WIDE+2, x/3, "##  # # # ##  ## # ##   #   # ");
	mvprintw(y/2-WIDE+3, x/3, "  # #   # #   ## # # #  ##### ");
	mvprintw(y/2-WIDE+4, x/3, "##  #   # ### #  # # # #     #");
	mvprintw(y/2-WIDE+5, x/3, "                     A game by D.L. Voennov");
	
	while(!done){
		for( i=0 ; i<TOTAL_MENU_ELEMENTS ; i++ )
		{
			if (i==pointer)
			{
				color_set(1, NULL);
			}
			else
			{
				color_set(2, NULL);
			}
			mvprintw(y/2-WIDE+7+i,x/2-TOTAL_MENU_ELEMENTS/2, menu_messages[i]);
		}
		key_read( &pointer, &done );
	}
	color_set(2, NULL);
}

static int key_read( menu_elements* pointer, int* done )
{
	static int (*menu_actions[TOTAL_MENU_ELEMENTS])() = 
	{
		game_begin,
		game_quit
	};
	int c;
	
	c = getch();
	
		switch(c){
			case KEY_UP:
				if (*pointer != NEW_GAME)
				{
					*pointer -= 1;
				}
				break;
			case KEY_DOWN:
				if (++(*pointer) > TOTAL_MENU_ELEMENTS-1)
				{
					*pointer = TOTAL_MENU_ELEMENTS-1;
				}
				break;
			case '\n':
				*done = (*menu_actions[*pointer])();
				break;
			default:
				break;
		}
	return 0;
}

static int game_quit()
{
	endwin();
	exit(0);
}

static int game_begin()
{
	return 1;
}
