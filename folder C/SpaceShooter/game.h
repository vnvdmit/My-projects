#ifndef GAME_H
#define GAME_H

#include <allegro5/allegro5.h>

#define FPS   30

#define NO_FLAGS 0

struct Box{
	int x1;
	int y1;
	int x2;
	int y2;
};

enum game_state{
	running,
	paused,
	game_over,
	new_game,
	exit_game
};

extern enum game_state state;

extern long frames;
extern long score;

void must_init(bool test, const char *description);
int between(int lo, int hi);
float between_f(float lo, float hi);
bool collide( struct Box box1 ,struct Box box2 );

#endif