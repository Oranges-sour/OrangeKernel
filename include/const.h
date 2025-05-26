#ifndef __ORANGES_CONST_H__
#define __ORANGES_CONST_H__

/* EXTERN */
#define EXTERN extern /* EXTERN is defined as extern except in global.c */

/* 函数类型 */
#define PUBLIC         /* PUBLIC is the opposite of PRIVATE */
#define PRIVATE static /* PRIVATE x limits the scope of x */

/* Boolean */
#define TRUE 1
#define FALSE 0

/* GDT 和 IDT 中描述符的个数 */
#define GDT_SIZE 128
#define IDT_SIZE 256

/* 权限 */
#define PRIVILEGE_KRNL 0
#define PRIVILEGE_TASK 1
#define PRIVILEGE_USER 3
/* RPL */
#define RPL_KRNL SA_RPL0
#define RPL_TASK SA_RPL1
#define RPL_USER SA_RPL3

/* 8259A interrupt controller ports. */
#define INT_M_CTL                                              \
    0x20 /* I/O port for interrupt controller         <Master> \
          */
#define INT_M_CTLMASK \
    0x21               /* setting bits in this port disables ints   <Master> */
#define INT_S_CTL 0xA0 /* I/O port for second interrupt controller  <Slave> */
#define INT_S_CTLMASK \
    0xA1 /* setting bits in this port disables ints   <Slave>  */

#define NR_IRQ 16

#define TIMER0 0x40
#define TIMER_MODE 0x43
#define RATE_GENERATOR 0x34

#define TIMER_FREQ 1193182L

/*
Hz数不得小于 19Hz
因为计数器是16位的，最大存储值为65535
TIMER_FREQ / 65535 ≈ 18.2 Hz
*/
#define TIMER_HZ 100

#endif