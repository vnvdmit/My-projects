#include <allegro5/allegro5.h>

#include "game.h"

bool collide(struct Box box1 ,struct Box box2)
{
    if(box1.x1 > box2.x2) return false;
    if(box1.x2 < box2.x1) return false;
    if(box1.y1 > box2.y2) return false;
    if(box1.y2 < box2.y1) return false;

    return true;
}