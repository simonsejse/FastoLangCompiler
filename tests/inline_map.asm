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
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_N_2_,x10
	li	x14, 8
# was:	li	_arr_5_, 8
	lw	x10, 0(x14)
# was:	lw	_size_4_, 0(_arr_5_)
	mv	x11, x3
# was:	mv	_let_w_3_, x3
	slli	x12, x10, 2
# was:	slli	_tmp_15_, _size_4_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_15_
	sw	x10, 0(x11)
# was:	sw	_size_4_, 0(_let_w_3_)
	addi	x12, x11, 4
# was:	addi	_addrg_8_, _let_w_3_, 4
	mv	x13, x0
# was:	mv	_i_9_, x0
	addi	x14, x14, 4
# was:	addi	_elem_6_, _arr_5_, 4
l.loop_beg_10_:
	bge	x13, x10, l.loop_end_11_
# was:	bge	_i_9_, _size_4_, l.loop_end_11_
	lw	x15, 0(x14)
# was:	lw	_res_7_, 0(_elem_6_)
	addi	x14, x14, 4
# was:	addi	_elem_6_, _elem_6_, 4
	mv	x16, x15
# was:	mv	_plus_L_13_, _res_7_
# 	mv	_plus_R_14_,_res_7_
	add	x15, x16, x15
# was:	add	_fun_arg_res_12_, _plus_L_13_, _plus_R_14_
# 	mv	_res_7_,_fun_arg_res_12_
	sw	x15, 0(x12)
# was:	sw	_res_7_, 0(_addrg_8_)
	addi	x12, x12, 4
# was:	addi	_addrg_8_, _addrg_8_, 4
	addi	x13, x13, 1
# was:	addi	_i_9_, _i_9_, 1
	j	l.loop_beg_10_
l.loop_end_11_:
# 	mv	_arr_17_,_let_w_3_
	lw	x18, 0(x11)
# was:	lw	_size_16_, 0(_arr_17_)
	mv	x19, x3
# was:	mv	_mainres_1_, x3
	slli	x10, x18, 2
# was:	slli	_tmp_26_, _size_16_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_26_, _tmp_26_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_26_
	sw	x18, 0(x19)
# was:	sw	_size_16_, 0(_mainres_1_)
	addi	x20, x19, 4
# was:	addi	_addrg_20_, _mainres_1_, 4
	mv	x21, x0
# was:	mv	_i_21_, x0
	addi	x22, x11, 4
# was:	addi	_elem_18_, _arr_17_, 4
l.loop_beg_22_:
	bge	x21, x18, l.loop_end_23_
# was:	bge	_i_21_, _size_16_, l.loop_end_23_
	lw	x23, 0(x22)
# was:	lw	_res_19_, 0(_elem_18_)
	addi	x22, x22, 4
# was:	addi	_elem_18_, _elem_18_, 4
# 	mv	_tmp_25_,_res_19_
# 	mv	_fun_arg_res_24_,_tmp_25_
	mv	x10, x23
# was:	mv	x10, _fun_arg_res_24_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_19_,_fun_arg_res_24_
	sw	x23, 0(x20)
# was:	sw	_res_19_, 0(_addrg_20_)
	addi	x20, x20, 4
# was:	addi	_addrg_20_, _addrg_20_, 4
	addi	x21, x21, 1
# was:	addi	_i_21_, _i_21_, 1
	j	l.loop_beg_22_
l.loop_end_23_:
	mv	x10, x19
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