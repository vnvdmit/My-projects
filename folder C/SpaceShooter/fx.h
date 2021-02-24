#ifndef FX_H
#define FX_H

#define FX_N 128

typedef struct FX
{
    int x, y;
    int frame;
    bool spark;
    bool used;
} FX;

extern FX* fx;

void fx_init();
void fx_add(bool spark, int x, int y);
void fx_update();
void fx_draw();
void fx_deinit();

#endif