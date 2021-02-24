#pragma once
#include <SFML/Graphics.hpp>
#include <assert.h>
#ifndef TEXTURE_HOLDER_HPP
#define TEXTURE_HOLDER_HPP

class TextureHolder{
public:
	TextureHolder();
	static sf::Texture& getTexture( std::string const& filename );
private:
	std::map<std::string ,sf::Texture> m_Texture;
	static TextureHolder* m_s_Instance;
};

#endif
