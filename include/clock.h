#ifndef __CLOCK_H__
#define __CLOCK_H__

void init_clock();

void clock_handler(int irq);

void milli_delay(int milli_sec);

#endif