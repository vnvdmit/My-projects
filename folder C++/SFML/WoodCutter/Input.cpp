#include "Engine.hpp"

void Engine::input(){
	/*
	*************************************
	Handle the player input 
	************************************* 
	*/
	sf::Event event;
	
	while( window.pollEvent(event) ){
		if ( event.type == sf::Event::KeyReleased && !paused ){
			acceptInput = true;
			axe.moveSprite( 2000 ,axe.getPosition().y );
		}
	}
	if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Escape) ){
		window.close();
	}
	else if ( sf::Keyboard::isKeyPressed(sf::Keyboard::Return) ){
		paused               = false;
		score                  =       0;
		timeRemaining =       5;
		branches.clear();
		gravestone.hide();
		player.moveLeft();
		
		acceptInput = true;
	}
	
	if ( acceptInput ){
		if ( sf::Keyboard::isKeyPressed( sf::Keyboard::Right ) ){
			player.moveRight();
			score++;
			std::stringstream ss;
			ss << "Score = " << score;
			scoreText.setString(ss.str());
			
			timeRemaining += (2.0/score) + 0.15;
			
			axe.moveSprite( AXE_POSITION_RIGHT ,axe.getPosition().y );
			/*updateBranches(score);*/
			branches.assignBranches( score );
			
			log.makeSpeedX( -5000.0f );
			log.makeActive();
		
			acceptInput = false;
			
			chop.play();
		}
		if ( sf::Keyboard::isKeyPressed( sf::Keyboard::Left ) ){
			player.moveLeft();
			score++;
			std::stringstream ss;
			ss << "Score = " << score;
			scoreText.setString(ss.str());
			
			timeRemaining += (2.0/score) + 0.15;
			
			axe.moveSprite( AXE_POSITION_LEFT ,axe.getPosition().y );
			/*updateBranches(score);*/
			branches.assignBranches( score );

			log.makeSpeedX( 5000.0f );
			log.makeActive();
			acceptInput = false;
				
			chop.play();
		}
	}
}