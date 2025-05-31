#include "printf.h"

#include "klibc.h"
#include "proto.h"
#include "string.h"
#include "type.h"

int vsprintf(char* buf, const char* fmt, va_list args);

int printf(const char* fmt, ...) {
    int i;
    char buf[256];

    va_list arg = (va_list)((char*)(&fmt) + 4);
    i = vsprintf(buf, fmt, arg);

    write(buf, i);

    return i;
}

int vsprintf(char* buf, const char* fmt, va_list args) {
    char tmp[256];
    int i = 0, j = 0;
    for (; fmt[i] != 0; ++i) {
        if (fmt[i] != '%') {
            buf[j] = fmt[i];
            j += 1;
            continue;
        }
        // 当前是%，读取下一个
        i += 1;
        if (fmt[i] == 'd') {
            itoa(tmp, *((int*)args));
            args += sizeof(int);
            j += strcpy(buf + j, tmp);
            continue;
        }
        if (fmt[i] == 'x') {
            itoa_hex(tmp, *((int*)args));
            args += sizeof(int);
            j += strcpy(buf + j, tmp);
            continue;
        }
        if (fmt[i] == 's') {
            j += strcpy(buf + j, *((char**)args));
            args += sizeof(char*);
            continue;
        }
        break;
    }
    buf[j] = 0;

    return j;
}