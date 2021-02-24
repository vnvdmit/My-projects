#ifndef STARS_H
#define STARS_H

#define STARS_N ((BUFFER_W / 2) - 1)

typedef struct STAR
{
    float y;
    float speed;
} STAR;

extern STAR* stars;

void stars_init();
void stars_update();
void stars_draw();
void stars_deinit();

#endif