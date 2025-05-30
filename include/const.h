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

/* Color */
/*
 * e.g. MAKE_COLOR(BLUE, RED)
 *      MAKE_COLOR(BLACK, RED) | BRIGHT
 *      MAKE_COLOR(BLACK, RED) | BRIGHT | FLASH
 */
#define BLACK 0x0                /* 0000 */
#define WHITE 0x7                /* 0111 */
#define RED 0x4                  /* 0100 */
#define GREEN 0x2                /* 0010 */
#define BLUE 0x1                 /* 0001 */
#define FLASH 0x80               /* 1000 0000 */
#define BRIGHT 0x08              /* 0000 1000 */
#define MAKE_COLOR(x, y) (x | y) /* MAKE_COLOR(Background,Foreground) */

/* VGA */
#define CRTC_ADDR_REG 0x3D4 /* CRT Controller Registers - Addr Register */
#define CRTC_DATA_REG 0x3D5 /* CRT Controller Registers - Data Register */
#define START_ADDR_H 0xC    /* reg index of video mem start addr (MSB) */
#define START_ADDR_L 0xD    /* reg index of video mem start addr (LSB) */
#define CURSOR_H 0xE        /* reg index of cursor position (MSB) */
#define CURSOR_L 0xF        /* reg index of cursor position (LSB) */
#define V_MEM_BASE 0xB8000  /* base of color video memory */
#define V_MEM_SIZE 0x8000   /* 32K: B8000H -> BFFFFH */

/* Hardware interrupts */
#define NR_IRQ 16 /* Number of IRQs */
#define CLOCK_IRQ 0
#define KEYBOARD_IRQ 1
#define CASCADE_IRQ 2   /* cascade enable for 2nd AT controller */
#define ETHER_IRQ 3     /* default ethernet interrupt vector */
#define SECONDARY_IRQ 3 /* RS232 interrupt vector for port 2 */
#define RS232_IRQ 4     /* RS232 interrupt vector for port 1 */
#define XT_WINI_IRQ 5   /* xt winchester */
#define FLOPPY_IRQ 6    /* floppy disk */
#define PRINTER_IRQ 7
#define AT_WINI_IRQ 14 /* at winchester */

/*tty*/
#define NR_CONSOLES 3


#endif