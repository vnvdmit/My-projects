#include "Engine.hpp"

Engine engine;

int main(){
	try{
		engine.run();
	}
	catch( NoMusic& ex ){
		ex.what();
		exit(1);
	}
	return 0;
}
