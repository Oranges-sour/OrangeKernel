#ifndef __CONSOLE_H__
#define __CONSOLE_H__

#include "tty.h"
#include "type.h"

// up指看上方的内容，也就是屏幕本身向下
#define SCR_UP 1 /* scroll forward */

// down指看下方的内容，也就是屏幕本身向上
#define SCR_DN -1 /* scroll backward */

#define SCREEN_SIZE (80 * 25)
#define SCREEN_WIDTH 80

#define DEFAULT_CHAR_COLOR 0x07

typedef struct s_console {
    u32 current_start_addr;
    u32 original_addr;

    //显示空间的总内存大小，以word记
    u32 v_mem_limit;
    u32 cursor;
} CONSOLE;

int is_current_console(CONSOLE* p_con);

void out_char(CONSOLE* con, char ch);

void init_screen(TTY* tty);

void set_video_start_addr(u32 addr);

void select_console(int nr_console);

void scroll_screen(CONSOLE* con, int direction);

#endif