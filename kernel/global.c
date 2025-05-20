#include "const.h"
#include "proc.h"
#include "protect.h"
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

PUBLIC i32 k_reenter;