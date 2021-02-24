#include "Branches.hpp"

Branches::Branches( int number , const char* pathToTexture)
	: totalObjects( number )
{
	texture.loadFromFile( pathToTexture );
	
	sprites = new sf::Sprite[ totalObjects ];
	sides   = new side[ totalObjects ];
	for( int i=0 ; i<totalObjects ; i++ ){
		sprites[i].setTexture( texture );
		sprites[i].setPosition( -2000 ,-2000 );
		sprites[i].setOrigin( 235 ,31 );
	}
	clear();
}

side& Branches::operator[]( int position ){
	return sides[ position ];
}

void Branches::assignBranches( int seed ){
	for( int i = totalObjects-1 ; i>0 ; i-- ){
		sides[i] = sides[i-1];
	}
	
	srand((int)time(0)+seed);
	int r = (rand()%5);
	switch (r){
		case 0:
			sides[0] = side::LEFT;
			break;
		case 1:
			sides[0] = side::RIGHT;
			break;
		default:
			sides[0] = side::NONE;
			break;
	}
}

void Branches::clear(){
	for( int i=1 ; i<totalObjects; i++ ){
		sides[i] = side::NONE;
	}
}

void Branches::update(){
	for( int i=0 ; i<totalObjects ; i++ ){
		float height = i*150;
		if ( sides[i] == side::LEFT ){
			sprites[i].setPosition(710 ,height);
			sprites[i].setRotation(180);
		}
		else if ( sides[i] == side::RIGHT ){
			sprites[i].setPosition(1230 ,height);
			sprites[i].setRotation(0);
		}
		else{
			sprites[i].setPosition(3000 ,height);
		}
	}
}

void Branches::draw(sf::RenderTarget& target, sf::RenderStates states) const{
	
	for( int i=0 ; i<totalObjects ; i++ ){
			target.draw( sprites[i] ,states );
		}
	
}


Branches::~Branches(){
	
	delete[] sprites;
	delete[] sides;
	
}