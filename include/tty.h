#ifndef __TTY_H__
#define __TTY_H__

#include "type.h"

#define TTY_IN_BYTES 256

struct s_console;

typedef struct s_tty {
    u32 in_buf[TTY_IN_BYTES];

    int in_buf_head;
    int in_buf_tail;
    int in_buf_count;

    struct s_console* p_console;
} TTY;

void task_tty();

void keyboard_process(TTY* tty, u32 key);

void tty_write(TTY* tty, const char* buf, int len);

#endif