#pragma once
#include <SFML/Graphics.hpp>
#include "Texture holder.hpp"

class Player{
public:
	Player();
	void spawn(
		sf::IntRect  arena,
		sf::Vector2f resolution,
		int          tileSize
	);
	void          resetPlayerStats(     );
	bool          hit( sf::Time timeHit );       //When player hitted
	sf::Time      getLastHitTime(       ) const;
	sf::FloatRect getPosition(          ) const; //Position of player
	sf::Vector2f  getCenter(            ) const; //Center of player
	float         getRotation(          ) const; //Angle of player
	sf::Sprite    getSprite(            ) const; //Set a copy of sprite to main function
	void          moveLeft(             );
	void          moveRight(            );
	void          moveUp(               );
	void          moveDown(             );
	void          stopLeft(             );       //Stop to moving player in particular direction
	void          stopRight(            );
	void          stopUp(               );
	void          stopDown(             );
	void          update(
				      float elipsedTime,
				      sf::Vector2i mousePosition
				  );
	void          upgradeSpeed(                   );
	void          upgradeHealth(                  );
	void          increaseHealthLevel( int amount );
	int           getHealth(                      ) const;
	
private:
	const float START_SPEED  = 200;
	const float START_HEALTH = 100;
	
	sf::Vector2f m_Position;   //Where s the player
	
	sf::Sprite   m_Sprite;     //Texture !!Watch this space!!
	sf::Texture  m_Texture;
	
	sf::Vector2f m_Resolution; //Screen resolution ?
	
	sf::IntRect  m_Arena;      //Size of Arena
	int          m_TileSize;   //How big tile of Arena
	
	bool m_UpPressed;          //Which directions player is moving
	bool m_DownPressed;
	bool m_LeftPressed;
	bool m_RightPressed;
	
	int m_Health;
	int m_MaxHealth;
	
	sf::Time m_LastHit;
	
	float m_Speed;
};
