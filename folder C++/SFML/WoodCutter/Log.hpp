#ifndef LOG_H
#define LOG_H

#include "GameObject.hpp"

class Log : public GameObject{
public:
	Log();
	
	void makeActive();
	void makePassive();
	bool isActive();
	
	void makeSpeedX( float value );
	
	void move( float dt );
private:
	bool logActive;
	
	int speedX;
	int speedY;
};

#endif