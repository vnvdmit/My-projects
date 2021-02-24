#include "Player.hpp"

Player::Player()
	:GameObject( "Graphics/player.png" )
{ moveLeft(); }

void Player::moveLeft(){
	playerSide = side::LEFT;
	moveSprite( 580 ,720 );
}

void Player::moveRight(){
	playerSide = side::RIGHT;
	moveSprite( 1200 ,720 );
}

void Player::death(){
	moveSprite( 2000 ,660 );
}

bool Player::collision( side branch ){
	if ( playerSide == branch ){
		return true;
	}
	return false;
}