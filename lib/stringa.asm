
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                              string.asm
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;                                                       Forrest Yu, 2005
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

BITS   32

[SECTION .text]

; 导出函数
global memcpy
global memset


; ------------------------------------------------------------------------
; void* memcpy(void* es:pDest, void* ds:pSrc, int iSize);
; ------------------------------------------------------------------------
memcpy:
	push ebp
	mov  ebp, esp

	push esi
	push edi
	push ecx

	mov edi, [ebp + 8]  ; Destination
	mov esi, [ebp + 12] ; Source
	mov ecx, [ebp + 16] ; Counter

	cld

	rep movsb

	mov eax, [ebp + 8] ; 返回值

	pop ecx
	pop edi
	pop esi

	mov esp, ebp
	pop ebp
	ret
; memcpy 结束-------------------------------------------------------------


; ------------------------------------------------------------------------
; void* memset(void* es:pDest, int val, int iSize);
; ------------------------------------------------------------------------
memset:
	push ebp
	mov  ebp, esp

	push edi

	mov edi, [ebp + 8]
	mov al,  [ebp + 12]
	mov ecx, [ebp + 16]

	cld

	rep stosb

	mov eax, [ebp + 8]

	pop esi

	mov esp, ebp
	pop ebp
	ret