#include "Texture holder.hpp"

TextureHolder* TextureHolder::m_s_Instance = nullptr;

TextureHolder::TextureHolder(){
	assert( m_s_Instance == nullptr );
	m_s_Instance = this;
}

sf::Texture& TextureHolder::getTexture( std::string const& filename ){
	auto& m = m_s_Instance->m_Texture;
	
	auto keyValuePair = m.find(filename);
	if( keyValuePair != m.end() ){
		return keyValuePair->second;
	}
	else{
		auto& texture = m[filename];
		texture.loadFromFile(filename);
		
		return texture;
	}
}
