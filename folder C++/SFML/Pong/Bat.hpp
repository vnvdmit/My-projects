#pragma once
#include <SFML/Graphics.hpp>

class Bat{
public:
	Bat( float startX ,float startY );
	
	sf::FloatRect getPosition(); 
	
	sf::RectangleShape getShape();
	
	void moveLeft();
	void moveRight();
	void stopLeft();
	void stopRight();
	
	void update( sf::Time dt );
private:
	sf::Vector2f              m_Position;
	sf::RectangleShape m_Shape;
	
	float m_Speed = 1000.0f;
	
	bool m_MovingRight;
	bool m_MovingLeft;
};