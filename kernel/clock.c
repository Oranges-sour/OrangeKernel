#include "global.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

void clock_handler(int irq) {
    // disp_str("#");
    static u32 cnt = 0;

    ticks++;

    // 中断重入的情况
    if (k_reenter != 0) {
        disp_str("!");
        return;
    }
    cnt += 1;

    // 每2个中断切换一次
    if (cnt % 2 == 0) {
        p_proc_ready++;
        if (p_proc_ready >= proc_table + NR_TASKS) {
            p_proc_ready = proc_table;
        }
    }

    // delay(1);
}