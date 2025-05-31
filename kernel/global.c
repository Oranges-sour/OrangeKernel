#include "console.h"
#include "const.h"
#include "process.h"
#include "protect.h"
#include "proto.h"
#include "tty.h"
#include "type.h"

PUBLIC u32 disp_pos;
/*
GdtPtr dw  GdtLen - 1    ; 段界限 //2byte
       dd BaseOfLoaderPhyAddr + LABEL_GDT ; 基地址 //4byte
*/
PUBLIC u8 gdt_ptr[6];
PUBLIC DESCRIPTOR gdt[GDT_SIZE];

PUBLIC u8 idt_ptr[6];
PUBLIC GATE idt[IDT_SIZE];

PUBLIC TSS tss;
PUBLIC PROCESS* p_proc_ready;

PUBLIC PROCESS proc_table[NR_TASKS + NR_PROCS];

PUBLIC char task_stack[STACK_SIZE_TOTAL];

PUBLIC irq_handler irq_table[NR_IRQ];

PUBLIC i32 k_reenter;

PUBLIC TASK task_table[NR_TASKS] = {
    {task_tty, STACK_SIZE_TASK_TTY, TASK_PRIORITY_HIGH, "task_tty"}};

PUBLIC TASK user_proc_table[NR_PROCS] = {
    {TaskA, STACK_SIZE_TESTA, TASK_PRIORITY_MEDIUM, "TaskA"},
    {TaskB, STACK_SIZE_TESTB, TASK_PRIORITY_MEDIUM, "TaskB"},
    {TaskC, STACK_SIZE_TESTC, TASK_PRIORITY_MEDIUM, "TaskC"}};

PUBLIC system_call sys_call_table[NR_SYS_CALL] = {sys_get_ticks, sys_write};

PUBLIC int ticks;

PUBLIC TTY tty_table[NR_CONSOLES];

PUBLIC CONSOLE console_table[NR_CONSOLES];

PUBLIC int nr_current_console;