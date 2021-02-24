#include <ncurses.h>
#include <stdlib.h>
#include "main.h"

struct Cells
{
	int is_used;
}; 

int test( int X, int Y )
{
	
	
	struct Cells** field;
	int i;
	int j;
	
	int x=1;
	int y=1;
	
	int done = 0;
	
	int c;
	
	field = (struct Cells **)malloc((X-1)*sizeof(struct Cells *));
	for( i=1 ; i<(X-1) ; i++ )
	{
		field[i] = (struct Cells *)malloc((Y-1)*sizeof(struct Cells));
	}
	
	for( i=1 ; i<X-2 ; i++ )
	{
		for( j=1 ; j<Y-2 ; j++ )
		{
			field[i][j].is_used = 0;
		}
	}
	
	clear();
	box(stdscr, 0, 0);
	while(!done){
		mvaddch(y, x, 'w');
		mvprintw(0, 0, "x=%2d, y=%2d, maxX=%2d, maxY=%2d"
											,x
											,y
											,X
											,Y
											);
		c = getch();
		mvaddch(y, x, ' ');
		switch(c){
			case KEY_UP:
				y--;
				if ( y<1)
				{
					y = Y-2;
				}
				break;
			case KEY_DOWN:
				y++;
				if ( y>Y-2)
				{
					y = 1;
				}
				break;
			case KEY_LEFT:
				x--;
				if ( x<1)
				{
					x = X-2;
				}
				break;
			case KEY_RIGHT:
				x++;
				if ( x>X-2)
				{
					x = 1;
				}
				break;
			case 'q':
				done = 1;
				break;
			default:
				break;
		}
		mvprintw(Y-1, 0, "x=%2d, y=%2d", x, y);
		field[x][y].is_used = 1;
		
	}
	for( i=1 ; i<X-1 ; i++ )
	{
		free(field[i]);
	}
	free(field);
	return 1;
}
