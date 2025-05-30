#include "clock.h"
#include "const.h"
#include "global.h"
#include "i8259.h"
#include "keyboard.h"
#include "klibc.h"
#include "proc.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "type.h"

PRIVATE void init_globals();
PRIVATE void init_tasks();

PUBLIC void kernel_main() {
    disp_str("__kernel main__");

    init_globals();
    init_clock();
    init_keyboard();
    init_tasks();

    disp_str("__on restart__");
    restart();

    while (1) {
    }
}

PRIVATE void init_globals() {
    k_reenter = 0;
    ticks = 0;
}

PRIVATE void init_tasks() {
    int stack_now = STACK_SIZE_TOTAL;
    for (int i = 0; i < NR_TASKS + NR_PROCS; ++i) {
        u8 privilege;
        u8 rpl;
        int eflags;
        TASK* task;
        if (i < NR_TASKS) {
            privilege = PRIVILEGE_TASK;
            rpl = RPL_TASK;
            eflags = 0x1202;
            task = &task_table[i];
        } else {
            privilege = PRIVILEGE_USER;
            rpl = RPL_USER;
            eflags = 0x202;
            task = &user_proc_table[i - NR_TASKS];
        }

        PROCESS* p_proc = &proc_table[i];

        p_proc->ldt_sel = SELECTOR_LDT_FIRST + i * 8;
        memcpy(&p_proc->ldts[0], &gdt[INDEX_FLAT_C], sizeof(DESCRIPTOR));
        p_proc->ldts[0].attr1 = DA_C | privilege << 5;  // change the DPL
        memcpy(&p_proc->ldts[1], &gdt[INDEX_FLAT_RW], sizeof(DESCRIPTOR));
        p_proc->ldts[1].attr1 = DA_DRW | privilege << 5;  // change the DPL

        p_proc->regs.cs = (0 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
        p_proc->regs.ds = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
        p_proc->regs.es = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
        p_proc->regs.fs = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;
        p_proc->regs.ss = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | rpl;

        p_proc->regs.gs = (SELECTOR_KERNEL_GS & SA_RPL_MASK) | rpl;
        p_proc->regs.eip = (u32)(task->initial_eip);
        p_proc->regs.esp = (u32)task_stack + stack_now;
        p_proc->regs.eflags = eflags;

        p_proc->ticks = p_proc->priority = task->priority;
        p_proc->pid = i;
        p_proc->nr_tty = 0;
        strcpy(p_proc->p_name, task->name);

        // 切换到下一个进程的栈
        stack_now -= task->stacksize;
    }

    proc_table[1].nr_tty = 0;
    proc_table[2].nr_tty = 1;
    proc_table[3].nr_tty = 1;

    p_proc_ready = &proc_table[0];
}

void TaskA() {
    while (1) {
        disp_str("A");
        milli_delay(10000);
    }
}

void TaskB() {
    while (1) {
        // disp_str("B");
        milli_delay(10000);
    }
}

void TaskC() {
    while (1) {
        // disp_str("C");
        milli_delay(10000);
    }
}