#include "GameObject.hpp"

GameObject::GameObject( const char* pathToPosition )
	: visible( true )
{
	texture.loadFromFile( pathToPosition );
	sprite.setTexture( texture );
}

void GameObject::moveSprite( int x ,int y ){
	sprite.setPosition( x ,y );
}

sf::Vector2f GameObject::getPosition(){
	return sprite.getPosition();
}

void GameObject::show(){
	visible = true;
}

void GameObject::hide(){
	visible = false;
}

bool GameObject::isVisible(){
	return visible;
}

void GameObject::draw(sf::RenderTarget& target, sf::RenderStates states) const{
	target.draw( sprite ,states );
}