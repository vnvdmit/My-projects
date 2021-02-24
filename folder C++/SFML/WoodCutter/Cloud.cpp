#include "Cloud.hpp"

Cloud::Cloud( int number ,const char* pathToPosition )
	: totalObjects(number)
{
		texture.loadFromFile( pathToPosition );
		
		sprites = new sf::Sprite[ totalObjects ];
		speeds = new float[ totalObjects ];
		actives = new bool[ totalObjects ];
		for( int i=0 ; i<totalObjects ; i++ ){
			sprites[i].setTexture( texture );
			sprites[i].setPosition( 0 ,250*i );
			speeds[i] = 0.0f;
			actives[i] = false;
		}
}

void Cloud::update( float dt ){
	for( int i=0 ; i<totalObjects ; i++ ){
		if (!actives[i]){
			srand((int)time(0)*(i+1));
			speeds[i] = (rand()%200);
			
			float height = (rand()%150);
			sprites[i].setPosition( -200 ,height);
			actives[i] = true;
		}
		else{
			float x = sprites[i].getPosition().x;
			float y = sprites[i].getPosition().y;
			sprites[i].setPosition( x + speeds[i]*dt , y );
			if (sprites[i].getPosition().x > 1920){
				actives[i] = false;
			}
		}
	}
}

void Cloud::draw(sf::RenderTarget& target, sf::RenderStates states) const{
	
	for( int i=0 ; i<totalObjects ; i++ ){
			target.draw( sprites[i] ,states );
		}
	
}

Cloud::~Cloud(){
	
	delete[] sprites;
	delete[] speeds;
	delete[] actives;
	
}