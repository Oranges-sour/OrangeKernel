#include "global.h"
#include "klibc.h"
#include "proto.h"
#include "string.h"

PUBLIC int sys_get_ticks() {
    disp_str("+");
    return ticks;
}