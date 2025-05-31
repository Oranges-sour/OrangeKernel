#include "klibc.h"

#include "const.h"
#include "global.h"
#include "proto.h"
#include "string.h"
#include "type.h"

void set_disp_pos(u32 w, u32 h) {
    if (w >= VGA_WIDTH) {
        w = VGA_WIDTH - 1;
    }
    if (h >= VGA_HEIGHT) {
        h = VGA_HEIGHT - 1;
    }

    disp_pos = (w * 80 + h) * 2;
}

void disp_int(int val) {
    char temp[32];
    itoa_hex(temp, val);
    disp_str(temp);
}

void delay(int time) {
    for (int i = 0; i < time; ++i) {
        for (int j = 0; j < 50000; ++j) {
        }
    }
}

void disable_irq(int irq) {
    if (irq < 8) {
        out_byte(INT_M_CTLMASK, in_byte(INT_M_CTLMASK) | (1 << irq));
        return;
    }
    out_byte(INT_S_CTLMASK, in_byte(INT_S_CTLMASK) | (1 << irq));
}

void enable_irq(int irq) {
    if (irq < 8) {
        out_byte(INT_M_CTLMASK, in_byte(INT_M_CTLMASK) & ~(1 << irq));
        return;
    }
    out_byte(INT_S_CTLMASK, in_byte(INT_S_CTLMASK) & ~(1 << irq));
}

int min(int a, int b) {
    if (a < b) {
        return a;
    }
    return b;
}
int max(int a, int b) {
    if (a > b) {
        return a;
    }
    return b;
}