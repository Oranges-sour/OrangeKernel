#include "global.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

void clock_handler(int irq) {
    ticks++;
    p_proc_ready->ticks--;
    // 中断重入的情况
    if (k_reenter != 0) {
        // disp_str("!");
        return;
    }

    if (p_proc_ready->ticks > 0) {
        return;
    }

    schedule();
}

PUBLIC void milli_delay(int milli_sec) {
    int t0 = get_ticks();
    /*
    dtick = get_ticks() - t0
    一个ticks过去的毫秒数= 1000 / TIMER_HZ

    则要有 (get_ticks() - t0) * 1000 / TIMER_HZ < milli_sec
    */
    while ((get_ticks() - t0) * 1000 / TIMER_HZ < milli_sec) {
    }
}