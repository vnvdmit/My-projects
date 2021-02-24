#include "Log.hpp"

Log::Log()
	: GameObject( "Graphics/log1.png" ),
	  logActive( false ),
	  speedY( -1500 )
{ hide(); }

void Log::makeActive(){
	moveSprite( 810 ,720 ); 
	show();
	logActive = true;
}

void Log::makePassive(){
	logActive = false;
}

bool Log::isActive(){
	return logActive;
}

void Log::makeSpeedX( float value ){
	speedX = value;
}

void Log::move( float dt ){
	float x = getPosition().x + speedX*dt ;
	float y = getPosition().y + speedY*dt ;
	if( x>2000 || x < -100 ){
		logActive = false;
		hide();
	}
	moveSprite( x ,y );
}