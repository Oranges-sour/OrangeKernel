#include "const.h"
#include "proc.h"
#include "protect.h"
#include "proto.h"
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

PUBLIC PROCESS proc_table[NR_TASKS];

PUBLIC char task_stack[STACK_SIZE_TOTAL];

PUBLIC irq_handler irq_table[NR_IRQ];

PUBLIC i32 k_reenter;

PUBLIC TASK task_table[NR_TASKS] = {{TaskA, STACK_SIZE_TESTA, "TaskA"},
                                    {TaskB, STACK_SIZE_TESTB, "TaskB"},
                                    {TaskC, STACK_SIZE_TESTC, "TaskC"}};

PUBLIC system_call sys_call_table[NR_SYS_CALL] = {sys_get_ticks};

PUBLIC int ticks;