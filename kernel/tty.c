#include "global.h"
#include "i8259.h"
#include "keyboard.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

#define TTY_FIRST (tty_table)
#define TTY_END (TTY_FIRST + NR_CONSOLES)

PRIVATE void init_tty(TTY* p_tty);

PRIVATE void tty_buf_push(TTY* tty, u32 key);
PRIVATE int tty_buf_size(TTY* tty);
PRIVATE void tty_buf_pop(TTY* tty);
PRIVATE int tty_buf_get(TTY* tty);

PRIVATE void tty_do_write(TTY* tty);
PRIVATE void tty_do_read(TTY* tty);

PUBLIC void task_tty() {
    TTY* p_tty;

    for (p_tty = TTY_FIRST; p_tty < TTY_END; ++p_tty) {
        init_tty(p_tty);
    }
    select_console(0);

    while (1) {
        for (p_tty = TTY_FIRST; p_tty < TTY_END; ++p_tty) {
            tty_do_read(p_tty);
            tty_do_write(p_tty);
        }
    }
}

PRIVATE void init_tty(TTY* p_tty) {
    p_tty->in_buf_count = 0;
    p_tty->in_buf_head = p_tty->in_buf_tail = 0;

    init_screen(p_tty);
}

PRIVATE void tty_do_write(TTY* tty) {
    if (tty_buf_size(tty) > 0) {
        char ch = tty_buf_get(tty);
        tty_buf_pop(tty);

        out_char(tty->p_console, ch);
    }
}

PRIVATE void tty_do_read(TTY* tty) {
    if (is_current_console(tty->p_console)) {
        keyboard_read(tty);
    }
}

PUBLIC void keyboard_process(TTY* p_tty, u32 key) {
    int raw_code = key & MASK_RAW;
    // 检测是否是功能键(不可以打印)
    if (key & FLAG_EXT) {
        if (raw_code == DOWN) {
            if ((key & FLAG_SHIFT_L) || (key & FLAG_SHIFT_R)) {
                scroll_screen(&console_table[nr_current_console], SCR_DN);
            }
            return;
        }
        if (raw_code == UP) {
            if ((key & FLAG_SHIFT_L) || (key & FLAG_SHIFT_R)) {
                scroll_screen(&console_table[nr_current_console], SCR_UP);
            }
            return;
        }
        if (raw_code == ENTER) {
            tty_buf_push(p_tty, '\n');
            return;
        }
        if (raw_code == BACKSPACE) {
            tty_buf_push(p_tty, '\b');
            return;
        }
        return;
    }
    if (((key & FLAG_CTRL_L) || (key & FLAG_CTRL_R)) &&
        (raw_code >= '1' && raw_code <= '9')) {
        select_console(raw_code - '0' - 1);
        return;
    }

    tty_buf_push(p_tty, key);
}

PUBLIC void tty_write(TTY* tty, const char* buf, int len) {
    for (int i = 0; i < len; ++i) {
        out_char(tty->p_console, buf[i]);
    }
}

PRIVATE void tty_buf_push(TTY* tty, u32 key) {
    if (tty->in_buf_count >= TTY_IN_BYTES) {
        return;
    }
    tty->in_buf[tty->in_buf_tail] = key;
    tty->in_buf_tail += 1;
    tty->in_buf_tail %= TTY_IN_BYTES;
    tty->in_buf_count += 1;
}

PRIVATE int tty_buf_size(TTY* tty) { return tty->in_buf_count; }

PRIVATE void tty_buf_pop(TTY* tty) {
    if (tty->in_buf_count <= 0) {
        return;
    }
    tty->in_buf_head += 1;
    tty->in_buf_head %= TTY_IN_BYTES;
    tty->in_buf_count -= 1;
}

PRIVATE int tty_buf_get(TTY* tty) { return tty->in_buf[tty->in_buf_head]; }