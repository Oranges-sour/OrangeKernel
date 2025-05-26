#ifndef __GLOBAL_H__
#define __GLOBAL_H__

#include "const.h"
#include "proc.h"
#include "protect.h"
#include "type.h"

extern u32 disp_pos;

extern i32 k_reenter;
/*
GdtPtr dw  GdtLen - 1    ; 段界限 //2byte
       dd BaseOfLoaderPhyAddr + LABEL_GDT ; 基地址 //4byte
*/
extern u8 gdt_ptr[];
extern DESCRIPTOR gdt[];

extern u8 idt_ptr[];
extern GATE idt[];

// 任务状态段信息
extern TSS tss;

// 当前在运行的进程
extern PROCESS* p_proc_ready;

// 进程表
extern PROCESS proc_table[];

// 进程栈
extern char task_stack[];

// 任务表
extern TASK task_table[];

// 中断处理函数表
extern irq_handler irq_table[];

extern int ticks;

#endif