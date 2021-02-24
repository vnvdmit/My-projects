#ifndef GAMEOBJECT_H
#define GAMEOBJECT_H

#include <SFML/Graphics.hpp>

class GameObject : public sf::Drawable{
public:
	GameObject( const char* pathToPosition );
	void moveSprite( int x ,int y );
	sf::Vector2f getPosition();
	
	void show();
	void hide();
	bool isVisible();
	
	virtual void draw( sf::RenderTarget& target ,sf::RenderStates states ) const;
private:
	sf::Texture texture;
	sf::Sprite    sprite;
	bool visible;
};

#endif