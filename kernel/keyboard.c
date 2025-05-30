#include "keyboard.h"

#include "const.h"
#include "global.h"
#include "i8259.h"
#include "keymap.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"
#include "tty.h"

PRIVATE KB_INPUT kb_in;

enum func_key_state {
    // 顺序必须严格与func_key 中的顺序一致！！
    STATE_SHIFT_L,
    STATE_SHIFT_R,
    STATE_CTRL_L,
    STATE_CTRL_R,
    STATE_ALT_L,
    STATE_ALT_R,
    STATE_CAPS_LOCK,
    STATE_NUM_LOCK,
    STATE_SCROLL_LOCK,
    //*******/
    STATE_CODE_WITH_E0
};

// 顺序必须严格与enum func_key_state 中的顺序一致！！
PRIVATE u32 func_key[9] = {SHIFT_L, SHIFT_R,   CTRL_L,   CTRL_R,     ALT_L,
                           ALT_R,   CAPS_LOCK, NUM_LOCK, SCROLL_LOCK};

PRIVATE int kb_state[11] = {};

PRIVATE u8 kb_in_block_read_safe();

PRIVATE int kb_in_try_read_safe(u8* scan_code);

PUBLIC void init_keyboard() {
    memset(kb_state, 0, sizeof(kb_state));

    kb_in_init();

    put_irq_handler(KEYBOARD_IRQ, keyboard_handler);
    enable_irq(KEYBOARD_IRQ);
}

PUBLIC void keyboard_handler(int irq) {
    u8 scan_code = in_byte(0x60);
    kb_in_push(scan_code);
    return;
}

PUBLIC void keyboard_read(TTY* tty) {
    u8 scan_code;

    u32 key = 0;

    int make = FALSE;

    if (!kb_in_try_read_safe(&scan_code)) {
        return;
    }
    if (scan_code == 0xE1) {
        u8 pausebrk_code[6] = {0xE1, 0x1D, 0x45,  //
                               0xE1, 0x9D, 0xC5};
        int pause_break = TRUE;
        for (int step = 1; step < 6; ++step) {
            u8 scan_code = kb_in_block_read_safe();
            if (scan_code != pausebrk_code[step]) {
                pause_break = FALSE;
            }
        }
        if (pause_break) {
            key = PAUSEBREAK;
        }
    } else if (scan_code == 0xE0) {
        scan_code = kb_in_block_read_safe();

        // print_screen 按下
        if (scan_code == 0x2A) {
            if (kb_in_block_read_safe() == 0xE0) {
                if (kb_in_block_read_safe() == 0x37) {
                    key = PRINTSCREEN;
                    make = 1;
                }
            }
        }
        // print_screen 抬起
        if (scan_code == 0xB7) {
            if (kb_in_block_read_safe() == 0xE0) {
                if (kb_in_block_read_safe() == 0xAA) {
                    key = PRINTSCREEN;
                    make = 0;
                }
            }
        }
        /* 不是PrintScreen, 此时scan_code为0xE0紧跟的那个值. */
        if (key == 0) {
            kb_state[STATE_CODE_WITH_E0] = 1;
        }
    }

    if ((key != PAUSEBREAK) && (key != PRINTSCREEN)) {
        /* 首先判断Make Code 还是 Break Code */
        make = (scan_code & FLAG_BREAK ? 0 : 1);

        /* 先定位到 keymap 中的行 */
        u32* keyrow = &keymap[(scan_code & 0x7F) * MAP_COLS];

        int column = 0;
        if (kb_state[STATE_SHIFT_L] || kb_state[STATE_SHIFT_R]) {
            column = 1;
        }
        if (kb_state[STATE_CODE_WITH_E0]) {
            column = 2;
            kb_state[STATE_CODE_WITH_E0] = FALSE;
        }

        key = keyrow[column];

        for (int i = 0; i < 9; ++i) {
            if (key == func_key[i]) {
                kb_state[i] = make;
                key = 0;
                break;
            }
        }
        if (make) {
            key |= kb_state[STATE_SHIFT_L] ? FLAG_SHIFT_L : 0;
            key |= kb_state[STATE_SHIFT_R] ? FLAG_SHIFT_R : 0;
            key |= kb_state[STATE_CTRL_L] ? FLAG_CTRL_L : 0;
            key |= kb_state[STATE_CTRL_R] ? FLAG_CTRL_R : 0;
            key |= kb_state[STATE_ALT_L] ? FLAG_ALT_L : 0;
            key |= kb_state[STATE_ALT_R] ? FLAG_ALT_R : 0;
            keyboard_process(tty, key);
        }
    }
}

PRIVATE int kb_in_try_read_safe(u8* scan_code) {
    if (kb_in_size() > 0) {
        disable_int();
        *scan_code = kb_in_get();
        kb_in_pop();
        enable_int();
        return TRUE;
    }
    return FALSE;
}

PRIVATE u8 kb_in_block_read_safe() {
    while (kb_in_size() <= 0) {
    }

    disable_int();
    u8 scan_code = kb_in_get();
    kb_in_pop();
    enable_int();

    return scan_code;
}

void kb_in_init() {
    kb_in.count = 0;
    kb_in.p_head = kb_in.p_tail = 0;
}

int kb_in_size() { return kb_in.count; }

void kb_in_push(u8 scan_code) {
    // 缓冲区已满
    if (kb_in.count == KB_IN_BYTES) {
        return;
    }

    kb_in.buf[kb_in.p_tail] = scan_code;
    kb_in.p_tail++;
    kb_in.p_tail %= KB_IN_BYTES;
    kb_in.count++;
}

u8 kb_in_get() { return kb_in.buf[kb_in.p_head]; }

void kb_in_pop() {
    if (kb_in.count == 0) {
        return;
    }
    kb_in.p_head++;
    kb_in.p_head %= KB_IN_BYTES;
    kb_in.count--;
}