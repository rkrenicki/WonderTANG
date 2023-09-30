;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.14 #14046 (MINGW64)
;--------------------------------------------------------
	.module smram
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _runROM_end
	.globl _runROM
	.globl _copyandrun_end
	.globl _copyandrun
	.globl _jump
	.globl _dos2_getenv
	.globl _dos2_read
	.globl _dos2_close
	.globl _dos2_open
	.globl _chgcpu
	.globl _rdslt
	.globl _enaslt
	.globl _to_upper
	.globl _fputs
	.globl _bdos_c_rawio
	.globl _bdos_c_write
	.globl _bdos
	.globl _puts
	.globl _printf
	.globl _cpumode
	.globl _presAB
	.globl _megaram_type
	.globl _filename
	.globl _found
	.globl _path
	.globl _slotid
	.globl _romsize
	.globl _page
	.globl _addr
	.globl _i
	.globl _bytes_read
	.globl _handle
	.globl _params
	.globl _t
	.globl _s
	.globl _b
	.globl _sslt
	.globl _cursslt
	.globl _curslt
	.globl _putchar
	.globl _getchar
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_MEGA_PORT0	=	0x008e
_MEGA_PORT1	=	0x008f
_PPIA	=	0x00a8
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_curslt::
	.ds 1
_cursslt::
	.ds 1
_sslt::
	.ds 1
_b::
	.ds 1
_s::
	.ds 2
_t::
	.ds 2
_params::
	.ds 2
_handle::
	.ds 1
_bytes_read::
	.ds 2
_i::
	.ds 2
_addr::
	.ds 2
_page::
	.ds 1
_romsize::
	.ds 4
_slotid::
	.ds 1
_path::
	.ds 256
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_found::
	.ds 1
_filename::
	.ds 2
_megaram_type::
	.ds 2
_presAB::
	.ds 1
_cpumode::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;smram.c:34: void bdos() __naked
;	---------------------------------
; Function bdos
; ---------------------------------
_bdos::
;smram.c:43: __endasm;
	push	ix
	push	iy
	call	5
	pop	iy
	pop	ix
	ret
;smram.c:44: }
;smram.c:46: void bdos_c_write(uchar c) __naked
;	---------------------------------
; Function bdos_c_write
; ---------------------------------
_bdos_c_write::
;smram.c:56: __endasm;
	ld	e,a
	ld	c,#2
	call	_bdos
	ret
;smram.c:57: }
;smram.c:59: uchar bdos_c_rawio() __naked
;	---------------------------------
; Function bdos_c_rawio
; ---------------------------------
_bdos_c_rawio::
;smram.c:68: __endasm;
	ld	e,#0xFF;
	ld	c,#6
	call	_bdos
	ret
;smram.c:69: }
;smram.c:71: int putchar(int c) 
;	---------------------------------
; Function putchar
; ---------------------------------
_putchar::
	ex	de, hl
;smram.c:73: if (c >= 0)
	bit	7, d
	ret	NZ
;smram.c:74: bdos_c_write((char)c);
	ld	c, e
	push	de
	ld	a, c
	call	_bdos_c_write
	pop	de
;smram.c:75: return c;
;smram.c:76: }
	ret
;smram.c:78: int getchar()
;	---------------------------------
; Function getchar
; ---------------------------------
_getchar::
;smram.c:81: do {
00101$:
;smram.c:82: c = bdos_c_rawio();
	call	_bdos_c_rawio
	ld	e, a
;smram.c:83: } while(c == 0);
	or	a, a
	jr	Z, 00101$
;smram.c:84: return (int)c;
	ld	d, #0x00
;smram.c:85: }
	ret
;smram.c:87: void fputs(const char *s)
;	---------------------------------
; Function fputs
; ---------------------------------
_fputs::
	ex	de, hl
;smram.c:89: while(*s != NULL)
00101$:
	ld	a, (de)
	or	a, a
	ret	Z
;smram.c:90: putchar(*s++);
	inc	de
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	push	de
	call	_putchar
	pop	de
;smram.c:91: }
	jr	00101$
;smram.c:93: char to_upper(char c)
;	---------------------------------
; Function to_upper
; ---------------------------------
_to_upper::
;smram.c:95: if (c >= 'a' && c <= 'z')
	ld	c, a
	sub	a, #0x61
	jr	C, 00102$
	ld	a, #0x7a
	sub	a, c
	jr	C, 00102$
;smram.c:96: c = c - ('a'-'A');
	ld	a, c
	add	a, #0xe0
	ld	c, a
00102$:
;smram.c:97: return c;
	ld	a, c
;smram.c:98: }
	ret
;smram.c:100: void enaslt(uchar slotid, uint addr) __naked
;	---------------------------------
; Function enaslt
; ---------------------------------
_enaslt::
;smram.c:122: __endasm;
	push	af
	push	bc
	push	de
	push	hl
	push	ix
	push	iy
	ex	de,hl
	call	#0x0024
	pop	iy
	pop	ix
	pop	hl
	pop	de
	pop	bc
	pop	af
	ret
;smram.c:123: }
;smram.c:125: uchar rdslt(uchar slotid, uint addr) __naked
;	---------------------------------
; Function rdslt
; ---------------------------------
_rdslt::
;smram.c:140: __endasm;
	push	bc
	push	de
	ex	de,hl
	call	#0x000C
	ex	de,hl
	pop	de
	pop	bc
	ret
;smram.c:141: }
;smram.c:143: void chgcpu(uchar mode) __naked
;	---------------------------------
; Function chgcpu
; ---------------------------------
_chgcpu::
;smram.c:173: __endasm;
	push	bc
	push	de
	push	af
	ld	a,(0xFCC1)
	ld	hl,#0x0180
	call	#0x000C
	cp	#0xC3
	jr	nz,__no_turbo
	ld	a,b
	pop	af
	ld	iy,(0xFCC1 -1)
	ld	ix,#0x0180
	call	#0x001C
	push	af
__no_turbo:
	pop	af
	pop	de
	pop	bc
	ret
;smram.c:174: }
;smram.c:191: FHANDLE dos2_open(uchar mode, const char* filepath) __naked
;	---------------------------------
; Function dos2_open
; ---------------------------------
_dos2_open::
;smram.c:209: __endasm;
	push	bc
	push	de
	push	hl
	ld	c,#0x43
	call	5
	or	a
	jr	z,__open_no_err
	ld	b,#0
__open_no_err:
	ld	a,b
	pop	hl
	pop	de
	pop	bc
	ret
;smram.c:210: }
;smram.c:212: void dos2_close(FHANDLE hnd) __naked
;	---------------------------------
; Function dos2_close
; ---------------------------------
_dos2_close::
;smram.c:222: __endasm;
	push	bc
	ld	a,b
	ld	c,#0x45
	call	5
	pop	bc
	ret
;smram.c:223: }
;smram.c:225: uint dos2_read(FHANDLE hnd, void *dst, uint size) __naked
;	---------------------------------
; Function dos2_read
; ---------------------------------
_dos2_read::
;smram.c:245: __endasm;	
	push	ix
	ld	ix,#0
	add	ix,sp
	push	bc
	ld	b,a
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	c,#0x48
	call	5
	pop	bc
	pop	ix
	ex	de,hl
	ret
;smram.c:246: }
;smram.c:248: uchar dos2_getenv(char *var, char *buf) __naked
;	---------------------------------
; Function dos2_getenv
; ---------------------------------
_dos2_getenv::
;smram.c:256: __endasm;	
	ld	b,#255
	ld	c,#0x6B
	call	5
	ret
;smram.c:257: }
;smram.c:259: void jump(uint addr) __naked
;	---------------------------------
; Function jump
; ---------------------------------
_jump::
;smram.c:267: __endasm;
	ld	sp,(#__himem)
	jp	(hl)
;smram.c:268: }
;smram.c:270: void copyandrun() __naked
;	---------------------------------
; Function copyandrun
; ---------------------------------
_copyandrun::
;smram.c:282: __endasm;
	ld	bc,#0x4000
	or	a
	sbc	hl,bc
	ld	b,h
	ld	c,l
	ld	hl,#0x4000
	ld	de,#0x0100
	ldir
	jp	0x0100
;smram.c:283: }
;smram.c:285: void copyandrun_end() __naked {}
;	---------------------------------
; Function copyandrun_end
; ---------------------------------
_copyandrun_end::
;smram.c:287: void runROM() __naked
;	---------------------------------
; Function runROM
; ---------------------------------
_runROM::
;smram.c:303: __endasm;
	di
	ld	sp,#0xCFFF
	ld	hl,#0xFD9A
	ld	a,#0xC9
	ld	(hl),a
	ld	hl,#0xFD9F
	ld	(hl),a
	ld	a,(0xFCC1)
	ld	hl,#0
	call	#0x0024
	ld	hl,(0x4002)
	jp	(hl)
;smram.c:304: }
;smram.c:306: void runROM_end() __naked {}
;	---------------------------------
; Function runROM_end
; ---------------------------------
_runROM_end::
;smram.c:326: int main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	call	___sdcc_enter_ix
	push	af
;smram.c:328: curslt = (PPIA & 0x0C) >> 2;
	in	a, (_PPIA)
	and	a, #0x0c
	ld	c, a
	ld	b, #0x00
	sra	b
	rr	c
	sra	b
	rr	c
	ld	hl, #_curslt
	ld	(hl), c
;smram.c:329: cursslt = (~(*((uchar*)0xFFFF)) & 0x0C) | *((uchar*)EXPTBL+curslt);
	ld	a, (#0xffff)
	cpl
	and	a, #0x0c
	ld	c, a
	ld	hl, (_curslt)
	ld	h, #0x00
	ld	de, #0xfcc1
	add	hl, de
	ld	a, (hl)
	or	a, c
	ld	(_cursslt+0), a
;smram.c:331: for(i = 1; i < 4; i++)
	ld	hl, #0x0001
	ld	(_i), hl
00196$:
;smram.c:333: slotid = *((uchar*)EXPTBL+i);
	ld	hl, (_i)
	ld	de, #0xfcc1
	add	hl, de
	ld	a, (hl)
	ld	(_slotid+0), a
;smram.c:335: if (slotid & 0x80) {    // expanded ?
	ld	a, (_slotid+0)
	rlca
	jr	NC, 00197$
;smram.c:337: enaslt(i | 0x80, 0x4000); // looking for BIOS, sslot 0
	ld	a, (_i+0)
	or	a, #0x80
	ld	de, #0x4000
	call	_enaslt
;smram.c:339: b = *(uchar*)(0x6000); // it might be RAM
	ld	a, (#0x6000)
	ld	(_b+0), a
;smram.c:340: *((uchar*)0x6000) = 7;
	ld	hl, #0x6000
	ld	(hl), #0x07
;smram.c:341: s = "WonderTANG! uSD Driver";
	ld	iy, #_s
	ld	0 (iy), #<(___str_0)
	ld	1 (iy), #>(___str_0)
;smram.c:342: t = (uchar*)0x4110;
	ld	hl, #0x4110
	ld	(_t), hl
;smram.c:343: for(int j=0; j<22; j++)
	ld	bc, #0x0000
00194$:
	ld	a, c
	sub	a, #0x16
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00105$
;smram.c:345: if (*s++ != *t++) break;
	ld	hl, (_s)
	ld	e, (hl)
	ld	hl, (_s)
	inc	hl
	ld	(_s), hl
	ld	hl, (_t)
	ld	d, (hl)
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
	ld	a, e
	sub	a, d
	jr	NZ, 00105$
;smram.c:347: if (j == 21) 
	ld	a, c
	sub	a, #0x15
	or	a, b
	jr	NZ, 00195$
;smram.c:349: found = TRUE;
	ld	hl, #_found
	ld	(hl), #0x01
;smram.c:350: break;
	jr	00105$
00195$:
;smram.c:343: for(int j=0; j<22; j++)
	inc	bc
	jr	00194$
00105$:
;smram.c:354: *((uchar*)0x6000) = b; // return whatever was there
	ld	hl, #0x6000
	ld	a, (_b+0)
	ld	(hl), a
;smram.c:356: enaslt(curslt | cursslt, 0x4000);
	ld	a, (_curslt+0)
	ld	hl, #_cursslt
	or	a, (hl)
	ld	de, #0x4000
	call	_enaslt
;smram.c:358: if (found) break;
	ld	a, (_found+0)
	or	a, a
	jr	NZ, 00110$
00197$:
;smram.c:331: for(i = 1; i < 4; i++)
	ld	hl, (_i)
	inc	hl
	ld	(_i), hl
	ld	a, (_i+0)
	sub	a, #0x04
	ld	a, (_i+1)
	rla
	ccf
	rra
	sbc	a, #0x80
	jp	C, 00196$
00110$:
;smram.c:364: sslt = 0;
	ld	hl, #_sslt
	ld	(hl), #0x00
;smram.c:366: if (found)
	ld	a, (_found+0)
	or	a, a
	jp	Z, 00150$
;smram.c:368: printf("WonderTANG! Super MegaRAM SCC+\r\n");
	ld	hl, #___str_2
	call	_puts
;smram.c:370: sslt = 0x80 | (2 << 2) | i;
	ld	a, (_i+0)
	or	a, #0x88
	ld	(_sslt+0), a
;smram.c:372: for(params = (char*)0x81; *params != 0; ++params)
	ld	hl, #0x0081
	ld	(_params), hl
00199$:
	ld	bc, (_params)
	ld	a, (bc)
	or	a, a
	jp	Z, 00151$
;smram.c:374: if (*params != ' ')
	cp	a, #0x20
	jp	Z,00200$
;smram.c:376: if (*params == '/')
	sub	a, #0x2f
	jp	NZ,00144$
;smram.c:378: params++;
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
;smram.c:379: if (to_upper(*params) == 'R') {
	ld	hl, (_params)
	ld	a, (hl)
	call	_to_upper
	sub	a, #0x52
	jr	NZ, 00137$
;smram.c:380: params++;
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
;smram.c:372: for(params = (char*)0x81; *params != 0; ++params)
	ld	hl, (_params)
	ld	a, (hl)
;smram.c:381: if (*params == '6')
	cp	a, #0x36
	jr	NZ, 00121$
;smram.c:382: megaram_type = TYPE_K4;
	ld	hl, #0x0000
	ld	(_megaram_type), hl
	jp	00200$
00121$:
;smram.c:384: if (*params == '5')
	cp	a, #0x35
	jr	NZ, 00118$
;smram.c:385: megaram_type = TYPE_K5;
	ld	hl, #0x0005
	ld	(_megaram_type), hl
	jp	00200$
00118$:
;smram.c:387: if (*params == '1')
	cp	a, #0x31
	jr	NZ, 00115$
;smram.c:388: megaram_type = TYPE_A16;
	ld	hl, #0x0016
	ld	(_megaram_type), hl
	jp	00200$
00115$:
;smram.c:390: if (*params == '3')
	sub	a, #0x33
	jr	NZ, 00112$
;smram.c:391: megaram_type = TYPE_A8;
	ld	hl, #0x0008
	ld	(_megaram_type), hl
	jp	00200$
00112$:
;smram.c:393: megaram_type = TYPE_UNK;                    
	ld	hl, #0x00ff
	ld	(_megaram_type), hl
	jr	00200$
00137$:
;smram.c:395: else if (to_upper(*params) == 'Y')
	ld	hl, (_params)
	ld	a, (hl)
	call	_to_upper
	sub	a, #0x59
	jr	NZ, 00134$
;smram.c:397: presAB = TRUE;
	ld	hl, #_presAB
	ld	(hl), #0x01
	jr	00200$
00134$:
;smram.c:399: else if (to_upper(*params) == 'Z')
	ld	hl, (_params)
	ld	a, (hl)
	call	_to_upper
	sub	a, #0x5a
	jr	NZ, 00127$
;smram.c:401: params++;
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
;smram.c:372: for(params = (char*)0x81; *params != 0; ++params)
	ld	hl, (_params)
	ld	c, (hl)
;smram.c:402: if (*params >= '0' && *params <= '3')
	ld	a, c
	sub	a, #0x30
	jr	C, 00200$
	ld	a, #0x33
	sub	a, c
	jr	C, 00200$
;smram.c:403: cpumode = *params - '0';
	ld	a, c
	ld	hl, #_cpumode
	add	a, #0xd0
	ld	(hl), a
	jr	00200$
;smram.c:408: while(*params++ != 0 && *params != ' ');
00127$:
	ld	hl, (_params)
	ld	c, (hl)
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
	ld	a, c
	or	a, a
	jr	Z, 00200$
	ld	hl, (_params)
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00200$
	jr	00127$
00144$:
;smram.c:413: filename = params;
	ld	(_filename), bc
;smram.c:414: while(*params != 0 && *params != ' ') {
00140$:
;smram.c:372: for(params = (char*)0x81; *params != 0; ++params)
	ld	bc, (_params)
	ld	a, (bc)
;smram.c:414: while(*params != 0 && *params != ' ') {
	ld	e,a
	or	a,a
	jr	Z, 00151$
	sub	a, #0x20
	jr	Z, 00151$
;smram.c:415: *params = to_upper(*params);
	push	bc
	ld	a, e
	call	_to_upper
	pop	bc
	ld	(bc), a
;smram.c:416: params++;
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
	jr	00140$
;smram.c:419: break;
00200$:
;smram.c:372: for(params = (char*)0x81; *params != 0; ++params)
	ld	hl, (_params)
	inc	hl
	ld	(_params), hl
	jp	00199$
00150$:
;smram.c:424: } else megaram_type = TYPE_UNK;
	ld	hl, #0x00ff
	ld	(_megaram_type), hl
00151$:
;smram.c:426: if (megaram_type != TYPE_UNK)
	ld	a, (_megaram_type+0)
	inc	a
	ld	hl, #_megaram_type + 1
	or	a, (hl)
	jp	Z,00191$
;smram.c:428: if (filename == NULL)
	ld	a, (_filename+1)
	ld	hl, #_filename
	or	a, (hl)
	jr	NZ, 00153$
;smram.c:433: );
	ld	hl, #___str_4
	call	_puts
;smram.c:434: return 0;
	ld	de, #0x0000
	jp	00209$
00153$:
;smram.c:437: printf("\r\nMapper Type: ");
	ld	hl, #___str_5
	push	hl
	call	_printf
	pop	af
;smram.c:438: switch(megaram_type)
	ld	a, (_megaram_type+0)
	or	a, a
	ld	iy, #_megaram_type
	or	a, 1 (iy)
	jr	Z, 00154$
	ld	a, (_megaram_type+0)
	sub	a, #0x05
	or	a, 1 (iy)
	jr	Z, 00155$
	ld	a, (_megaram_type+0)
	sub	a, #0x08
	or	a, 1 (iy)
	jr	Z, 00157$
	ld	a, (_megaram_type+0)
	sub	a, #0x16
	or	a, 1 (iy)
	jr	Z, 00156$
	jr	00158$
;smram.c:440: case TYPE_K4:
00154$:
;smram.c:441: printf("Konami (/R6)\r\n");
	ld	hl, #___str_7
	call	_puts
;smram.c:442: break;
	jr	00158$
;smram.c:443: case TYPE_K5:
00155$:
;smram.c:444: printf("Konami SCC (/R5)\r\n");
	ld	hl, #___str_9
	call	_puts
;smram.c:445: break;
	jr	00158$
;smram.c:446: case TYPE_A16:
00156$:
;smram.c:447: printf("ASCII16 (/R1)\r\n");
	ld	hl, #___str_11
	call	_puts
;smram.c:448: break;
	jr	00158$
;smram.c:449: case TYPE_A8:
00157$:
;smram.c:450: printf("ASCII8 (/R3)\r\n");
	ld	hl, #___str_13
	call	_puts
;smram.c:452: }
00158$:
;smram.c:454: for(t = filename; *t != ' ' && *t != 0; t++);
	ld	hl, (_filename)
	ld	(_t), hl
00203$:
;smram.c:345: if (*s++ != *t++) break;
	ld	bc, (_t)
;smram.c:454: for(t = filename; *t != ' ' && *t != 0; t++);
	ld	a, (bc)
	cp	a, #0x20
	jr	Z, 00159$
	or	a, a
	jr	Z, 00159$
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
	jr	00203$
00159$:
;smram.c:455: *t = 0;
	xor	a, a
	ld	(bc), a
;smram.c:456: handle = dos2_open(0, filename);
	ld	de, (_filename)
	xor	a, a
	call	_dos2_open
	ld	(_handle+0), a
;smram.c:458: if (handle)
	ld	a, (_handle+0)
	or	a, a
	jp	Z, 00167$
;smram.c:460: printf("Loading ROM file: %s - ", filename);
	ld	hl, (_filename)
	push	hl
	ld	hl, #___str_14
	push	hl
	call	_printf
	pop	af
	pop	af
;smram.c:462: enaslt(sslt, 0x4000);
	ld	de, #0x4000
	ld	a, (_sslt+0)
	call	_enaslt
;smram.c:463: page = 0;
	ld	hl, #_page
	ld	(hl), #0x00
;smram.c:464: romsize = 0;
	xor	a, a
	ld	(_romsize+0), a
	ld	(_romsize+1), a
	ld	(_romsize+2), a
	ld	(_romsize+3), a
;smram.c:465: printf("%04dKB", 0);
	ld	hl, #0x0000
	push	hl
	ld	hl, #___str_15
	push	hl
	call	_printf
	pop	af
	pop	af
;smram.c:467: do {
00163$:
;smram.c:469: MEGA_PORT0 = 0; // enable paging
	ld	a, #0x00
	out	(_MEGA_PORT0), a
;smram.c:470: *((uchar *)0x4000) = page++;
	ld	a, (_page+0)
	ld	c, a
	ld	hl, #_page
	inc	(hl)
	ld	hl, #0x4000
	ld	(hl), c
;smram.c:471: b = MEGA_PORT0; (b); // enable ram
	in	a, (_MEGA_PORT0)
	ld	(_b+0), a
;smram.c:472: bytes_read = dos2_read(handle, (void*)0x8000, 0x2000);
	ld	h, #0x20
	push	hl
	ld	de, #0x8000
	ld	a, (_handle+0)
	call	_dos2_read
	ld	(_bytes_read), de
;smram.c:473: if (presAB == FALSE && romsize == 0) 
	ld	a, (_presAB+0)
	or	a, a
	jr	NZ, 00161$
	ld	a, (_romsize+3)
	ld	iy, #_romsize
	or	a, 2 (iy)
	or	a, 1 (iy)
	or	a, 0 (iy)
	jr	NZ, 00161$
;smram.c:474: *((uchar*)(0x8000)) = 0;
	ld	hl, #0x8000
	ld	(hl), #0x00
00161$:
;smram.c:475: romsize += bytes_read;
	ld	bc, (_bytes_read)
	ld	de, #0x0000
	ld	a, c
	ld	hl, #_romsize
	add	a, (hl)
	ld	(hl), a
	inc	hl
	ld	a, b
	adc	a, (hl)
	ld	(hl), a
	inc	hl
	ld	a, e
	adc	a, (hl)
	ld	(hl), a
	inc	hl
	ld	a, d
	adc	a, (hl)
	ld	(hl), a
;smram.c:476: memcpy((void*)0x4000, (void*)0x8000, bytes_read);
	ld	de, #0x4000
	ld	hl, #0x8000
	ld	bc, (_bytes_read)
	ld	a, b
	or	a, c
	jr	Z, 00526$
	ldir
00526$:
;smram.c:477: MEGA_PORT0 = 0; // enable paging
	ld	a, #0x00
	out	(_MEGA_PORT0), a
;smram.c:478: printf("\b\b\b\b\b\b%04dKB", (uint)(romsize >> 10));
	ld	hl, (_romsize + 1)
	ld	a, (#_romsize + 3)
	ld	e, a
	ld	b, #0x02
00527$:
	srl	e
	rr	h
	rr	l
	djnz	00527$
	push	hl
	ld	hl, #___str_16
	push	hl
	call	_printf
	pop	af
	pop	af
;smram.c:480: } while (bytes_read > 0);
	ld	a, (_bytes_read+1)
	ld	hl, #_bytes_read
	or	a, (hl)
	jp	NZ, 00163$
;smram.c:482: dos2_close(handle);
	ld	a, (_handle+0)
	call	_dos2_close
	jr	00168$
00167$:
;smram.c:486: printf("ERROR: Failed loading %s\r\n", filename);
	ld	hl, (_filename)
	push	hl
	ld	hl, #___str_17
	push	hl
	call	_printf
	pop	af
	pop	af
;smram.c:487: return 0;
	ld	de, #0x0000
	jp	00209$
00168$:
;smram.c:489: *t = ' '; // restore space
	ld	hl, (_t)
	ld	(hl), #0x20
;smram.c:490: MEGA_PORT1 = megaram_type;
	ld	a, (_megaram_type+0)
	out	(_MEGA_PORT1), a
;smram.c:492: enaslt(sslt, 0x4000);
	ld	de, #0x4000
	ld	a, (_sslt+0)
	call	_enaslt
;smram.c:495: switch(megaram_type)
	ld	a, (_megaram_type+0)
	or	a, a
	ld	iy, #_megaram_type
	or	a, 1 (iy)
	jr	Z, 00170$
	ld	a, (_megaram_type+0)
	sub	a, #0x05
	or	a, 1 (iy)
	jr	Z, 00170$
	ld	a, (_megaram_type+0)
	sub	a, #0x08
	or	a, 1 (iy)
	jr	Z, 00172$
	ld	a, (_megaram_type+0)
	sub	a, #0x16
	or	a, 1 (iy)
	jr	Z, 00171$
	jr	00174$
;smram.c:498: case TYPE_K5:
00170$:
;smram.c:499: *((uchar *)0x4000) = 0;
	ld	hl, #0x4000
	ld	(hl), #0x00
;smram.c:500: *((uchar *)0x6000) = 1;
	ld	h, #0x60
	ld	(hl), #0x01
;smram.c:503: break;
	jr	00174$
;smram.c:504: case TYPE_A16:
00171$:
;smram.c:505: *((uchar *)0x6000) = 0;
	ld	hl, #0x6000
	ld	(hl), #0x00
;smram.c:507: break;
	jr	00174$
;smram.c:508: case TYPE_A8:
00172$:
;smram.c:509: *((uchar *)0x6000) = 0;
	ld	hl, #0x6000
	ld	(hl), #0x00
;smram.c:516: }
00174$:
;smram.c:518: memcpy((void*)0xC000, &runROM, ((uint)&runROM_end - (uint)&runROM));
	ld	hl, #_runROM
	ld	bc, #_runROM_end
	ld	de, #_runROM
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ld	de, #0xc000
	ld	a, b
	or	a, c
	jr	Z, 00533$
	ldir
00533$:
;smram.c:520: if (cpumode != 0)
	ld	a, (_cpumode+0)
	or	a, a
	jr	Z, 00176$
;smram.c:521: chgcpu(cpumode == 1 ? Z80_ROM : cpumode == 2 ? R800_ROM : R800_DRAM);
	ld	a, (_cpumode+0)
	dec	a
	jr	NZ, 00211$
	ld	bc, #0x0000
	jr	00212$
00211$:
	ld	a, (_cpumode+0)
	sub	a, #0x02
	jr	NZ, 00213$
	ld	bc, #0x0081
	jr	00214$
00213$:
	ld	bc, #0x0082
00214$:
00212$:
	ld	a, c
	call	_chgcpu
00176$:
;smram.c:523: jump(0xC000);
	ld	hl, #0xc000
	call	_jump
	jp	00192$
00191$:
;smram.c:532: if (dos2_getenv("PROGRAM", path) == 0)
	ld	de, #_path
	ld	hl, #___str_18
	call	_dos2_getenv
	or	a, a
	jp	NZ, 00192$
;smram.c:534: for(t = path; *t != '.' && *t != 0; t++);
	ld	hl, #_path
	ld	(_t), hl
00207$:
;smram.c:345: if (*s++ != *t++) break;
	ld	hl, (_t)
	ex	(sp), hl
;smram.c:454: for(t = filename; *t != ' ' && *t != 0; t++);
	pop	hl
	push	hl
	ld	a, (hl)
;smram.c:534: for(t = path; *t != '.' && *t != 0; t++);
	cp	a, #0x2e
	jr	Z, 00177$
	or	a, a
	jr	Z, 00177$
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
	jr	00207$
00177$:
;smram.c:535: if (*t != 0)
	or	a, a
	jr	Z, 00179$
;smram.c:537: *t++ = '2';
	pop	hl
	ld	(hl), #0x32
	push	hl
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
;smram.c:538: *t++ = '.';
	ld	hl, (_t)
	ld	(hl), #0x2e
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
;smram.c:539: *t++ = 'C';
	ld	hl, (_t)
	ld	(hl), #0x43
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
;smram.c:540: *t++ = 'O';
	ld	hl, (_t)
	ld	(hl), #0x4f
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
;smram.c:541: *t++ = 'M';
	ld	hl, (_t)
	ld	(hl), #0x4d
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
;smram.c:542: *t++ = 0;
	ld	hl, (_t)
	ld	(hl), #0x00
	ld	hl, (_t)
	inc	hl
	ld	(_t), hl
00179$:
;smram.c:544: handle = dos2_open(0, path);
	ld	de, #_path
	xor	a, a
	call	_dos2_open
	ld	(_handle+0), a
;smram.c:545: if (handle)
	ld	a, (_handle+0)
	or	a, a
	jr	Z, 00186$
;smram.c:547: printf("Redirecting to SROM.COM...\r\n"); 
	ld	hl, #___str_20
	call	_puts
;smram.c:549: addr = 0x4000;
	ld	hl, #0x4000
	ld	(_addr), hl
;smram.c:550: do {
00180$:
;smram.c:551: bytes_read = dos2_read(handle, (void*)addr, 0x2000);
	ld	de, (_addr)
	ld	hl, #0x2000
	push	hl
	ld	a, (_handle+0)
	call	_dos2_read
	ld	(_bytes_read), de
;smram.c:552: addr += bytes_read;
	ld	hl, #_bytes_read
	push	de
	ld	de, #_addr
	ld	a, (de)
	add	a, (hl)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (de)
	adc	a, (hl)
	ld	(de), a
	pop	de
;smram.c:553: } while(bytes_read > 0);
	ld	a, (_bytes_read+1)
	ld	hl, #_bytes_read
	or	a, (hl)
	jr	NZ, 00180$
;smram.c:554: dos2_close(handle);
	ld	a, (_handle+0)
	call	_dos2_close
;smram.c:555: MEGA_PORT1 = TYPE_K4;
	ld	a, #0x00
	out	(_MEGA_PORT1), a
;smram.c:556: memcpy((void*)addr, &copyandrun, ((uint)&copyandrun_end - (uint)&copyandrun));
	ld	de, (_addr)
	ld	hl, #_copyandrun
	ld	bc, #_copyandrun_end
	ld	-2 (ix), #<(_copyandrun)
	ld	-1 (ix), #>(_copyandrun)
	ld	a, c
	sub	a, -2 (ix)
	ld	c, a
	ld	a, b
	sbc	a, -1 (ix)
	ld	b, a
	or	a, c
	jr	Z, 00539$
	ldir
00539$:
;smram.c:557: jump(addr);
	ld	hl, (_addr)
	call	_jump
	jr	00192$
00186$:
;smram.c:561: if (!found) printf("ERROR: Super MegaRAM SCC+ not found...\r\n");
	ld	a, (_found+0)
	or	a, a
	jr	NZ, 00192$
	ld	hl, #___str_22
	call	_puts
00192$:
;smram.c:566: return 1;
	ld	de, #0x0001
00209$:
;smram.c:567: }
	pop	af
	pop	ix
	ret
___str_0:
	.ascii "WonderTANG! uSD Driver"
	.db 0x00
___str_2:
	.ascii "WonderTANG! Super MegaRAM SCC+"
	.db 0x0d
	.db 0x00
___str_4:
	.db 0x0d
	.db 0x0a
	.ascii "USAGE: SMROM [/Rx /Zx] filename"
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.db 0x0a
	.ascii " /Rx: Set MegaROM type"
	.db 0x0d
	.db 0x0a
	.ascii "   1: ASCII16"
	.db 0x0d
	.db 0x0a
	.ascii "   3: ASCII8"
	.db 0x0d
	.db 0x0a
	.ascii "   5: Konami SCC"
	.db 0x0d
	.db 0x0a
	.ascii "   6: Konami"
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.db 0x0a
	.ascii " /Zx: Set cpu mode"
	.db 0x0d
	.db 0x0a
	.ascii "   0: default"
	.db 0x0d
	.db 0x0a
	.ascii "   1: Z80"
	.db 0x0d
	.db 0x0a
	.ascii "   2: R800 ROM"
	.db 0x0d
	.db 0x0a
	.ascii "   3: R800 DRAM"
	.db 0x0d
	.db 0x0a
	.db 0x0d
	.db 0x00
___str_5:
	.db 0x0d
	.db 0x0a
	.ascii "Mapper Type: "
	.db 0x00
___str_7:
	.ascii "Konami (/R6)"
	.db 0x0d
	.db 0x00
___str_9:
	.ascii "Konami SCC (/R5)"
	.db 0x0d
	.db 0x00
___str_11:
	.ascii "ASCII16 (/R1)"
	.db 0x0d
	.db 0x00
___str_13:
	.ascii "ASCII8 (/R3)"
	.db 0x0d
	.db 0x00
___str_14:
	.ascii "Loading ROM file: %s - "
	.db 0x00
___str_15:
	.ascii "%04dKB"
	.db 0x00
___str_16:
	.db 0x08
	.db 0x08
	.db 0x08
	.db 0x08
	.db 0x08
	.db 0x08
	.ascii "%04dKB"
	.db 0x00
___str_17:
	.ascii "ERROR: Failed loading %s"
	.db 0x0d
	.db 0x0a
	.db 0x00
___str_18:
	.ascii "PROGRAM"
	.db 0x00
___str_20:
	.ascii "Redirecting to SROM.COM..."
	.db 0x0d
	.db 0x00
___str_22:
	.ascii "ERROR: Super MegaRAM SCC+ not found..."
	.db 0x0d
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__found:
	.db #0x00	; 0
__xinit__filename:
	.dw #0x0000
__xinit__megaram_type:
	.dw #0x0000
__xinit__presAB:
	.db #0x00	; 0
__xinit__cpumode:
	.db #0x01	; 1
	.area _CABS (ABS)