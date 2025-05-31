%include "sconst.inc"

_NR_get_ticks       equ 0
_NR_write           equ 1
INT_VECTOR_SYS_CALL equ 0x90

global get_ticks
global write

BITS   32
[section .text]

get_ticks:
    push ebp
    mov  ebp, esp

    mov eax, _NR_get_ticks
    int INT_VECTOR_SYS_CALL
    
    pop ebp
    ret

write:
    push ebp
    mov  ebp, esp

    mov  eax, _NR_write
    ; ebx寄存器需要保存
    push ebx

    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    int INT_VECTOR_SYS_CALL

    pop ebx

    pop ebp
    ret