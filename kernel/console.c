#include "console.h"

#include "const.h"
#include "global.h"
#include "klibc.h"
#include "proto.h"
#include "type.h"

PRIVATE void set_cursor(u32 pos);

PUBLIC void init_screen(TTY* tty) {
    int nr_tty = tty - tty_table;
    tty->p_console = console_table + nr_tty;

    int v_mem_size = V_MEM_SIZE >> 1;

    int con_v_mem_size = v_mem_size / NR_CONSOLES;
    tty->p_console->original_addr = nr_tty * con_v_mem_size;
    tty->p_console->v_mem_limit = con_v_mem_size;
    tty->p_console->current_start_addr = tty->p_console->original_addr;

    tty->p_console->cursor = tty->p_console->original_addr;

    if (nr_tty == 0) {
        tty->p_console->cursor = disp_pos / 2;
        disp_pos = 0;
    } else {
        out_char(tty->p_console, nr_tty + '0');
        out_char(tty->p_console, '#');
    }

    set_cursor(tty->p_console->cursor);
}

PUBLIC void scroll_screen(CONSOLE* con, int direction) {
    /// up指看上方的内容，也就是屏幕本身向下

    if (direction == SCR_UP) {
        con->current_start_addr =
            max(con->current_start_addr - SCREEN_WIDTH, con->original_addr);
        con->cursor =
            min(con->cursor, con->current_start_addr + SCREEN_SIZE - 1);
    }
    if (direction == SCR_DN) {
        con->current_start_addr =
            min(con->current_start_addr + SCREEN_WIDTH,
                con->original_addr + con->v_mem_limit - SCREEN_SIZE);
        con->cursor = max(con->cursor, con->current_start_addr);
    }

    set_video_start_addr(con->current_start_addr);
    set_cursor(con->cursor);
}

PUBLIC int is_current_console(CONSOLE* p_con) {
    return p_con == &console_table[nr_current_console];
}

PUBLIC void out_char(CONSOLE* con, char ch) {
    u8* p_vmem = (u8*)(V_MEM_BASE + con->cursor * 2);

    if (ch == '\n') {
        // 换行
        // 计算当前cursor所在的行
        int row = con->cursor / SCREEN_WIDTH;
        // 行+1
        con->cursor =
            // 保证不超出空间
            min(row + 1, con->v_mem_limit / SCREEN_WIDTH) * SCREEN_WIDTH;
        // 查看是否需要滚屏
        if (con->cursor >= con->current_start_addr + SCREEN_SIZE) {
            scroll_screen(con, SCR_DN);
        }
    } else if (ch == '\b') {
        // 退格，删除光标之前的一项
        if (con->cursor - 1 >= con->original_addr) {
            *(p_vmem - 1) = DEFAULT_CHAR_COLOR;
            *(p_vmem - 2) = ' ';
            con->cursor -= 1;
            if (con->cursor < con->current_start_addr) {
                scroll_screen(con, SCR_UP);
            }
        }
    } else {
        *p_vmem = ch;
        p_vmem += 1;
        *p_vmem = DEFAULT_CHAR_COLOR;
        p_vmem += 1;

        con->cursor += 1;
    }

    disp_pos = (u32)p_vmem - V_MEM_BASE;
    set_cursor(con->cursor);
}

PRIVATE void set_cursor(u32 pos) {
    disable_int();
    out_byte(CRTC_ADDR_REG, CURSOR_H);
    out_byte(CRTC_DATA_REG, (pos >> 8) & 0xFF);
    out_byte(CRTC_ADDR_REG, CURSOR_L);
    out_byte(CRTC_DATA_REG, pos & 0xFF);
    enable_int();
}

PUBLIC void select_console(int nr_console) {
    if (nr_console < 0 || nr_console >= NR_CONSOLES) {
        return;
    }

    nr_current_console = nr_console;
    set_cursor(console_table[nr_console].cursor);
    set_video_start_addr(console_table[nr_console].current_start_addr);
}

PUBLIC void set_video_start_addr(u32 addr) {
    disable_int();
    out_byte(CRTC_ADDR_REG, START_ADDR_H);
    out_byte(CRTC_DATA_REG, (addr >> 8) & 0xFF);
    out_byte(CRTC_ADDR_REG, START_ADDR_L);
    out_byte(CRTC_DATA_REG, addr & 0xFF);
    enable_int();
}
