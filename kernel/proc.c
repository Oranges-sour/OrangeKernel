#include "global.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

PUBLIC int sys_get_ticks() { return ticks; }

PUBLIC void schedule() {
    int greatest_ticks = 0;
    while (greatest_ticks == 0) {
        // 让当前ticks最大的进程获得执行
        for (int i = 0; i < NR_TASKS + NR_PROCS; ++i) {
            if (proc_table[i].ticks > greatest_ticks) {
                greatest_ticks = proc_table[i].ticks;
                p_proc_ready = &proc_table[i];
            }
        }

        // 如果进程的ticks都为0了，则执行了一整轮，重置ticks
        if (greatest_ticks == 0) {
            for (int i = 0; i < NR_TASKS + NR_PROCS; ++i) {
                proc_table[i].ticks = proc_table[i].priority;
            }
        }
    }
}