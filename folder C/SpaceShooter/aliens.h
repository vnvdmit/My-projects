#ifndef ALIENSM_H
#define ALIENSM_H

#define ALIENS_N 16

#define ALIENS_BLINK 4

#define BUG_LIFE 4
#define ARROW_LIFE 2
#define THICCBOI_LIFE 4

#define BUG_SCORE 200
#define ARROW_SCORE 150
#define THICCBOI_SCORE 800

#define SCORE_LIMIT_ONE 20000
#define SCORE_LIMIT_TWO 40000

#define BUG_TIMER_TIER_ONE 150
#define BUG_TIMER_TIER_TWO 80
#define BUG_TIMER_TIER_THREE 50

#define ARROW_TIMER_TIER_ONE 80
#define ARROW_TIMER_TIER_TWO 50
#define ARROW_TIMER_TIER_THREE 40

#define THICCBOI_TIMER_TIER_ONE 200
#define THICCBOI_TIMER_TIER_TWO 100
#define THICCBOI_TIMER_TIER_THREE 50

typedef enum ALIEN_TYPE
{
    ALIEN_TYPE_BUG,
    ALIEN_TYPE_ARROW,
    ALIEN_TYPE_THICCBOI,
    ALIEN_TYPE_N
} ALIEN_TYPE;

typedef struct ALIEN
{
    int x, y;
    ALIEN_TYPE type;
    int shot_timer;
    int blink;
    int life;
    bool used;
} ALIEN;

extern ALIEN *aliens;

void aliens_init();
void aliens_update();
void aliens_draw();
void aliens_deinit();

#endif