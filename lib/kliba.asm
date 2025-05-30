
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                              klib.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                       Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

extern disp_pos

[SECTION .text]

; 导出函数
global disp_str
global disp_color_str
global out_byte
global in_byte
global disable_int
global enable_int
global get_reg_ss
global get_reg_esp

; ========================================================================
;                  void disp_str(char * info);
; ========================================================================
disp_str:
	push ebp
	mov  ebp, esp

	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]  ; pszInfo
	mov edi, [disp_pos]
	mov ah,  0Fh
	cld
.1:
	lodsb
	test al,  al
	jz   .2
	cmp  al,  0Ah  ; 是回车吗?
	jnz  .3
	push eax
	mov  eax, edi
	mov  bl,  160
	div  bl
	and  eax, 0FFh
	inc  eax
	mov  bl,  160
	mul  bl
	mov  edi, eax
	pop  eax
	jmp  .1
.3:
	mov [gs:edi], ax
	add edi,      2
	jmp .1

.2:
	mov [disp_pos], edi

	pop ebx
	pop edi
	pop esi

	mov esp, ebp
	pop ebp
	ret

; ========================================================================
;                  void disp_color_str(char * info, u8 color);
; ========================================================================
disp_color_str:
	push ebp
	mov  ebp, esp

	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]  ; pszInfo
	mov edi, [disp_pos]
	mov ah,  [ebp + 12]
	cld
.1:
	lodsb
	test al,  al
	jz   .2
	cmp  al,  0Ah  ; 是回车吗?
	jnz  .3
	push eax
	mov  eax, edi
	mov  bl,  160
	div  bl
	and  eax, 0FFh
	inc  eax
	mov  bl,  160
	mul  bl
	mov  edi, eax
	pop  eax
	jmp  .1
.3:
	mov [gs:edi], ax
	add edi,      2
	jmp .1

.2:
	mov [disp_pos], edi


	pop ebx
	pop edi
	pop esi

	mov esp, ebp
	pop ebp
	ret

; ========================================================================
;                  void out_byte(u16 port, u8 value);
; ========================================================================
out_byte:
	mov edx, [esp + 4]
	mov al,  [esp + 4 + 4]
	out dx,  al
	nop
	nop
	ret


; ========================================================================
;                  u8 out_byte(u16 port);
; ========================================================================
in_byte:
	mov edx, [esp + 4]
	xor eax, eax
	in  al,  dx
	nop
	nop
	ret

disable_int:
	cli
	ret

enable_int:
	sti
	ret

; u16 get_reg_ss();
get_reg_ss:
	xor eax, eax
	mov ax,  ss
	ret

; u32 get_reg_ss();
get_reg_esp:
	xor eax, eax
	mov eax, esp
	ret