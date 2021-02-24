#include "ZombieArena.hpp" 

static const int zombiesInitial =   5;
static const int bulletsTotal   = 100;

int main(){
	
	TextureHolder holder;
	
	enum class State {
		PAUSED,
		LEVELING_UP,
		GAME_OVER,
		PLAYING
	};
	
	State state = State::GAME_OVER;
	
	sf::Vector2f resolution;
	resolution.x = sf::VideoMode::getDesktopMode().width;
	resolution.y = sf::VideoMode::getDesktopMode().height;
	
	sf::RenderWindow window(
		sf::VideoMode( 
			resolution.x,
			resolution.y
		),
		"Zombie Arena",
		sf::Style::Fullscreen
	);
	
	sf::View mainView(
		sf::FloatRect(
					   0,
					   0,
			resolution.x,
			resolution.y
		)
	);
	
	sf::Clock clock;
	
	sf::Time gameTimeTotal;
	
	sf::Vector2f  mouseWorldPosition;
	sf::Vector2i mouseScreenPosition;
	
	Player player;
	
	sf::IntRect arena;
	
	sf::VertexArray background;
	background.setPrimitiveType(sf::Quads);
	
	sf::Texture textureBackground = 
		TextureHolder::getTexture( "Graphics/background_sheet.png" );
	
	int numZombies;
	int numZombiesAlive;
	Zombie* zombies = nullptr;
	
	Bullet bullets[bulletsTotal];
	int currentBullet =  0;
	int bulletsSpare  = 24;
	int bulletsInClip =  6;
	int clipSize      =  6;
	float fireRate    = 1.0;
	sf::Time lastPressed;
	
	window.setMouseCursorVisible(true);
	sf::Sprite spriteCrosshair;
	sf::Texture textureCrosshair =
		TextureHolder::getTexture("Graphics/crosshair.png");
	spriteCrosshair.setTexture( textureCrosshair );
	spriteCrosshair.setOrigin(25 ,25);
	
	Pickup healthPickup(1);
	Pickup ammoPickup(2);
	
	int score   = 0;
	int hiScore = 0;
	
	sf::Sprite spriteGameOver;
	sf::Texture textureGameOver = 
		TextureHolder::getTexture("Graphics/background.png");
	spriteGameOver.setTexture( textureGameOver );
	spriteGameOver.setPosition(0 ,0);
	
	sf::View hudView( sf::FloatRect(0 ,0 ,resolution.x ,resolution.y) );
	
	sf::Sprite spriteAmmoIcon; 
	sf::Texture textureAmmoIcon =
		TextureHolder::getTexture( "Graphics/ammo_icon.png" );
	spriteAmmoIcon.setTexture( textureAmmoIcon );
	spriteAmmoIcon.setPosition( 20 ,980 );
	
	sf::Font font;
	font.loadFromFile("Fonts/zombiecontrol.ttf");
	
	sf::Text pausedText;
	pausedText.setFont( font );
	pausedText.setCharacterSize( 155 );
	pausedText.setFillColor(sf::Color::White);
	pausedText.setPosition( 400 ,400 );
	pausedText.setString( "Press 'Enter' \n  to continue" );
	
	sf::Text gameOverText;
	gameOverText.setFont( font );
	gameOverText.setCharacterSize( 125 );
	gameOverText.setFillColor(sf::Color::White);
	gameOverText.setPosition( 250 ,850 );
	gameOverText.setString( "Press 'Enter' to play" );
	
	sf::Text levelUpText;
	levelUpText.setFont( font );
	levelUpText.setCharacterSize( 80 );
	levelUpText.setFillColor(sf::Color::White);
	levelUpText.setPosition( 150 ,250 );
	std::stringstream levelUpStream;
	levelUpStream << 
		"1 - Increased rate of fire" <<
		"\n2 - Increased clip size( next reload )" <<
		"\n3 - Increased max health" <<
		"\n4 - Increased run speed" <<
		"\n5 - More and better health pickups" <<
		"\n6 - More and better ammo pickups";
	levelUpText.setString( levelUpStream.str() );
	
	sf::Text ammoText;
	ammoText.setFont( font );
	ammoText.setCharacterSize( 55 );
	ammoText.setFillColor(sf::Color::White);
	ammoText.setPosition( 200 ,980 );
	
	sf::Text scoreText;
	scoreText.setFont( font );
	scoreText.setCharacterSize( 55 );
	scoreText.setFillColor(sf::Color::White);
	scoreText.setPosition( 20 ,0 );
	
	std::ifstream inputFile("gamedata/score.txt");
	if( inputFile.is_open() ){
		inputFile >> hiScore;
		inputFile.close();
	}
	
	sf::Text hiScoreText;
	hiScoreText.setFont( font );
	hiScoreText.setCharacterSize( 55 );
	hiScoreText.setFillColor(sf::Color::White);
	hiScoreText.setPosition( 1400 ,0 );
	std::stringstream s;
	s << "Hi Score :" << hiScore;
	hiScoreText.setString( s.str() );
	
	sf::Text zombiesRemainingText;
	zombiesRemainingText.setFont( font );
	zombiesRemainingText.setCharacterSize( 55 );
	zombiesRemainingText.setFillColor(sf::Color::White);
	zombiesRemainingText.setPosition( 1500 ,980 );
	zombiesRemainingText.setString( "Zombies : 10" );
	
	int wave = 0;
	sf::Text waveText;
	waveText.setFont( font );
	waveText.setCharacterSize( 55 );
	waveText.setFillColor(sf::Color::White);
	waveText.setPosition( 1250 ,980 );
	waveText.setString( "Wave : 0" );
	
	sf::RectangleShape healthBar;
	healthBar.setFillColor( sf::Color::Red );
	healthBar.setPosition( 450 ,980 );
	
	int framesSinceLastHUDUpdate = 0;
	int fpsMeasurementFrameInterval = 1000; //How often update HUD in frames
	
	sf::SoundBuffer hitBuffer;
	hitBuffer.loadFromFile("Audio/hit.wav");
	sf::Sound hit;
	hit.setBuffer( hitBuffer );
	
	sf::SoundBuffer splatBuffer;
	splatBuffer.loadFromFile("Audio/splat.wav");
	sf::Sound splat;
	splat.setBuffer( splatBuffer );
	
	sf::SoundBuffer shootBuffer;
	shootBuffer.loadFromFile("Audio/shoot.wav");
	sf::Sound shoot;
	shoot.setBuffer( shootBuffer );
	
	sf::SoundBuffer reloadBuffer;
	reloadBuffer.loadFromFile("Audio/reload.wav");
	sf::Sound reload;
	reload.setBuffer( reloadBuffer );
	
	sf::SoundBuffer reloadFailedBuffer;
	reloadFailedBuffer.loadFromFile("Audio/reload_failed.wav");
	sf::Sound reloadFailed;
	reloadFailed.setBuffer( reloadFailedBuffer );
	
	sf::SoundBuffer powerupBuffer;
	powerupBuffer.loadFromFile("Audio/powerup.wav");
	sf::Sound powerup;
	powerup.setBuffer( powerupBuffer );
	
	sf::SoundBuffer pickupBuffer;
	pickupBuffer.loadFromFile("Audio/pickup.wav");
	sf::Sound pickup;
	pickup.setBuffer( pickupBuffer );
	
	while( window.isOpen() ){
		
		/*
		************************
		* Handle Input         *
		************************
		*/
	
		sf::Event event;
		while( window.pollEvent(event) ){
			if( event.type == sf::Event::KeyPressed ){
				if( 
					event.key.code == sf::Keyboard::Return
					&& state       == State::PLAYING
				){
					state = State::PAUSED;
				}
				else if( 
					event.key.code == sf::Keyboard::Return
					&& state       == State::PAUSED
				){
					state = State::PLAYING;
					clock.restart();
				}
				else if( 
					event.key.code == sf::Keyboard::Return
					&& state       == State::GAME_OVER
				){
					state = State::LEVELING_UP;
					wave  = 0;
					score = 0;
					
					currentBullet =  0;
					bulletsSpare  = 24;
					bulletsInClip =  6;
					clipSize      =  6;
					fireRate      =  1;
					
					player.resetPlayerStats();
				}
			
				if( state == State::PLAYING ){
					if( event.key.code == sf::Keyboard::R ){ //Reload
						if( bulletsSpare >= clipSize ){
							bulletsInClip = clipSize;
							bulletsSpare -= clipSize;
							reload.play();
						}
						else if( bulletsSpare>0 ){
							bulletsInClip = bulletsSpare;
							bulletsSpare  = 0;
							reload.play();
						}
						else{
							reloadFailed.play();
						}
					}
				}
			}
		}
		
		if( sf::Keyboard::isKeyPressed(sf::Keyboard::Escape) ){
			window.close();
		}
		
		if( state == State::PLAYING ){ //WASD handle
			if( sf::Keyboard::isKeyPressed(sf::Keyboard::W) ){
				player.moveUp();
			}
			else{
				player.stopUp();
			}
			if( sf::Keyboard::isKeyPressed(sf::Keyboard::A) ){
				player.moveLeft();
			}
			else{
				player.stopLeft();
			}
			if( sf::Keyboard::isKeyPressed(sf::Keyboard::S) ){
				player.moveDown();
			}
			else{
				player.stopDown();
			}
			if( sf::Keyboard::isKeyPressed(sf::Keyboard::D) ){
				player.moveRight();
			}
			else{
				player.stopRight();
			}
			
			if( sf::Mouse::isButtonPressed( sf::Mouse::Left ) ){ //Fire bullet
				if( (gameTimeTotal.asMilliseconds() -
					lastPressed.asMilliseconds()
					> 1000/fireRate) && (bulletsInClip > 0)
				){
					bullets[currentBullet].shoot(
						player.getCenter().x,
						player.getCenter().y,
						mouseWorldPosition.x,
						mouseWorldPosition.y
					);
					
					currentBullet++;
					if( currentBullet > bulletsTotal-1 ){
						currentBullet = 0;
					}
					lastPressed = gameTimeTotal;
					shoot.play();
					bulletsInClip--;
				}
			}
		} //End WASD
		
		if( state == State::LEVELING_UP ){
			if( event.key.code == sf::Keyboard::Num1 ){
				fireRate++;
				state = State::PLAYING;
			}
			if( event.key.code == sf::Keyboard::Num2 ){
				clipSize += clipSize;
				state = State::PLAYING;
			}
			if( event.key.code == sf::Keyboard::Num3 ){
				player.upgradeHealth();
				state = State::PLAYING;
			}
			if( event.key.code == sf::Keyboard::Num4 ){
				player.upgradeSpeed();
				state = State::PLAYING;
			}
			if( event.key.code == sf::Keyboard::Num5 ){
				healthPickup.upgrade();
				state = State::PLAYING;
			}
			if( event.key.code == sf::Keyboard::Num6 ){
				ammoPickup.upgrade();
				state = State::PLAYING;
			}
			
			if( state == State::PLAYING ){
				wave++;
				arena.width  = 500*wave;
				arena.height = 500*wave;
				arena.left   =   0;
				arena.top    =   0;
				
				int tileSize = createBackground( background ,arena );
				
				player.spawn(
					arena,
					resolution,
					tileSize
				);
				
				healthPickup.setArena( arena );
				ammoPickup.setArena( arena );
				
				numZombies = zombiesInitial * wave;
				
				delete[] zombies;
				zombies         = createZombieHorde( numZombies ,arena );
				numZombiesAlive = numZombies;
				
				powerup.play();
				
				clock.restart();
			}
		}
		
		/*
		**********************
		* Update the frame   *
		**********************
		*/
		
		if( state == State::PLAYING ){
			sf::Time dt = clock.restart();
			
			gameTimeTotal += dt;
			
			float dtAsSeconds = dt.asSeconds();
			
			mouseScreenPosition = sf::Mouse::getPosition();
			
			mouseWorldPosition = window.mapPixelToCoords(
				sf::Mouse::getPosition(),
				mainView
			);
			
			spriteCrosshair.setPosition( mouseWorldPosition );
			
			player.update( dtAsSeconds ,sf::Mouse::getPosition() );
			
			sf::Vector2f playerPosition( player.getCenter() );
			mainView.setCenter( player.getCenter() );
			
			for( int i=0 ; i<numZombies ; i++ ){
				if( zombies[i].isAlive() ){
					zombies[i].update( dt.asSeconds() ,playerPosition );
				}
			}
			
			for( int i=0 ; i<bulletsTotal ; i++ ){
				if( bullets[i].isInFlight() ){
					bullets[i].update( dt.asSeconds() );
				}
			}
			
			healthPickup.update(dt.asSeconds());
			ammoPickup.update(dt.asSeconds());
			
			for( int i=0 ; i<100 ; i++ ){ //Zombie collide
				for( int j=0 ; j<numZombies ; j++ ){
					if( bullets[i].isInFlight() && zombies[j].isAlive() ){
						if( bullets[i].getPosition().intersects( 
							zombies[j].getPosition() ) 
						){
							bullets[i].stop();
							
							if( zombies[j].hit() ){
								score += 10;
								if( score >= hiScore ){
									hiScore = score;
								}
								numZombiesAlive--;
								if( 0 == numZombiesAlive ){
									state = State::LEVELING_UP;
								}
							}
							splat.play();
						}
					}
				}
			}
			
			for( int i=0 ; i<numZombies ; i++ ){ //Player touched zombie
				if( player.getPosition().intersects(
						zombies[i].getPosition()) && 
					zombies[i].isAlive() 
				){
					if( player.hit( gameTimeTotal ) ){
						hit.play();
					}
					if( player.getHealth()<=0 ){
						state = State::GAME_OVER;
						
						std::ofstream outputFile( "gamedata/score.txt" );
						outputFile << hiScore;
						outputFile.close();
					}
				}
			}
			
			if( player.getPosition().intersects( //Health Pickup touch
				healthPickup.getPosition() ) &&
				healthPickup.isSpawned() 
			
			){
				player.increaseHealthLevel( healthPickup.gotIt() );
				pickup.play();
			}
			
			if( player.getPosition().intersects( //Ammo Pickup touch
				ammoPickup.getPosition() ) &&
				ammoPickup.isSpawned() 
			
			){
				bulletsSpare += ammoPickup.gotIt();
				reload.play();
			}
			
			healthBar.setSize( sf::Vector2f(player.getHealth()*3 ,50) );
			framesSinceLastHUDUpdate++;
			
			if( framesSinceLastHUDUpdate > fpsMeasurementFrameInterval ){ 
				std::stringstream ssAmmo;
				std::stringstream ssScore;
				std::stringstream ssHiScore;
				std::stringstream ssWave;
				std::stringstream ssZombiesAlive;
				
				ssAmmo << bulletsInClip << "/" << bulletsSpare;
				ammoText.setString( ssAmmo.str() );
				
				ssScore << "Score : " << score;
				scoreText.setString( ssScore.str() );
				
				ssHiScore << "Hi Score : " << hiScore;
				hiScoreText.setString( ssHiScore.str() );
				
				ssWave << "Wave : " << wave;
				waveText.setString( ssWave.str() );
				
				ssZombiesAlive << "Zombies : " << numZombiesAlive;
				zombiesRemainingText.setString( ssZombiesAlive.str() );
				
				framesSinceLastHUDUpdate = 0;
			} //End HUD update
			
		}
		
		/*
		**************************
		* Draw the scene         *
		**************************
		*/
		
		if( state == State::PLAYING ){
			window.clear();
			
			window.setView( mainView );
			window.draw( background ,&textureBackground );
			for( int i=0 ; i<numZombies ; i++ ){
				window.draw( zombies[i].getSprite()) ;
			}
			for( int i=0 ; i<100 ; i++ ){
				if( bullets[i].isInFlight() ){
					window.draw( bullets[i].getShape() );
				}
			}
			window.draw( player.getSprite() );
			
			if( ammoPickup.isSpawned() ){
				window.draw( ammoPickup.getSprite() );
			}
			if( healthPickup.isSpawned() ){
				window.draw( healthPickup.getSprite() );
			}
			
			window.draw( spriteCrosshair );
			
			window.setView( hudView );
			window.draw( spriteAmmoIcon );
			window.draw( ammoText );
			window.draw( scoreText );
			window.draw( hiScoreText );
			window.draw( healthBar );
			window.draw( waveText );
			window.draw( zombiesRemainingText );
		}
		
		if( state == State::LEVELING_UP ){
			window.draw( spriteGameOver );
			window.draw( levelUpText );
		}
		if( state == State::PAUSED ){
			window.draw( pausedText );
		}
		if( state == State::GAME_OVER ){
			window.draw( spriteGameOver );
			window.draw( gameOverText );
			window.draw( scoreText );
			window.draw( hiScoreText );
		}
		
		window.display();
		
	}
	
	delete[] zombies;
	
	return 0;
}
