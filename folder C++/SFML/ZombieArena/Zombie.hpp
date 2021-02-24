#pragma once
#include <SFML/Graphics.hpp>
#include <cstdlib>
#include <ctime>
#include <cmath>

class Zombie{
public:
	bool hit();
	
	bool isAlive();
	
	void spawn( float startX ,float startY ,int type ,int seed ); //spawn a new zombie
	
	sf::FloatRect getPosition();
	
	sf::Sprite getSprite();
	
	void update( float elipsedTime ,sf::Vector2f playerLocation );
private:
	const float BLOATER_SPEED = 40.0;
	const float CHASER_SPEED  = 80.0;
	const float CRAWLER_SPEED = 20.0;
	
	const float BLOATER_HEALTH = 5.0;
	const float CHASER_HEALTH  = 1.0;
	const float CRAWLER_HEALTH = 3.0;
	
	const int MAX_VARRIANCE = 30; //Vary zombie speed
	const int OFFSET        = 101 - MAX_VARRIANCE;
	
	sf::Vector2f m_Position; //Location of zombie
	
	sf::Sprite m_Sprite;     //Zombie's sprite
	
	float m_Speed;
	
	float m_Health;
	
	bool m_Alive;
	
};
