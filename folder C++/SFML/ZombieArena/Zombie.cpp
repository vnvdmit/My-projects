#include "Zombie.hpp"
#include "Texture holder.hpp"

void Zombie::spawn( float startX ,float startY ,int type ,int seed ){
	switch (type){
		case 0: //Bloater
			m_Sprite = sf::Sprite( 
				TextureHolder::getTexture("Graphics/bloater.png") 
			);
			m_Speed  = BLOATER_SPEED;
			m_Health = BLOATER_HEALTH;
			break;
		case 1: //Chaser
			m_Sprite = sf::Sprite( 
				TextureHolder::getTexture("Graphics/chaser.png") 
			);
			m_Speed  = CHASER_SPEED;
			m_Health = CHASER_HEALTH - 10.0;
			break;
		case 2: //Crawler
			m_Sprite = sf::Sprite( 
				TextureHolder::getTexture("Graphics/crawler.png") 
			);
			m_Speed  = CRAWLER_SPEED;
			m_Health = CRAWLER_HEALTH;
			break;
		default:
			break;
	}
	
	srand( static_cast<int>(time(0))*seed ); //Modify speed
	float modifier = ( rand() % MAX_VARRIANCE ) + OFFSET;
	modifier /= 100.0;
	m_Speed *= modifier;
	
	m_Position.x = startX;
	m_Position.y = startY;
	
	m_Sprite.setOrigin(25 ,25);
	
	m_Sprite.setPosition( m_Position );
	
	m_Alive = true;
}

bool Zombie::hit(){
	
	m_Health--;
	
	if( m_Health<0 ){
		m_Alive = false;
		m_Sprite.setTexture( TextureHolder::getTexture("Graphics/blood.png") );
		
		return true;
	}
	
	return false;
	
}

bool Zombie::isAlive(){
	return m_Alive;
}

sf::FloatRect Zombie::getPosition(){
	return m_Sprite.getGlobalBounds();
}

sf::Sprite Zombie::getSprite(){
	return m_Sprite;
}

void Zombie::update( float elapsedTime ,sf::Vector2f playerLocation){
	float playerX = playerLocation.x;
	float playerY = playerLocation.y;
	
	if( playerX > m_Position.x ){
		m_Position.x += m_Speed*elapsedTime;
	}
	
	if( playerX < m_Position.x ){
		m_Position.x -= m_Speed*elapsedTime;
	}
	
	if( playerY > m_Position.y ){
		m_Position.y += m_Speed*elapsedTime;
	}
	
	if( playerY < m_Position.y ){
		m_Position.y -= m_Speed*elapsedTime;
	}
	
	m_Sprite.setPosition( m_Position );
	
	float angle = (180/M_PI)*atan2(
		playerY - m_Position.y,
		playerX - m_Position.x
	);
	
	m_Sprite.setRotation( angle );
}
