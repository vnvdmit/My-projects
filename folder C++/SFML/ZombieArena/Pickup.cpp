#include "Pickup.hpp"

Pickup::Pickup( int type ){
	m_Type = type;
	
	switch( m_Type ){
		case 1:
			m_Sprite = sf::Sprite( 
				TextureHolder::getTexture("Graphics/health_pickup.png") 
			);
			m_Value = HEALTH_START_VALUE;
			break;
		default:
			m_Sprite = sf::Sprite( 
				TextureHolder::getTexture("Graphics/ammo_pickup.png") 
			);
			m_Value = AMMO_START_VALUE;
			break;
	}
	
	m_Sprite.setOrigin(25 ,25);
	
	m_SecondsToLive = START_SECONDS_TO_LIVE;
	m_SecondsToWait = START_WAIT_TIME;
}

void Pickup::spawn(){
	srand( static_cast<int>(time(0)) / m_Type );
	int x = rand() % m_Arena.width;
	srand( static_cast<int>(time(0)) * m_Type );
	int y = rand() % m_Arena.height;
	
	m_SecondsSinceSpawn =    0;
	m_Spawned           = true;
	
	m_Sprite.setPosition( x ,y );
}

void Pickup::setArena( sf::IntRect arena ){
	m_Arena.top    = arena.top    + 50;
	m_Arena.width  = arena.width  - 50;
	m_Arena.left   = arena.left   + 50;
	m_Arena.height = arena.height - 50;
	
	spawn();
}

sf::FloatRect Pickup::getPosition(){
	return m_Sprite.getGlobalBounds();
}

sf::Sprite Pickup::getSprite(){
	return m_Sprite;
}

bool Pickup::isSpawned(){
	return m_Spawned;
}

int Pickup::gotIt(){
	m_Spawned = false;
	m_SecondsSinceSpawn = 0;
	return m_Value;
}

void Pickup::update( float elapsedTime ){
	if( m_Spawned ){
		m_SecondsSinceSpawn += elapsedTime;
	}
	else{
		m_SecondsSinceDeSpawn += elapsedTime;
	}
	
	if( (m_SecondsSinceSpawn > m_SecondsToLive) && m_Spawned ){
		m_Spawned = false;
		m_SecondsSinceDeSpawn = 0;
	}
	
	if( (m_SecondsSinceDeSpawn > m_SecondsToLive) && !m_Spawned ){
		spawn();
	}
}

void Pickup::upgrade(){
	if( 1 == m_Type ){
		m_Value += HEALTH_START_VALUE * 0.5;
	}
	else{
		m_Value += AMMO_START_VALUE * 0.5;
	}
	
	m_SecondsToLive += START_SECONDS_TO_LIVE/10;
	m_SecondsToWait += START_WAIT_TIME/10;
}
