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
extern u8 gdt_ptr[6];
extern DESCRIPTOR gdt[GDT_SIZE];

extern u8 idt_ptr[6];
extern GATE idt[IDT_SIZE];

extern TSS tss;
extern PROCESS* p_proc_ready;

extern PROCESS proc_table[];
extern char task_stack[];

#endif