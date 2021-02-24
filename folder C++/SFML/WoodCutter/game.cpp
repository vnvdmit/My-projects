#include <sstream>
#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include <SFML/Audio.hpp>

#include "game.hpp"
#include "Player.hpp"
#include "Bee.hpp"
#include "Background.hpp"
#include "Tree.hpp"
#include "Axe.hpp"
#include "Gravestone.hpp"
#include "Log.hpp"
#include "Cloud.hpp"
#include "Branches.hpp"

enum objects {
	background,
	player,
	tree,
	axe,
	bee,
	gravestone,
	logOne,
	totalObjects
	};

static const int NUM_BRANCHES = 6;
static const int NUM_CLOUDS      = 3;

static const struct{
	int x;
	int y;
}resolution = { 
	.x = 1920, 
	.y = 1080 
};

static const float AXE_POSITION_LEFT    =   700.0;
static const float AXE_POSITION_RIGHT = 1075.0;

void setText( sf::Text* ,const sf::Font& ,const char* ,const int ,const sf::Color& );
int main(){
	
	sf::Clock clock;
	sf::RectangleShape timeBar;
	float timeBarStartWidth = 400.0;
	float timeBarHeight        =   80.0;
	timeBar.setSize(sf::Vector2f(timeBarStartWidth ,timeBarHeight));
	timeBar.setFillColor(sf::Color::Red);
	timeBar.setPosition((resolution.x/2)-timeBarStartWidth/2 ,980);
	sf::Time gameTimeTotal;
	float timeRemaining = 6.0f;
	float timeBarWidthPerSecond = timeBarStartWidth / timeRemaining;
	bool paused = true;
	int score       =      0;
	
	sf::VideoMode vm(resolution.x, resolution.y); //Video mode
	sf::RenderWindow window(vm, "Timber!!!", sf::Style::Fullscreen);
	
	sf::Text messageText; //Text manipulation
	sf::Text scoreText;
	sf::Font font;
	font.loadFromFile("Fonts/Komikap.ttf");
	setText(&messageText ,font ,"Press Enter to start!" ,75    ,sf::Color::White);
	setText(&scoreText       ,font ,"Score = 0"                  ,100  ,sf::Color::White);
	sf::FloatRect textRect = messageText.getLocalBounds();
	messageText.setOrigin(
		textRect.left  + textRect.width/2.0f,
		textRect.top  + textRect.height/2.0f
	);
	messageText.setPosition(resolution.x/2.0f ,resolution.y/2.0f);
	scoreText.setPosition(20 ,20);
	
	GameObject* objectsToDraw[totalObjects];
	Background background;
	objectsToDraw[objects::background] = &background;
	Tree tree;
	objectsToDraw[objects::tree]              = &tree;
	Bee bee;
	objectsToDraw[objects::bee]              = &bee;
	Player player;
	objectsToDraw[objects::player]          = &player;
	Axe axe;
	objectsToDraw[objects::axe]               = &axe;
	Gravestone gravestone;
	objectsToDraw[objects::gravestone]  = &gravestone;
	Log log;
	objectsToDraw[objects::logOne]         = &log;
	Cloud clouds( NUM_CLOUDS , "Graphics/cloud.png");
	Branches branches( NUM_BRANCHES , "Graphics/branch.png" );
	bool acceptInput = false;
	
	
	sf::SoundBuffer chopBuffer; //Sound
	chopBuffer.loadFromFile("Sounds/chop.wav");
	sf::Sound chop;
	chop.setBuffer(chopBuffer);
	
	sf::SoundBuffer deathBuffer;
	deathBuffer.loadFromFile("Sounds/death.wav");
	sf::Sound death;
	death.setBuffer(deathBuffer);
	
	sf::Music music;
	if( !music.openFromFile( "Sounds/music.ogg" ) ){
		return -1;
	}
	music.setLoop( true );
	music.play();
	
	while( window.isOpen() ){
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
		/*
		******************************
		Draw the scene
		******************************
		*/
		window.clear();
		window.draw( *objectsToDraw[objects::background] );
		window.draw( clouds );
		window.draw( branches );
		for( int i=objects::player  ; i<objects::totalObjects ; i++ ){
			if( objectsToDraw[i]->isVisible() ){
				window.draw( *objectsToDraw[i] );
			}
		}
		window.draw(scoreText);
		window.draw(timeBar);
		if (paused){
			window.draw(messageText);
		}
		window.display();
	}
	return 0;
}

void setText( sf::Text* text ,const sf::Font& font ,const char* someText ,const int size ,const sf::Color& color){
	text->setFont(font);
	text->setString(someText);
	text->setCharacterSize(size);
	text->setFillColor(color);
}
