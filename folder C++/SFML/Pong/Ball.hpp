#pragma once

#include <SFML/Graphics.hpp>

class Ball{
public:
	Ball( float startX ,float startY );
	
	sf::FloatRect getPosition();
	sf::RectangleShape getShape();
	
	float getXVelocity();
	
	void reboundSides();
	void reboundBatOrTop();
	void reboundBottom();
	
	void update( sf::Time dt );
private:
	sf::Vector2f m_Position;
	sf::RectangleShape m_Shape;
	
	float m_Speed = 300.0f;
	float m_DirectionX = 0.5f;
	float m_DirectionY = 0.5f;
};