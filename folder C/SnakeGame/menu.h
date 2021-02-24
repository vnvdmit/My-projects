#ifndef MENU_H
#define MENU_H

#define MENU_ELEMENTS 2

typedef enum
{
	NEW_GAME,
	EXIT,
	TOTAL_MENU_ELEMENTS
} menu_elements;

void menu( int, int );

#endif
