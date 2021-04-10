#ifndef NO_MUSIC_HPP
#define NO_MUSIC_HPP

#include <stdexcept>

class NoMusic : public std::runtime_error{
public:
	NoMusic();
};

#endif