#ifndef __PROTO_H__
#define __PROTO_H__

#include "const.h"
#include "type.h"

enum str_color {
    STR_RED = 12,
    STR_GREEN = 10,
    STR_BLUE = 9,
    STR_YELLOW = 14,
    STR_WHITE = 15
};

// kliba.asm
PUBLIC void out_byte(u16 port, u8 val);
PUBLIC u8 in_byte(u16 port);
PUBLIC void disable_int();
PUBLIC void enable_int();
PUBLIC void disp_str(const char* str);
PUBLIC void disp_color_str(const char* str, u8 color);
PUBLIC u16 get_reg_ss();
PUBLIC u32 get_reg_esp();

// proc.c
PUBLIC int sys_get_ticks();
PUBLIC void schedule();

// kernel.asm
PUBLIC void sys_call();
// syscall.asm
PUBLIC int get_ticks();

//************************************* */

/* main.c */
void TaskA();
void TaskB();
void TaskC();

/* kernel.asm */
void restart();

#endif