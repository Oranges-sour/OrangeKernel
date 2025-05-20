#ifndef __KLIBC_H__
#define __KLIBC_H__

#include "type.h"

#define VGA_WIDTH 25
#define VGA_HEIGHT 80

void set_disp_pos(u32 w, u32 h);

void disp_int(int val);

void delay(int time);

#endif