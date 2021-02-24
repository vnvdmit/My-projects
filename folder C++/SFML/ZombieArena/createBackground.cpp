#include "ZombieArena.hpp"

static const int TILE_SIZE     = 50;
static const int TILE_TYPES    =  3;
static const int VERTS_IN_QUAD =  4;

int createBackground( sf::VertexArray& rVa ,sf::IntRect arena ){
	
	int worldWidth  = arena.width/TILE_SIZE;
	int worldHeight = arena.height/TILE_SIZE;
	
	rVa.setPrimitiveType(sf::Quads);                              
	rVa.resize( worldWidth * worldHeight * VERTS_IN_QUAD ); //Size of Vertex array
	
	int currentVertex = 0; //Start with 0-vertex  
	
	for( int w=0 ; w<worldWidth ; w++ ){
		for( int h=0 ; h<worldHeight ; h++ ){
			
			rVa[currentVertex+0].position = 
				sf::Vector2f( w*TILE_SIZE ,h*TILE_SIZE );
			rVa[currentVertex+1].position = 
				sf::Vector2f( w*TILE_SIZE + TILE_SIZE ,h*TILE_SIZE );
			rVa[currentVertex+2].position = 
				sf::Vector2f( w*TILE_SIZE + TILE_SIZE ,h*TILE_SIZE + TILE_SIZE );
			rVa[currentVertex+3].position = 
				sf::Vector2f( w*TILE_SIZE ,h*TILE_SIZE + TILE_SIZE );
			
			if( 0 == h ||                 //Applay texture
				0 == w || 
				(worldHeight-1) == h || 
				(worldWidth-1) == w 
			){
				rVa[currentVertex + 0].texCoords =
					sf::Vector2f(0 ,0 + TILE_TYPES*TILE_SIZE);
				rVa[currentVertex + 1].texCoords =
					sf::Vector2f(TILE_SIZE ,0 + TILE_TYPES*TILE_SIZE);
				rVa[currentVertex + 2].texCoords =
					sf::Vector2f(TILE_SIZE ,TILE_SIZE + TILE_TYPES*TILE_SIZE);
				rVa[currentVertex + 3].texCoords =
					sf::Vector2f(0 ,TILE_SIZE + TILE_TYPES*TILE_SIZE);
			}
			else{
				srand( static_cast<int>(time(0)) + h*w - h);
				int mOrg = (rand() % TILE_TYPES);
				int verticalOffset = mOrg*TILE_SIZE;
				
				rVa[currentVertex + 0].texCoords =
					sf::Vector2f( 0 ,0 + verticalOffset );
				rVa[currentVertex + 1].texCoords =
					sf::Vector2f( TILE_SIZE ,0 + verticalOffset );
				rVa[currentVertex + 2].texCoords =
					sf::Vector2f( TILE_SIZE ,TILE_SIZE + verticalOffset );
				rVa[currentVertex + 3].texCoords =
					sf::Vector2f( 0 ,TILE_SIZE + verticalOffset );
			}
			
			currentVertex += VERTS_IN_QUAD; 
		}
	}
	
	return TILE_SIZE;
}
