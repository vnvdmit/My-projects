#include "Bee.hpp"

const int Bee::amplitude   =          100;
const double Bee::omega  = M_PI/180;

Bee::Bee( )
	: GameObject( "Graphics/bee.png" ),
	  yBeePosition( 800.0f ),
	  active( false ),
	  beeSpeed( 0.0f )
	{}
	
bool Bee::isActive(){
	return active;
}

void Bee::startBee(){
	srand((int)time(0)); // How fast bee?
	beeSpeed = (rand()%200)+200;
				
	srand((int)time(0)*10); //How high is the bee?
	yBeePosition= (rand()%500)+500;
	moveSprite(2000 ,yBeePosition);
	active = true;
}
	
void Bee::move( float dt ){
	const int amplitude   =          100;
	const double omega  = M_PI/180;
	float x = getPosition().x;
	//float y = getPosition().y;
	moveSprite( x -(beeSpeed * dt), yBeePosition - amplitude*sin(omega*x));
				
	if (x < -100){ //Reached the right corner?
		active = false;
	}
}