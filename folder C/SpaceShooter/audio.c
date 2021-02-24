#include "audio.h"

ALLEGRO_SAMPLE* sample_shot;
ALLEGRO_SAMPLE* sample_explode[2];
ALLEGRO_AUDIO_STREAM* music;

void audio_init()
{
    al_install_audio();
    al_init_acodec_addon();
    al_reserve_samples(128);

    sample_shot = al_load_sample("Audio/shot.flac");
    must_init(sample_shot, "shot sample");

    sample_explode[0] = al_load_sample("Audio/explode1.flac");
    must_init(sample_explode[0], "explode[0] sample");
    sample_explode[1] = al_load_sample("Audio/explode2.flac");
    must_init(sample_explode[1], "explode[1] sample");
	
	music = al_load_audio_stream("Audio/space_light.it", 2, 2048);
	must_init(music ,"music");
	
	al_set_audio_stream_playmode(music, ALLEGRO_PLAYMODE_LOOP);
	al_attach_audio_stream_to_mixer(music, al_get_default_mixer());
}

void audio_deinit()
{
    al_destroy_sample(sample_shot);
    al_destroy_sample(sample_explode[0]);
    al_destroy_sample(sample_explode[1]);
	al_destroy_audio_stream(music);
}