#include <sstream>
#include <cstdlib>
#include <SFML/Graphics.hpp>

#include "Bat.hpp"
#include "Ball.hpp"

static const int screenW = 1920;
static const int screenH = 1080; 

int main(){
	
	sf::VideoMode vm( screenW ,screenH );
	
	sf::RenderWindow window( vm ,"pong" ,sf::Style::Fullscreen );
	
	int score = 0;
	int lives  = 3;
	
	Bat bat(  screenW/2 ,screenH-20 );
	Ball ball( screenW/2 ,0                 );
	
	sf::Text hud;
	sf::Font font;
	font.loadFromFile("Fonts/DS-DIGIT.TTF");
	hud.setFont( font );
	hud.setCharacterSize( 75 );
	hud.setFillColor( sf::Color::White );
	hud.setPosition( 20, 20 );
	
	sf::Clock clock;
	
	while( window.isOpen() ){
		
		/*
		 **************************
		 *	Handle player's Input  *
		 **************************
		*/
		
		sf::Event event;
		while( window.pollEvent(event) ){
			if( sf::Event::Closed == event.type ){
				window.close();
			}
		}
		
		if( sf::Keyboard::isKeyPressed( sf::Keyboard::Escape ) ){
			window.close();
		}
		
		if( sf::Keyboard::isKeyPressed( sf::Keyboard::Left ) ){
			bat.moveLeft();
		}
		else{
			bat.stopLeft();
		}
		
		if( sf::Keyboard::isKeyPressed( sf::Keyboard::Right ) ){
			bat.moveRight();
		}
		else{
			bat.stopRight();
		}
		
		/*
		 *******************
		 *	Update Bat etc *
		 *******************
		*/
		
		sf::Time dt = clock.restart();
		bat.update( dt );
		ball.update( dt );
		
		std::stringstream ss;
		ss << "Score : " << score << " Lives : " << lives;
		hud.setString( ss.str() );
		
		if( ball.getPosition().top > window.getSize().y ){
			ball.reboundBottom();
			
			lives--;
			
			if( lives<0 ){
				score = 0;
				lives  = 3;
			}
		}
		
		if( ball.getPosition().top<0 ){
			ball.reboundBatOrTop();
			score++;
		}
		
		if( 
			ball.getPosition().left<0 || 
			ball.getPosition().left+ball.getPosition().width > window.getSize().x 
			){
				ball.reboundSides();
		}
		
		if( ball.getPosition().intersects(bat.getPosition()) ){
			ball.reboundBatOrTop();
		}
		
		/*
		 ******************
		 *	Draw evething*
		 ******************
		*/
		
		window.clear();
		window.draw( hud );
		window.draw( bat.getShape() );
		window.draw( ball.getShape() );
		window.display();
		
	}
	
	return 0;
}