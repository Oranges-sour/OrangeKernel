

; 描述符图示

; 图示一
;
;  ------ ┏━━┳━━┓高地址
;         ┃ 7  ┃ 段 ┃
;         ┣━━┫    ┃
;                  基
;  字节 7 ┆    ┆    ┆
;                  址
;         ┣━━┫ ② ┃
;         ┃ 0  ┃    ┃
;  ------ ┣━━╋━━┫
;         ┃ 7  ┃ G  ┃
;         ┣━━╉──┨
;         ┃ 6  ┃ D  ┃
;         ┣━━╉──┨
;         ┃ 5  ┃ 0  ┃
;         ┣━━╉──┨
;         ┃ 4  ┃ AVL┃
;  字节 6 ┣━━╉──┨
;         ┃ 3  ┃    ┃
;         ┣━━┫ 段 ┃
;         ┃ 2  ┃ 界 ┃
;         ┣━━┫ 限 ┃
;         ┃ 1  ┃    ┃
;         ┣━━┫ ② ┃
;         ┃ 0  ┃    ┃
;  ------ ┣━━╋━━┫
;         ┃ 7  ┃ P  ┃
;         ┣━━╉──┨
;         ┃ 6  ┃    ┃
;         ┣━━┫ DPL┃
;         ┃ 5  ┃    ┃
;         ┣━━╉──┨
;         ┃ 4  ┃ S  ┃
;  字节 5 ┣━━╉──┨
;         ┃ 3  ┃    ┃
;         ┣━━┫ T  ┃
;         ┃ 2  ┃ Y  ┃
;         ┣━━┫ P  ┃
;         ┃ 1  ┃ E  ┃
;         ┣━━┫    ┃
;         ┃ 0  ┃    ┃
;  ------ ┣━━╋━━┫
;         ┃ 23 ┃    ┃
;         ┣━━┫    ┃
;         ┃ 22 ┃    ┃
;         ┣━━┫ 段 ┃
;
;   字节  ┆    ┆ 基 ┆
; 2, 3, 4
;         ┣━━┫ 址 ┃
;         ┃ 1  ┃ ① ┃
;         ┣━━┫    ┃
;         ┃ 0  ┃    ┃
;  ------ ┣━━╋━━┫
;         ┃ 15 ┃    ┃
;         ┣━━┫    ┃
;         ┃ 14 ┃    ┃
;         ┣━━┫ 段 ┃
;
; 字节 0,1┆    ┆ 界 ┆
;
;         ┣━━┫ 限 ┃
;         ┃ 1  ┃ ① ┃
;         ┣━━┫    ┃
;         ┃ 0  ┃    ┃
;  ------ ┗━━┻━━┛低地址
;


; 图示二

; 高地址………………………………………………………………………低地址

; |   7   |   6   |   5   |   4   |   3   |   2   |   1   |   0    |
; |7654321076543210765432107654321076543210765432107654321076543210|	<- 共 8 字节
; |--------========--------========--------========--------========|
; ┏━━━┳━━━━━━━┳━━━━━━━━━━━┳━━━━━━━┓
; ┃31..24┃   (见下图)   ┃     段基址(23..0)    ┃ 段界限(15..0)┃
; ┃      ┃              ┃                      ┃              ┃
; ┃ 基址2┃③│②│    ①┃基址1b│   基址1a     ┃    段界限1   ┃
; ┣━━━╋━━━┳━━━╋━━━━━━━━━━━╋━━━━━━━┫
; ┃   %6 ┃  %5  ┃  %4  ┃  %3  ┃     %2       ┃       %1     ┃
; ┗━━━┻━━━┻━━━┻━━━┻━━━━━━━┻━━━━━━━┛
;         │                \_________
;         │                          \__________________
;         │                                             \________________________________________________
;         │                                                                                              \
;         ┏━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┓
;         ┃ 7  ┃ 6  ┃ 5  ┃ 4  ┃ 3  ┃ 2  ┃ 1  ┃ 0  ┃ 7  ┃ 6  ┃ 5  ┃ 4  ┃ 3  ┃ 2  ┃ 1  ┃ 0  ┃
;         ┣━━╋━━╋━━╋━━╋━━┻━━┻━━┻━━╋━━╋━━┻━━╋━━╋━━┻━━┻━━┻━━┫
;         ┃ G  ┃ D  ┃ 0  ┃ AVL┃   段界限 2 (19..16)  ┃  P ┃   DPL    ┃ S  ┃       TYPE           ┃
;         ┣━━┻━━┻━━┻━━╋━━━━━━━━━━━╋━━┻━━━━━┻━━┻━━━━━━━━━━━┫
;         ┃      ③: 属性 2      ┃    ②: 段界限 2      ┃                   ①: 属性1                  ┃
;         ┗━━━━━━━━━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━┛
;       高地址                                                                                          低地址
;
;

; 说明:
;
; (1) P:    存在(Present)位。
;		P=1 表示描述符对地址转换是有效的，或者说该描述符所描述的段存在，即在内存中；
;		P=0 表示描述符对地址转换无效，即该段不存在。使用该描述符进行内存访问时会引起异常。
;
; (2) DPL:  表示描述符特权级(Descriptor Privilege level)，共2位。它规定了所描述段的特权级，用于特权检查，以决定对该段能否访问。 
;
; (3) S:   说明描述符的类型。
;		对于存储段描述符而言，S=1，以区别与系统段描述符和门描述符(S=0)。 
;
; (4) TYPE: 说明存储段描述符所描述的存储段的具体属性。
;
;		 
;	数据段类型	类型值		说明
;			----------------------------------
;			0		只读 
;			1		只读、已访问 
;			2		读/写 
;			3		读/写、已访问 
;			4		只读、向下扩展 
;			5		只读、向下扩展、已访问 
;			6		读/写、向下扩展 
;			7		读/写、向下扩展、已访问 
;
;		
;			类型值		说明
;	代码段类型	----------------------------------
;			8		只执行 
;			9		只执行、已访问 
;			A		执行/读 
;			B		执行/读、已访问 
;			C		只执行、一致码段 
;			D		只执行、一致码段、已访问 
;			E		执行/读、一致码段 
;			F		执行/读、一致码段、已访问 
;
;		
;	系统段类型	类型编码	说明
;			----------------------------------
;			0		<未定义>
;			1		可用286TSS
;			2		LDT
;			3		忙的286TSS
;			4		286调用门
;			5		任务门
;			6		286中断门
;			7		286陷阱门
;			8		未定义
;			9		可用386TSS
;			A		<未定义>
;			B		忙的386TSS
;			C		386调用门
;			D		<未定义>
;			E		386中断门
;			F		386陷阱门
;
; (5) G:    段界限粒度(Granularity)位。
;		G=0 表示界限粒度为字节；
;		G=1 表示界限粒度为4K 字节。
;           注意，界限粒度只对段界限有效，对段基地址无效，段基地址总是以字节为单位。 
;
; (6) D:    D位是一个很特殊的位，在描述可执行段、向下扩展数据段或由SS寄存器寻址的段(通常是堆栈段)的三种描述符中的意义各不相同。 
;           ⑴ 在描述可执行段的描述符中，D位决定了指令使用的地址及操作数所默认的大小。
;		① D=1表示默认情况下指令使用32位地址及32位或8位操作数，这样的代码段也称为32位代码段；
;		② D=0 表示默认情况下，使用16位地址及16位或8位操作数，这样的代码段也称为16位代码段，它与80286兼容。可以使用地址大小前缀和操作数大小前缀分别改变默认的地址或操作数的大小。 
;           ⑵ 在向下扩展数据段的描述符中，D位决定段的上部边界。
;		① D=1表示段的上部界限为4G；
;		② D=0表示段的上部界限为64K，这是为了与80286兼容。 
;           ⑶ 在描述由SS寄存器寻址的段描述符中，D位决定隐式的堆栈访问指令(如PUSH和POP指令)使用何种堆栈指针寄存器。
;		① D=1表示使用32位堆栈指针寄存器ESP；
;		② D=0表示使用16位堆栈指针寄存器SP，这与80286兼容。 
;
; (7) AVL:  软件可利用位。80386对该位的使用未左规定，Intel公司也保证今后开发生产的处理器只要与80386兼容，就不会对该位的使用做任何定义或规定。 
;


;----------------------------------------------------------------------------
; 描述符类型值说明
; 其中:
;       DA_  : Descriptor Attribute
;       D    : 数据段
;       C    : 代码段
;       S    : 系统段
;       R    : 只读
;       RW   : 读写
;       A    : 已访问
;       其它 : 可按照字面意思理解
;----------------------------------------------------------------------------
DA_32       EQU	4000h ; 32 位段
DA_LIMIT_4K EQU	8000h ; 段界限粒度为 4K 字节

DA_DPL0     EQU	  00h ; DPL = 0
DA_DPL1     EQU	  20h ; DPL = 1
DA_DPL2     EQU	  40h ; DPL = 2
DA_DPL3     EQU	  60h ; DPL = 3
;----------------------------------------------------------------------------
; 存储段描述符类型值说明
;----------------------------------------------------------------------------
DA_DR       EQU	90h   ; 存在的只读数据段类型值
DA_DRW      EQU	92h   ; 存在的可读写数据段属性值
DA_DRWA     EQU	93h   ; 存在的已访问可读写数据段类型值
DA_C        EQU	98h   ; 存在的只执行代码段属性值
DA_CR       EQU	9Ah   ; 存在的可执行可读代码段属性值
DA_CCO      EQU	9Ch   ; 存在的只执行一致代码段属性值
DA_CCOR     EQU	9Eh   ; 存在的可执行可读一致代码段属性值
;----------------------------------------------------------------------------
; 系统段描述符类型值说明
;----------------------------------------------------------------------------
DA_LDT      EQU	  82h ; 局部描述符表段类型值
DA_TaskGate EQU	  85h ; 任务门类型值
DA_386TSS   EQU	  89h ; 可用 386 任务状态段类型值
DA_386CGate EQU	  8Ch ; 386 调用门类型值
DA_386IGate EQU	  8Eh ; 386 中断门类型值
DA_386TGate EQU	  8Fh ; 386 陷阱门类型值
;----------------------------------------------------------------------------


; 选择子图示:
;         ┏━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┳━━┓
;         ┃ 15 ┃ 14 ┃ 13 ┃ 12 ┃ 11 ┃ 10 ┃ 9  ┃ 8  ┃ 7  ┃ 6  ┃ 5  ┃ 4  ┃ 3  ┃ 2  ┃ 1  ┃ 0  ┃
;         ┣━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━┻━━╋━━╋━━┻━━┫
;         ┃                                 描述符索引                                 ┃ TI ┃   RPL    ┃
;         ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━┻━━━━━┛
;
; RPL(Requested Privilege Level): 请求特权级，用于特权检查。
;
; TI(Table Indicator): 引用描述符表指示位
;	TI=0 指示从全局描述符表GDT中读取描述符；
;	TI=1 指示从局部描述符表LDT中读取描述符。
;

;----------------------------------------------------------------------------
; 选择子类型值说明
; 其中:
;       SA_  : Selector Attribute

SA_RPL0     EQU	0     ; ┓
SA_RPL1     EQU	1     ; ┣ RPL
SA_RPL2     EQU	2     ; ┃
SA_RPL3     EQU	3     ; ┛

SA_TIG      EQU	0     ; ┓TI
SA_TIL      EQU	4     ; ┛
;----------------------------------------------------------------------------


;----------------------------------------------------------------------------
; 分页机制使用的常量说明
;----------------------------------------------------------------------------
PG_P        EQU	1     ; 页存在属性位
PG_RWR      EQU	0     ; R/W 属性位值, 读/执行
PG_RWW      EQU	2     ; R/W 属性位值, 读/写/执行
PG_USS      EQU	0     ; U/S 属性位值, 系统级
PG_USU      EQU	4     ; U/S 属性位值, 用户级
;----------------------------------------------------------------------------





; 宏 ------------------------------------------------------------------------------------------------------
;
; 描述符
; usage: Descriptor Base, Limit, Attr
;        Base:  dd
;        Limit: dd (low 20 bits available)
;        Attr:  dw (lower 4 bits of higher byte are always 0)
%macro Descriptor 3
	dw %2 & 0FFFFh                         ; 段界限 1				(2 字节)
	dw %1 & 0FFFFh                         ; 段基址 1				(2 字节)
	db (%1 >> 16) & 0FFh                   ; 段基址 2				(1 字节)
	dw ((%2 >> 8) & 0F00h) | (%3 & 0F0FFh) ; 属性 1 + 段界限 2 + 属性 2		(2 字节)
	db (%1 >> 24) & 0FFh                   ; 段基址 3				(1 字节)
%endmacro ; 共 8 字节
;
; 门
; usage: Gate Selector, Offset, DCount, Attr
;        Selector:  dw
;        Offset:    dd
;        DCount:    db
;        Attr:      db
%macro Gate 4
	dw (%2 & 0FFFFh)                     ; 偏移 1				(2 字节)
	dw %1                                ; 选择子				(2 字节)
	dw (%3 & 1Fh) | ((%4 << 8) & 0FF00h) ; 属性					(2 字节)
	dw ((%2 >> 16) & 0FFFFh)             ; 偏移 2				(2 字节)
%endmacro ; 共 8 字节
; ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
