; 编译链接方法
; $ nasm -f elf kernel.asm -o kernel.o
; $ ld -s kernel.o -o kernel.bin    #‘-s’选项意为“strip all”

%include "sconst.inc"

SELECTOR_KERNEL_CS equ 8

;start.c
extern testt
extern cstart

;main.c
extern kernel_main

;protect.c
extern exception_handler

;i8259.c
extern spurious_irq


;klib
extern disp_str
extern delay

; global.c    .bss
extern gdt_ptr
extern idt_ptr
extern p_proc_ready
extern tss
extern k_reenter
extern irq_table
extern sys_call_table

BITS   32

[SECTION .data]
clock_int_msg db "^", 0

[section .bss]
StackSpace resb 2 * 1024
StackTop:

[section .text]	; 代码在此

global     _start                ; 导出 _start
global     restart
global     sys_call

global     divide_error
global     single_step_exception
global     nmi
global     breakpoint_exception
global     overflow
global     bounds_check
global     inval_opcode
global     copr_not_available
global     double_fault
global     copr_seg_overrun
global     inval_tss
global     segment_not_present
global     stack_exception
global     general_protection
global     page_fault
global     copr_error
global     hwint00
global     hwint01
global     hwint02
global     hwint03
global     hwint04
global     hwint05
global     hwint06
global     hwint07
global     hwint08
global     hwint09
global     hwint10
global     hwint11
global     hwint12
global     hwint13
global     hwint14
global     hwint15


_start:                          ; 跳到这里来的时候，我们假设 gs 指向显存
	
	mov ah,                       0Ch ; 0000: 黑底    1111: 白字
	mov al,                       'O'
	mov [gs:((80 * 1 + 39) * 2)], ax  ; 屏幕第 1 行, 第 39 列。
	
	mov esp, StackTop

	sgdt [gdt_ptr]
	call cstart
	lgdt [gdt_ptr]
	lidt [idt_ptr]

	jmp SELECTOR_KERNEL_CS:csinit

csinit:

	; sti

	xor eax, eax
	mov ax,  SELECTOR_TSS
	ltr ax

	jmp kernel_main


; ====================================================================================
;                                   restart
; ====================================================================================
restart:
	
	mov  esp,                      [p_proc_ready]
	lldt [esp + P_LDT_SEL]
	lea  eax,                      [esp + P_STACKTOP]
	mov  dword [tss + TSS3_S_SP0], eax

restart_reenter:
	dec dword [k_reenter]
	pop gs
	pop fs
	pop es
	pop ds
	popad
	add esp, 4
	iretd


; 发生中断时保存寄存器
save:
	pushad
	push ds
	push es
	push fs
	push gs

	mov dx, ss
	mov ds, dx
	mov es, dx

	mov esi, esp

	inc byte [gs:0]

	inc  dword [k_reenter]
	cmp  dword [k_reenter], 0
	jne  .1
	mov  esp,               StackTop
	push restart
	; 跳转到retaddr所指向的位置
	jmp  [esi + RETADR - P_STACKBASE]
.1:	
	push restart_reenter
	; 跳转到retaddr所指向的位置
	; 此时esi的位置在栈顶,要偏移到retaddr
	jmp  [esi + RETADR - P_STACKBASE]
 
 sys_call:
	call save
	push dword [p_proc_ready]
	sti

	push ecx
	push ebx

	call [sys_call_table + eax * 4]

	add esp, 4*3

	mov [esi + EAXREG - P_STACKBASE], eax
	
	cli

	ret

; 中断和异常 -- 硬件中断
; ---------------------------------
%macro  hwint_master    1
    ;发生中断，栈切换到tss表中的 esp0 位置
	; 根据配置，esp0 指向的其实是PROCESS中的s_stackframe结构体的最高地址
	; 处理器自动压栈
	; u32 eip, cs;
    ; u32 eflags, esp, ss;
	; 此时esp指向retaddr
	; sub  esp, 4
	;通过call save，cpu自动将call save的下一句eip压栈，刚好占据retaddr的位置
	; 因此也不需要 sub esp, 4 了
	call save

	in  al,            INT_M_CTLMASK
	or  al,            (1 << %1)
	out INT_M_CTLMASK, al

	mov al,        EOI
	out INT_M_CTL, al

	sti
	push %1
	call [irq_table + 4 * %1]
	pop  ecx
	cli

	in  al,            INT_M_CTLMASK
	and al,            ~(1 << %1)
	out INT_M_CTLMASK, al

	ret
%endmacro
; ---------------------------------

ALIGN    16
hwint00:    ; Interrupt routine for irq 0 (the clock).
	
    hwint_master 0

ALIGN    16
hwint01:    ; Interrupt routine for irq 1 (keyboard)
        hwint_master 1

ALIGN    16
hwint02:    ; Interrupt routine for irq 2 (cascade!)
        hwint_master 2

ALIGN    16
hwint03:    ; Interrupt routine for irq 3 (second serial)
        hwint_master 3

ALIGN    16
hwint04:    ; Interrupt routine for irq 4 (first serial)
        hwint_master 4

ALIGN    16
hwint05:    ; Interrupt routine for irq 5 (XT winchester)
        hwint_master 5

ALIGN    16
hwint06:    ; Interrupt routine for irq 6 (floppy)
        hwint_master 6

ALIGN    16
hwint07:    ; Interrupt routine for irq 7 (printer)
        hwint_master 7

; ---------------------------------
%macro  hwint_slave     1
        push %1
        call spurious_irq
        add  esp, 4
        hlt
%endmacro
; ---------------------------------

ALIGN    16
hwint08:    ; Interrupt routine for irq 8 (realtime clock).
        hwint_slave 8

ALIGN    16
hwint09:    ; Interrupt routine for irq 9 (irq 2 redirected)
        hwint_slave 9

ALIGN    16
hwint10:    ; Interrupt routine for irq 10
        hwint_slave 10

ALIGN    16
hwint11:    ; Interrupt routine for irq 11
        hwint_slave 11

ALIGN    16
hwint12:    ; Interrupt routine for irq 12
        hwint_slave 12

ALIGN    16
hwint13:    ; Interrupt routine for irq 13 (FPU exception)
        hwint_slave 13

ALIGN    16
hwint14:    ; Interrupt routine for irq 14 (AT winchester)
        hwint_slave 14

ALIGN    16
hwint15:    ; Interrupt routine for irq 15
        hwint_slave 15
	
divide_error:
	push 0xFFFFFFFF
	push 0
	jmp  exception
single_step_exception:
	push 0xFFFFFFFF
	push 1
	jmp  exception
nmi:
	push 0xFFFFFFFF
	push 2
	jmp  exception
breakpoint_exception:
	push 0xFFFFFFFF
	push 3
	jmp  exception
overflow:
	push 0xFFFFFFFF
	push 4
	jmp  exception
bounds_check:
	push 0xFFFFFFFF
	push 5
	jmp  exception
inval_opcode:
	push 0xFFFFFFFF
	push 6
	jmp  exception
copr_not_available:
	push 0xFFFFFFFF
	push 7
	jmp  exception
double_fault:
	push 8
	jmp  exception
copr_seg_overrun:
	push 0xFFFFFFFF
	push 9
	jmp  exception
inval_tss:
	push 10
	jmp  exception
segment_not_present:
	push 11
	jmp  exception
stack_exception:
	push 12
	jmp  exception
general_protection:
	push 13
	jmp  exception
page_fault:
	push 14
	jmp  exception
copr_error:
	push 0xFFFFFFFF
	push 16
	jmp  exception

exception:
	call exception_handler
	add  esp, 4*2

	hlt