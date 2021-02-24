#ifndef PLAYER_H
#define PLAYER_H

#include "game.hpp"
#include "GameObject.hpp"

class Player : public GameObject {
public:
	Player();
	void moveLeft();
	void moveRight();
	void death();
	bool collision( side branch );
	
private:
	side playerSide;
};

#endif