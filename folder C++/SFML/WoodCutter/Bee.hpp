#ifndef BEE_H
#define BEE_H

#include <cmath>

#include "GameObject.hpp"

class Bee : public GameObject{
public:
	Bee();
	bool isActive();
	void startBee();
	void move( float dt );
private:
	float    yBeePosition;
	bool active;
	float beeSpeed;
	
	static const int amplitude;
	static const double omega;
};

#endif