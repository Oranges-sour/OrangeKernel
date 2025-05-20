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
    char temp[16];
    itoa_hex(temp, val);
    disp_str(temp);
}

void delay(int time) {
    for (int i = 0; i < time; ++i) {
        for (int j = 0; j < 50000; ++j) {
        }
    }
}