#include <ncurses.h>
#include <stdlib.h>
#include "main.h"

static void collisions( int, int );
static void add_snake( int, int );

void move_snake()
{
	int x_tmp;
	int y_tmp;
	
	struct snake *tmp;
	tmp = game.tail;
	
	x_tmp = game.tail->x;
	y_tmp = game.tail->y;
	
	while(tmp->prev){
		tmp->x = tmp->prev->x;
		tmp->y = tmp->prev->y;
		tmp = tmp->prev;
	}
	game.head = tmp;
	
	game.field[game.tail->x][game.tail->y].is_used = 0;
	
	tmp->x += game.velocity.vx;
	tmp->y += game.velocity.vy;
	
	if (tmp->x > game.MAX.Nx)
	{
		tmp->x = 1;
	}
	else if (tmp->x <= 0)
	{
		tmp->x = game.MAX.Nx;
	}
	else if (tmp->y > game.MAX.Ny)
	{
		tmp->y = 1;
	}
	else if (tmp->y <= 0)
	{
		tmp->y = game.MAX.Ny;
	}
	collisions(x_tmp, y_tmp);
	game.field[game.head->x][game.head->y].is_used = 1;
}

static void collisions( int x, int y )
{
	if ( (game.head->x == game.food.x) && (game.head->y == game.food.y) )
	{
		set_food();
		draw_food();
		game.score += 5;
		draw_scores();
		add_snake(x, y);
	}
	
	if ( game.field[game.head->x][game.head->y].is_used )
	{
		game.done = TRUE;
	}
}

static void add_snake( int x, int y )
{
	struct snake *tmp;
	
	tmp = (struct snake *)malloc(sizeof(struct snake));
	tmp->x = x;
	tmp->y = y;
	tmp->prev = game.tail;
	game.tail = tmp;
}
