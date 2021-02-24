#ifndef HUD_H
#define HUD_H

#include <allegro5/allegro_font.h>

#define BLINK 30
#define BLINK_LEVEL 15

extern ALLEGRO_FONT* font;
extern long score_display;

void hud_init();
void hud_deinit();
void hud_update();
void hud_draw();

#endif