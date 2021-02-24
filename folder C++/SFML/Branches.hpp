#ifndef BRANCHES_H
#define BRANCHES_H

#include <SFML/Graphics.hpp>
#include "game.hpp"

class Branches : public sf::Drawable{
public:
	Branches( int number ,const char* pathToTexture );
	
	side& operator[]( int position );
	
	void clear();
	void update();
	
	void assignBranches( int seed );
	
	virtual void draw( sf::RenderTarget& target ,sf::RenderStates states ) const;
	
	virtual ~Branches();
private:

	sf::Sprite*  sprites;
	side* sides;
	int totalObjects;
	
	sf::Texture texture;
	
};

#endif