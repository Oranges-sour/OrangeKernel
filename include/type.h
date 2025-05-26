#ifndef __ORANGES_TYPE_H__
#define __ORANGES_TYPE_H__

typedef unsigned int u32;
typedef int i32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef void (*int_handler)();

typedef void (*irq_handler)(int irq);

typedef void (*task_f)();

typedef void* system_call;

#endif