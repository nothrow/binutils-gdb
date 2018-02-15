	.file	"test.cpp"
	.toc
	.csect .text[PR]
	.toc
LC..0:
	.tc _ZTIi[TC],_ZTIi
	.csect .text[PR]
	.align 2
	.globl main
	.globl .main
	.csect main[DS]
main:
	.long .main, TOC[tc0], 0
	.csect .text[PR]
.main:
LFB..0:
	mflr 0
	stw 0,8(1)
	stw 30,-8(1)
	stw 31,-4(1)
	stwu 1,-96(1)
LCFI..0:
	mr 31,1
LCFI..1:
	li 3,4
	bl .__cxa_allocate_exception
	nop
	mr 9,3
	mr 10,9
	li 9,7
	stw 9,0(10)
	li 5,0
	lwz 4,LC..0(2)
	mr 3,10
LEHB..0:
	bl .__cxa_throw
	nop
LEHE..0:
L..6:
	mr 10,3
	mr 9,4
	cmpwi 7,9,1
	beq 7,L..5
	mr 9,10
	mr 3,9
LEHB..1:
	bl ._Unwind_Resume
	nop
LEHE..1:
L..5:
	mr 9,10
	mr 3,9
	bl .__cxa_begin_catch
	nop
	mr 9,3
	lwz 9,0(9)
	stw 9,56(31)
	li 30,0
	bl .__cxa_end_catch
	nop
	mr 9,30
	mr 3,9
	addi 1,31,96
LCFI..2:
	lwz 0,8(1)
	mtlr 0
	lwz 30,-8(1)
	lwz 31,-4(1)
	blr
LT..main:
	.long 0
	.byte 0,9,32,97,128,2,0,1
	.long LT..main-.main
	.short 4
	.byte "main"
	.byte 31
	.align 2
LFE..0:
	.csect .gcc_except_table[RO],0
	.align 2
LLSDA..0:
	.byte	0xff
	.byte	0xbb
	.byte	0x25
	.byte	0x3
	.byte	0x1a
	.vbyte	4,LEHB..0-LFB..0
	.vbyte	4,LEHE..0-LEHB..0
	.vbyte	4,L..6-LFB..0
	.byte	0x1
	.vbyte	4,LEHB..1-LFB..0
	.vbyte	4,LEHE..1-LEHB..1
	.vbyte	4,0
	.byte	0
	.byte	0x1
	.byte	0
	.align 2
	.vbyte	4,LDFCM..0-__gcc_unwind_dbase
	.csect .text[PR]
	.csect _test.ro_[RO],4
	.align 2
	.globl _GLOBAL__F_main
_GLOBAL__F_main:
Lframe..1:
	.vbyte	4,LECIE..1-LSCIE..1
LSCIE..1:
	.vbyte	4,0
	.byte	0x3
	.byte "zPLR"
	.byte 0
	.byte	0x1
	.byte	0x7c
	.byte	0x41
	.byte	0x7
	.byte	0xbb
	.vbyte	4,LDFCM..1-__gcc_unwind_dbase
	.byte	0x1b
	.byte	0x1b
	.byte	0xc
	.byte	0x1
	.byte	0
	.align 2
LECIE..1:
LSFDE..1:
	.vbyte	4,LEFDE..1-LASFDE..1
LASFDE..1:
	.vbyte	4,LASFDE..1-Lframe..1
	.vbyte	4,LFB..0-$
	.vbyte	4,LFE..0-LFB..0
	.byte	0x4
	.vbyte	4,LLSDA..0-$
	.byte	0x4
	.vbyte	4,LCFI..0-LFB..0
	.byte	0xe
	.byte	0x60
	.byte	0x11
	.byte	0x41
	.byte	0x7e
	.byte	0x9e
	.byte	0x2
	.byte	0x9f
	.byte	0x1
	.byte	0x4
	.vbyte	4,LCFI..1-LCFI..0
	.byte	0xd
	.byte	0x1f
	.byte	0x4
	.vbyte	4,LCFI..2-LCFI..1
	.byte	0xc
	.byte	0x1
	.byte	0
	.csect .text[PR]
	.ref Lframe..1
	.csect _test.ro_[RO],4
	.align 2
LEFDE..1:
	.vbyte	4,0
	.csect _test.rw_[RW],4
	.align 2
LDFCM..0:
	.long	_ZTIi
	.align 2
LDFCM..1:
	.long	__gxx_personality_v0
	.csect .text[PR]
_section_.text:
	.csect .data[RW],4
	.long _section_.text
