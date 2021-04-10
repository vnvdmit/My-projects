#include "Engine.hpp"

const int Engine::NUM_BRANCHES = 6;
const int Engine::NUM_CLOUDS   = 3;

const Res Engine::resolution = { 
	.x = 1920, 
	.y = 1080 
};

const float Engine::AXE_POSITION_LEFT    =  700.0;
const float Engine::AXE_POSITION_RIGHT   = 1075.0;

Engine::Engine()
	: vm(resolution.x, resolution.y) //Video mode
	, window(vm, "Timber!!!", sf::Style::Fullscreen)
	, clouds( NUM_CLOUDS , "Graphics/cloud.png")
	, branches( NUM_BRANCHES , "Graphics/branch.png" )
{
	timeBarStartWidth = 400.0;
	timeBarHeight     =  80.0;
	timeBar.setSize(sf::Vector2f(timeBarStartWidth ,timeBarHeight));
	timeBar.setFillColor(sf::Color::Red);
	timeBar.setPosition((resolution.x/2)-timeBarStartWidth/2 ,980);
	timeRemaining = 6.0f;
	timeBarWidthPerSecond = timeBarStartWidth / timeRemaining;
	paused = true;
	score  =    0;
	
	
	
	font.loadFromFile("Fonts/Komikap.ttf");
	setText(&messageText ,font ,"Press Enter to start!" ,75  ,sf::Color::White);
	setText(&scoreText   ,font ,"Score = 0"             ,100 ,sf::Color::White);
	textRect = messageText.getLocalBounds();
	messageText.setOrigin(
		textRect.left  + textRect.width/2.0f,
		textRect.top  + textRect.height/2.0f
	);
	messageText.setPosition(resolution.x/2.0f ,resolution.y/2.0f);
	scoreText.setPosition(20 ,20);
	
	objectsToDraw[objects::background] =  &background;
	objectsToDraw[objects::tree]       =        &tree;
	objectsToDraw[objects::bee]        =         &bee;
	objectsToDraw[objects::player]     =      &player;
	objectsToDraw[objects::axe]        =         &axe;
	objectsToDraw[objects::gravestone] =  &gravestone;
	objectsToDraw[objects::logOne]     =         &log;
	
	acceptInput = false;
	
	
	 //Sound
	chopBuffer.loadFromFile("Sounds/chop.wav");
	chop.setBuffer(chopBuffer);
	deathBuffer.loadFromFile("Sounds/death.wav");
	death.setBuffer(deathBuffer);
	
	if( !music.openFromFile( "Sounds/music.ogg" ) ){
		throw NoMusic();
	}
	music.setLoop( true );
	music.play();
}

void Engine::run(){
	while( window.isOpen() ){
		input();
		update();
		draw();
	}
}

void Engine::setText( sf::Text* text ,const sf::Font& font ,const char* someText ,const int size ,const sf::Color& color){
	text->setFont(font);
	text->setString(someText);
	text->setCharacterSize(size);
	text->setFillColor(color);
}