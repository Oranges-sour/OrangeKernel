#ifndef __i8259_H__
#define __i8259_H__

#include "const.h"

PUBLIC void init_8259A();

void put_irq_handler(int irq, irq_handler handler);

#endif