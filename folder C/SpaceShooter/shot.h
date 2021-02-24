#ifndef SHOTM_H
#define SHOTM_H

#define SHOTS_N 128

typedef struct SHOT
{
    int x, y, dx, dy;
    int frame;
    bool ship;
    bool used;
} SHOT;

extern SHOT* shots;

void shots_init();
bool shots_add(bool ship, bool straight, int x, int y);
void shots_update();
bool shots_collide(bool ship, int x, int y, int w, int h);
void shots_draw();
void shots_deinit();

#endif