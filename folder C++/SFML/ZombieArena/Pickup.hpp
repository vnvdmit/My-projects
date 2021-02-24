#pragma once
#include <SFML/Graphics.hpp>
#include "Texture holder.hpp"

class Pickup{
public:
	Pickup( int type );
	
	void setArena( sf::IntRect arena );
	void spawn();
	
	sf::FloatRect getPosition();
	
	sf::Sprite getSprite();
	
	void update( float elapsedTime );
	
	bool isSpawned();
	
	int gotIt(); //Goodness ???
	
	void upgrade();
private:
	const int HEALTH_START_VALUE    = 50;
	const int AMMO_START_VALUE      = 12;
	const int START_WAIT_TIME       = 10;
	const int START_SECONDS_TO_LIVE = 5;
	
	sf::Sprite m_Sprite;
	
	sf::IntRect m_Arena; //Where it is exist;
	
	int m_Value;
	int m_Type; //1-health 2-ammo {Why not used ENUM?}
	
	bool m_Spawned;
	float m_SecondsSinceSpawn;
	float m_SecondsSinceDeSpawn;
	float m_SecondsToLive;
	float m_SecondsToWait;
	
	
};
