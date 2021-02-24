#pragma once
#include <iostream>
#include <sstream>
#include <fstream>
#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include <SFML/System.hpp>
#include <SFML/Audio.hpp>

#include "Player.hpp"
#include "Texture holder.hpp"
#include "Zombie.hpp"
#include "Bullet.hpp"
#include "Pickup.hpp"

int createBackground( sf::VertexArray& rVa ,sf::IntRect arena );
Zombie* createZombieHorde( int numZombies ,sf::IntRect arena );
