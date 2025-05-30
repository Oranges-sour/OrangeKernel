#include "const.h"
#include "global.h"
#include "klibc.h"
#include "protect.h"
#include "proto.h"
#include "string.h"
#include "type.h"

PUBLIC void cstart() {
    memcpy(&gdt,                            /* New GDT */
           (void*)(*((u32*)(&gdt_ptr[2]))), /* Base  of Old GDT */
           *((u16*)(&gdt_ptr[0])) + 1       /* Limit of Old GDT */
    );
    /* gdt_ptr[6] 共 6 个字节：0~15:Limit  16~47:Base。用作 sgdt/lgdt 的参数。*/
    u16* p_gdt_limit = (u16*)(&gdt_ptr[0]);
    u32* p_gdt_base = (u32*)(&gdt_ptr[2]);
    *p_gdt_limit = GDT_SIZE * sizeof(DESCRIPTOR) - 1;
    *p_gdt_base = (u32)&gdt;

    u16* p_idt_limit = (u16*)(&idt_ptr[0]);
    u32* p_idt_base = (u32*)(&idt_ptr[2]);
    *p_idt_limit = IDT_SIZE * sizeof(GATE) - 1;
    *p_idt_base = (u32)&idt;

    init_protect();

    set_disp_pos(0, 0);
    disp_str("cstart  ends");
}

PUBLIC void testt() {
    // disp_str("now ss esp:");
    // u16 ss;
    // u32 esp;
    // ss = get_reg_ss();
    // esp = get_reg_esp();

    // disp_int(ss);

    // disp_str(" ,");
    // disp_int(esp);
    // disp_str(".");
}


