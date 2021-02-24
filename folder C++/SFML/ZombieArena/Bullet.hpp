#pragma once
#include <cmath>
#include <SFML/Graphics.hpp>

class Bullet{
public:
	Bullet();
	void stop();
	bool isInFlight();
	void shoot(
		float startX,
		float startY,
		float xTarget,
		float yTarget
	);
	sf::FloatRect getPosition();   //Where is bullet
	sf::RectangleShape getShape(); //Shape for drawing
	void update( float elapsedTime );
private:
	sf::Vector2f m_Position;
	sf::RectangleShape m_BulletShape; //How bullet looks
	
	bool m_InFlight = false;
	
	float m_BulletSpeed = 1000;
	
	float m_BulletDistanceX; //Derived from bullet speed
	float m_BulletDistanceY; // ?
	
	float m_MaxX;
	float m_MinX;
	float m_MaxY;
	float m_MinY;
};
