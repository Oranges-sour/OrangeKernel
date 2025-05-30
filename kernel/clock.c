#include "clock.h"

#include "global.h"
#include "i8259.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

PRIVATE void init_8253PIT();

PUBLIC void init_clock() {
    init_8253PIT();

    put_irq_handler(CLOCK_IRQ, clock_handler);
    enable_irq(CLOCK_IRQ);
}

/*初始化8253PIT  计时芯片，调整中断时间*/
PRIVATE void init_8253PIT() {
    out_byte(TIMER_MODE, RATE_GENERATOR);
    // 先低8位，后高8位
    out_byte(TIMER0, (u8)(TIMER_FREQ / TIMER_HZ));
    out_byte(TIMER0, (u8)((TIMER_FREQ / TIMER_HZ) >> 8));
}

PUBLIC void clock_handler(int irq) {
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