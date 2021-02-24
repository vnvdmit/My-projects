#ifndef MAIN_H
#define MAIN_H

/*
#define DEBUG
#define DEBUG_MEMORY 
*/

#define MAX_X 78
#define MAX_Y 22

#define FPS 5
#define HEAD_SYMBOL '@'
#define BODY_SYMBOL '#'
#define FOOD_SYMBOL '*'
#define BLANK ' '
#define SCORE_LENGTH 5

/*typedef enum sequences
{
	OBSTACLE,
	FOOD,
	FREE,
	TOTAL_SEQUENCES
} sequence;*/

struct Game
{
	struct snake
	{
		int x;
		int y;
		
		struct snake *prev;
	} *head, *tail;
	
	struct
	{
		int vx;
		int vy;
	}velocity;
	
	struct
	{
		unsigned int Nx;
		unsigned int Ny;
	}MAX;
	
	struct
	{
		int x;
		int y;
	}food;
	
	struct Cell
	{
		int is_used;
	}** field;
	
	unsigned int score;
	
	int done;
};

extern struct Game game;

void init_snake();
void choose_action( int );
void choose_consequence();
void set_snake_speed( int, int );
void set_food();
void move_snake();
void erase_old_frames();
void draw_new_frames();
void draw_scores();
void draw_food();
void draw_game_over();
void clean();

int test( int, int );

#endif
