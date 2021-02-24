#ifndef AUDIO_H
#define AUDIO_H

#include <allegro5/allegro_audio.h>
#include <allegro5/allegro_acodec.h>

#include "game.h"

extern ALLEGRO_SAMPLE* sample_shot;
extern ALLEGRO_SAMPLE* sample_explode[2];
extern ALLEGRO_AUDIO_STREAM* music;

void audio_init();
void audio_deinit();

#endif