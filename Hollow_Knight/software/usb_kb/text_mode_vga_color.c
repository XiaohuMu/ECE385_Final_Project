/*
 * text_mode_vga_color.c
 * Minimal driver for text mode VGA support
 * This is for Week 2, with color support
 *
 *  Created on: Oct 25, 2021
 *      Author: zuofu
 */

#include <system.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alt_types.h>
#include "text_mode_vga_color.h"

void textVGAColorClr()
{
	for (int i = 0; i<(ROWS*COLUMNS) * 2; i++)
	{
		vga_ctrl->VRAM[i] = 0x00;
		if ( i < 16)
		{
			vga_ctrl->PALETTE[i] = 0x00;
		}

	}
}

// set the VRAM with background,foreground, and characters in str
void textVGADrawColorText(char* str, int x, int y, alt_u8 background, alt_u8 foreground)
{
	int i = 0;
	while (str[i]!=0)
	{
		vga_ctrl->VRAM[(y*COLUMNS + x + i) * 2] = foreground << 4 | background;
		vga_ctrl->VRAM[(y*COLUMNS + x + i) * 2 + 1] = str[i];
		i++;
	}
}

void setColorPalette (alt_u8 color, alt_u8 red, alt_u8 green, alt_u8 blue)
{					// color index	R	G	B
	//fill in this function to set the color palette starting at offset 0x0000 2000 (from base)

	vga_ctrl->PALETTE[color] = red << 8 | green << 4 | blue;
}


void textVGAColorScreenSaver()
{
	//This is the function you call for your week 2 demo
	char color_string[80];
    int fg, bg, x, y;
	textVGAColorClr();
	//initialize palette
	for (int i = 0; i < 16; i++)
	{
		setColorPalette (i, colors[i].red, colors[i].green, colors[i].blue);
	}
	while (1)
	{
		fg = rand() % 16;
		bg = rand() % 16;
		while (fg == bg)
		{
			fg = rand() % 16;
			bg = rand() % 16;
		}
		sprintf(color_string, "Drawing %s text with %s background", colors[fg].name, colors[bg].name);
		x = rand() % (80-strlen(color_string));
		y = rand() % 30;
		textVGADrawColorText (color_string, x, y, bg, fg);
		usleep (100000);
	}
}
//void textVGAColorScreenSaver_single()
//{
//	//This is the function you call for your week 2 demo
//	char color_string[1];
//	textVGAColorClr();
//	//initialize palette
//	for (int i = 0; i < 16; i++)
//	{
//		setColorPalette (i, colors[i].red, colors[i].green, colors[i].blue);
//	}
//	int x = 0;
//	int y = 0;
//	int i = 0;
//	int fg = 10;
//	int bg = 0;
//	while (1)
//	{
//		sprintf(color_string, "%x", i);
//
//		textVGADrawColorText (color_string, x, y, bg, 10);
//		i = i + 1;
//		if (i%16 == 0){
//			i = 0;
//			bg = bg + 1;
//			if(fg == bg){
//				fg = 0;
//			} else {
//				fg = 10;
//			}
//		}
//		x = x + 1;
//		if (x%80 == 0){
//			y = y  + 1;
//		}
//		usleep (5000);
//	}
//
//}
