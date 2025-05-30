#ifndef __PROCESS_H__
#define __PROCESS_H__

#include "protect.h"
#include "type.h"

// 栈帧  顺序严格不能变
typedef struct s_stackframe {
    u32 gs, fs, es, ds;
    u32 edi, esi;
    u32 ebp, kernel_ebp;
    u32 ebx, edx, ecx, eax;
    u32 retaddr;
    // 发生中断时，cpu自动压栈
    u32 eip, cs;
    u32 eflags, esp, ss;
} STACK_FRAME;

typedef struct s_proc {
    STACK_FRAME regs;

    u16 ldt_sel;

    DESCRIPTOR ldts[LDT_SIZE];
    int ticks;
    int priority;
    u32 pid;
    char p_name[32];

    int nr_tty;

} PROCESS;

typedef struct s_task {
    task_f initial_eip;
    int stacksize;
    int priority;
    char name[32];
} TASK;

/* Number of tasks */
#define NR_TASKS 1
#define NR_PROCS 3

/* stacks of tasks */
#define STACK_SIZE_TESTA 0x8000
#define STACK_SIZE_TESTB 0x8000
#define STACK_SIZE_TESTC 0x8000
#define STACK_SIZE_TASK_TTY 0x8000

#define STACK_SIZE_TOTAL                                      \
    (STACK_SIZE_TESTA + STACK_SIZE_TESTB + STACK_SIZE_TESTC + \
     STACK_SIZE_TASK_TTY)

#define NR_SYS_CALL 2

#define TASK_PRIORITY_LOW 10
#define TASK_PRIORITY_MEDIUM 15
#define TASK_PRIORITY_HIGH 20

#endif