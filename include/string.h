#ifndef __STRING_H__
#define __STRING_H__

#include "const.h"
#include "type.h"

PUBLIC void* memcpy(void* pDst, void* pSrc, int iSize);

PUBLIC void* memset(void* dst, int val, int size);

// 字符串 dst += src
PUBLIC int strcat(char* dst, const char* src);

PUBLIC int strcpy(char* dst, const char* src);

PUBLIC int strlen(const char* src);

PUBLIC int itoa(char* str, i32 num);

PUBLIC int itoa_hex(char* str, i32 num);

#endif