#include "clock.h"
#include "const.h"
#include "global.h"
#include "i8259.h"
#include "klibc.h"
#include "proc.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "type.h"

PUBLIC void kernel_main() {
    disp_str("kernel_main");

    k_reenter = 0;

    put_irq_handler(0, clock_handler);
    enable_irq(0);

    int stack_now = STACK_SIZE_TOTAL;
    for (int i = 0; i < NR_TASKS; ++i) {
        PROCESS* p_proc = &proc_table[i];

        p_proc->ldt_sel = SELECTOR_LDT_FIRST + i * 8;
        memcpy(&p_proc->ldts[0], &gdt[INDEX_FLAT_C], sizeof(DESCRIPTOR));
        p_proc->ldts[0].attr1 = DA_C | PRIVILEGE_TASK << 5;  // change the DPL
        memcpy(&p_proc->ldts[1], &gdt[INDEX_FLAT_RW], sizeof(DESCRIPTOR));
        p_proc->ldts[1].attr1 = DA_DRW | PRIVILEGE_TASK << 5;  // change the DPL

        p_proc->regs.cs = (0 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | RPL_TASK;
        p_proc->regs.ds = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | RPL_TASK;
        p_proc->regs.es = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | RPL_TASK;
        p_proc->regs.fs = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | RPL_TASK;
        p_proc->regs.ss = (8 & SA_RPL_MASK & SA_TI_MASK) | SA_TIL | RPL_TASK;

        p_proc->regs.gs = (SELECTOR_KERNEL_GS & SA_RPL_MASK) | RPL_TASK;
        p_proc->regs.eip = (u32)(task_table[i].initial_eip);
        p_proc->regs.esp = (u32)task_stack + stack_now;
        p_proc->regs.eflags = 0x1202;  // IF=1, IOPL=1, bit 2 is always 1.

        p_proc->pid = i;
        strcpy(p_proc->p_name, task_table[i].name);
        // 切换到下一个进程的栈
        stack_now -= task_table[i].stacksize;
    }

    p_proc_ready = &proc_table[0];

    disp_str("on restart");
    restart();

    while (1) {
    }
}

void TaskA() {
    while (1) {
        disp_str("A");
        delay(100);
    }
}

void TaskB() {
    while (1) {
        disp_str("B");
        delay(100);
    }
}

void TaskC() {
    while (1) {
        disp_str("C");
        delay(100);
    }
}