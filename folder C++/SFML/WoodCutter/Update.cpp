#include "Engine.hpp"

void Engine::update(){
	/*
	*****************************
	Update scene
	*****************************
	*/
	if (!paused){
		sf::Time dt = clock.restart();
		timeRemaining -= dt.asSeconds();
		
		timeBar.setSize(
			sf::Vector2f(
					timeBarWidthPerSecond * timeRemaining 
					,timeBarHeight
				)
		);
		if (timeRemaining <= 0.0f){
			paused = true;
			messageText.setString("Out of time!!");
			
			sf::FloatRect textRect = messageText.getLocalBounds();
			messageText.setOrigin(
				textRect.left +  textRect.width/2.0f
				,textRect.top  + textRect.height/2.0f
			);
			messageText.setPosition(resolution.x/2.0f ,resolution.y/2.0f);
			
			death.play();
		}
		if ( !(bee.isActive()) ){
			 bee.startBee();
		}
		else {
			 bee.move( dt.asSeconds() );
		}
			clouds.update( dt.asSeconds() );
		branches.update(); //WHAT IS IT???????????????????????????????????????????????????????????????????????????????????
		if ( log.isActive() ){ //Flying log
			log.move( dt.asSeconds() );
		}
		
		if (  player.collision( branches[5] ) ){ //Death
			
			paused         = true;
			acceptInput = false;
			
			gravestone.show();
			player.death();
			
			messageText.setString("SQUISHED");
			sf::FloatRect textRect = messageText.getLocalBounds();
			
			messageText.setOrigin(
				 textRect.left + textRect.width/2.0f
				,textRect.top + textRect.height/2.0f
			);
			
			messageText.setPosition(
				 resolution.x/2.0f
				,resolution.y/2.0f
			);
			
			death.play();
		}
	}
}