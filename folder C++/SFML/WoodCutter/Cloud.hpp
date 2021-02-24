#ifndef CLOUD_H
#define CLOUD_H

#include <SFML/Graphics.hpp>

class Cloud : public sf::Drawable{
public:
	Cloud( int number ,const char* pathToPosition );
	
	void update( float dt );
	
	virtual void draw( sf::RenderTarget& target ,sf::RenderStates states ) const;
	
	virtual ~Cloud();
private:

	float*         speeds;
	bool*          actives;
	sf::Sprite*  sprites;
	int totalObjects;
	
	sf::Texture texture;
	
};

#endif