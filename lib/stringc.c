#include "string.h"

PUBLIC int itoa(char* str, i32 num) {
    int pos = 0;
    int s = 0;
    if (num == 0) {
        str[0] = '0';
        str[1] = 0;
        return 0;
    }

    if (num < 0) {
        str[pos] = '-';
        pos += 1;
        num = -num;
        s = 1;
    }

    while (num > 0) {
        int k = num % 10;
        num /= 10;

        str[pos] = '0' + k;
        pos += 1;
    }

    for (int i = s, j = pos - 1; i < j; ++i, --j) {
        char t = str[i];
        str[i] = str[j];
        str[j] = t;
    }

    str[pos] = 0;

    return 0;
}

PUBLIC int itoa_hex(char* str, i32 num) {
    str[0] = '0';
    str[1] = 'x';
    int pos = 2;
    int s = 2;
    if (num == 0) {
        str[2] = '0';
        str[3] = 0;
        return 0;
    }
    const char hex[] = "0123456789abcdef";
    while (num != 0) {
        int k = num & 0xF;
        num >>= 4;

        str[pos] = hex[k];
        pos += 1;
    }

    for (int i = s, j = pos - 1; i < j; ++i, --j) {
        char t = str[i];
        str[i] = str[j];
        str[j] = t;
    }

    str[pos] = 0;

    return 0;
}

PUBLIC int strcat(char* dst, const char* src) {
    int pos = 0;
    while (dst[pos] != 0) {
        pos += 1;
    }

    for (int pos1 = 0; src[pos1] != 0; ++pos, ++pos1) {
        dst[pos] = src[pos1];
    }
    dst[pos] = 0;
    return 0;
}


PUBLIC int strcpy(char* dst, const char* src) {
    int len = strlen(src);
    memcpy((void*)dst, (void*)src, len + 1);
    return len;
}

PUBLIC int strlen(const char* src) {
    int len = 0;
    while (src[len] != 0) {
        ++len;
    }
    return len;
}