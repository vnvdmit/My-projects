#include "Engine.hpp"

void Engine::draw(){
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