	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x23, -28(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -28
	li	x12, 5
# was:	li	_size_6_, 5
	mv	x10, x3
# was:	mv	_arr_3_, x3
	addi	x11, x12, 3
# was:	addi	_tmp_9_, _size_6_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_9_, _tmp_9_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_9_, _tmp_9_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_9_
	sw	x12, 0(x10)
# was:	sw	_size_6_, 0(_arr_3_)
	addi	x12, x10, 4
# was:	addi	_addr_7_, _arr_3_, 4
	li	x11, 1
# was:	li	_tmp_8_, 1
	sb	x11, 0(x12)
# was:	sb	_tmp_8_, 0(_addr_7_)
	addi	x12, x12, 1
# was:	addi	_addr_7_, _addr_7_, 1
	li	x11, 1
# was:	li	_tmp_8_, 1
	sb	x11, 0(x12)
# was:	sb	_tmp_8_, 0(_addr_7_)
	addi	x12, x12, 1
# was:	addi	_addr_7_, _addr_7_, 1
	li	x11, 1
# was:	li	_tmp_8_, 1
	sb	x11, 0(x12)
# was:	sb	_tmp_8_, 0(_addr_7_)
	addi	x12, x12, 1
# was:	addi	_addr_7_, _addr_7_, 1
	li	x11, 1
# was:	li	_tmp_8_, 1
	sb	x11, 0(x12)
# was:	sb	_tmp_8_, 0(_addr_7_)
	addi	x12, x12, 1
# was:	addi	_addr_7_, _addr_7_, 1
	li	x11, 0
# was:	li	_tmp_8_, 0
	sb	x11, 0(x12)
# was:	sb	_tmp_8_, 0(_addr_7_)
	addi	x12, x12, 1
# was:	addi	_addr_7_, _addr_7_, 1
	lw	x19, 0(x10)
# was:	lw	_size_2_, 0(_arr_3_)
	mv	x18, x3
# was:	mv	_mainres_1_, x3
	addi	x11, x19, 3
# was:	addi	_tmp_17_, _size_2_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_17_, _tmp_17_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_17_, _tmp_17_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_17_
	sw	x19, 0(x18)
# was:	sw	_size_2_, 0(_mainres_1_)
	addi	x21, x18, 4
# was:	addi	_addrg_10_, _mainres_1_, 4
	mv	x20, x0
# was:	mv	_i_11_, x0
	addi	x22, x10, 4
# was:	addi	_elem_4_, _arr_3_, 4
l.loop_beg_12_:
	bge	x20, x19, l.loop_end_13_
# was:	bge	_i_11_, _size_2_, l.loop_end_13_
	lbu	x23, 0(x22)
# was:	lbu	_res_5_, 0(_elem_4_)
	addi	x22, x22, 1
# was:	addi	_elem_4_, _elem_4_, 1
# 	mv	_tmp_15_,_res_5_
# 	mv	_fun_arg_res_14_,_tmp_15_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x23, x0, l.wBoolF_16_
# was:	bne	_fun_arg_res_14_, x0, l.wBoolF_16_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_16_:
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_res_5_,_fun_arg_res_14_
	sb	x23, 0(x21)
# was:	sb	_res_5_, 0(_addrg_10_)
	addi	x21, x21, 1
# was:	addi	_addrg_10_, _addrg_10_, 1
	addi	x20, x20, 1
# was:	addi	_i_11_, _i_11_, 1
	j	l.loop_beg_12_
l.loop_end_13_:
	mv	x10, x18
# was:	mv	x10, _mainres_1_
	addi	x2, x2, 28
	lw	x23, -28(x2)
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Library functions in Fasto namespace
f.ord:
	mv	x10, x10
	jr	x1
f.chr:
	andi	x10, x10, 255
	jr	x1
# Internal procedures (for syscalls, etc.)
p.putint:
	li	x17, 1
	ecall
	li	x17, 4
	la	x10, m.space
	ecall
	jr	x1
p.getint:
	li	x17, 5
	ecall
	jr	x1
p.putchar:
	li	x17, 11
	ecall
	li	x17, 4
	la	x10, m.space
	ecall
	jr	x1
p.getchar:
	li	x17, 12
	ecall
	jr	x1
p.putstring:
	lw	x7, 0(x10)
	addi	x6, x10, 4
	add	x7, x6, x7
	li	x17, 11
l.ps_begin:
	bge	x6, x7, l.ps_done
	lbu	x10, 0(x6)
	ecall
	addi	x6, x6, 1
	j	l.ps_begin
l.ps_done:
	jr	x1
p.stop:
	li	x17, 93
	li	x10, 0
	ecall
p.RuntimeError:
	mv	x6, x10
	li	x17, 4
	la	x10, m.RunErr
	ecall
	li	x17, 1
	mv	x10, x6
	ecall
	li	x17, 4
	la	x10, m.colon_space
	ecall
	mv	x10, x11
	ecall
	la	x10, m.nl
	ecall
	jal	p.stop
	.data	
# Fixed strings for runtime I/O
m.RunErr:
	.asciz	"Runtime error at line "
m.colon_space:
	.asciz	": "
m.nl:
	.asciz	"\n"
m.space:
	.asciz	" "
# Message strings for specific errors
m.BadSize:
	.asciz	"negative array size"
m.BadIndex:
	.asciz	"array index out of bounds"
m.DivZero:
	.asciz	"division by zero"
# String literals (including lengths) from program
	.align	2
s.true:
	.word	4
	.ascii	"true"
	.align	2
s.false:
	.word	5
	.ascii	"false"
	.align	2
# Space for Fasto heap
d.heap:
	.space	100000