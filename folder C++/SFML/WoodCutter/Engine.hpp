#ifndef ENGINE_HPP
#define ENGINE_HPP

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

#include "NoMusic.hpp"

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

struct Res{
	int x;
	int y;
};

class Engine{
public:
	Engine();
	void run();
private:
	void input();
	void update();
	void draw();
private:
	void setText( sf::Text* text ,const sf::Font& font ,const char* someText ,const int size ,const sf::Color& color);
private:
	sf::Clock            clock;
	sf::RectangleShape timeBar;
	float    timeBarStartWidth;
	float        timeBarHeight;
	
	sf::Time      gameTimeTotal;
	float         timeRemaining;
	float timeBarWidthPerSecond;
	
	bool paused = true;
	
	int score = 0;
	
	sf::Text messageText; //Text manipulation
	sf::Text   scoreText;
	sf::Font        font;
	
	sf::FloatRect textRect;
	
	sf::VideoMode vm;
	sf::RenderWindow window;
	
	GameObject* objectsToDraw[totalObjects];
	Background background;
	
	Tree             tree;
	Bee               bee;
	Player         player;
	Axe               axe;
	Gravestone gravestone;
	Log               log;
	
	Cloud clouds;
	Branches branches;
	
	bool acceptInput;
	
	sf::SoundBuffer chopBuffer;
	sf::Sound             chop;
	
	sf::SoundBuffer deathBuffer;
	sf::Sound             death;
	
	sf::Music music;
private:
	static const int NUM_BRANCHES;
	static const int   NUM_CLOUDS;

	static const Res resolution;

	static const float  AXE_POSITION_LEFT;
	static const float AXE_POSITION_RIGHT;
};

#endif