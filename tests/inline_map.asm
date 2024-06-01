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
	mv	x11, x10
# was:	mv	_plus_L_4_, _let_N_2_
# 	mv	_plus_R_5_,_let_N_2_
	add	x13, x11, x10
# was:	add	_let_z_3_, _plus_L_4_, _plus_R_5_
# 	mv	_arr_8_,_let_z_3_
	lw	x10, 0(x13)
# was:	lw	_size_7_, 0(_arr_8_)
	mv	x11, x3
# was:	mv	_let_x_6_, x3
	slli	x12, x10, 2
# was:	slli	_tmp_18_, _size_7_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_18_, _tmp_18_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_18_
	sw	x10, 0(x11)
# was:	sw	_size_7_, 0(_let_x_6_)
	addi	x12, x11, 4
# was:	addi	_addrg_11_, _let_x_6_, 4
	mv	x11, x0
# was:	mv	_i_12_, x0
	addi	x13, x13, 4
# was:	addi	_elem_9_, _arr_8_, 4
l.loop_beg_13_:
	bge	x11, x10, l.loop_end_14_
# was:	bge	_i_12_, _size_7_, l.loop_end_14_
	lw	x14, 0(x13)
# was:	lw	_res_10_, 0(_elem_9_)
	addi	x13, x13, 4
# was:	addi	_elem_9_, _elem_9_, 4
# 	mv	_plus_L_16_,_res_10_
	li	x15, 5
# was:	li	_plus_R_17_, 5
	add	x14, x14, x15
# was:	add	_fun_arg_res_15_, _plus_L_16_, _plus_R_17_
# 	mv	_res_10_,_fun_arg_res_15_
	sw	x14, 0(x12)
# was:	sw	_res_10_, 0(_addrg_11_)
	addi	x12, x12, 4
# was:	addi	_addrg_11_, _addrg_11_, 4
	addi	x11, x11, 1
# was:	addi	_i_12_, _i_12_, 1
	j	l.loop_beg_13_
l.loop_end_14_:
	li	x14, 8
# was:	li	_arr_21_, 8
	lw	x11, 0(x14)
# was:	lw	_size_20_, 0(_arr_21_)
	mv	x10, x3
# was:	mv	_let_w_19_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_31_, _size_20_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_31_, _tmp_31_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_31_
	sw	x11, 0(x10)
# was:	sw	_size_20_, 0(_let_w_19_)
	addi	x13, x10, 4
# was:	addi	_addrg_24_, _let_w_19_, 4
	mv	x12, x0
# was:	mv	_i_25_, x0
	addi	x14, x14, 4
# was:	addi	_elem_22_, _arr_21_, 4
l.loop_beg_26_:
	bge	x12, x11, l.loop_end_27_
# was:	bge	_i_25_, _size_20_, l.loop_end_27_
	lw	x15, 0(x14)
# was:	lw	_res_23_, 0(_elem_22_)
	addi	x14, x14, 4
# was:	addi	_elem_22_, _elem_22_, 4
# 	mv	_plus_L_29_,_res_23_
	mv	x16, x15
# was:	mv	_plus_R_30_, _res_23_
	add	x15, x15, x16
# was:	add	_fun_arg_res_28_, _plus_L_29_, _plus_R_30_
# 	mv	_res_23_,_fun_arg_res_28_
	sw	x15, 0(x13)
# was:	sw	_res_23_, 0(_addrg_24_)
	addi	x13, x13, 4
# was:	addi	_addrg_24_, _addrg_24_, 4
	addi	x12, x12, 1
# was:	addi	_i_25_, _i_25_, 1
	j	l.loop_beg_26_
l.loop_end_27_:
# 	mv	_arr_33_,_let_w_19_
	lw	x18, 0(x10)
# was:	lw	_size_32_, 0(_arr_33_)
	mv	x19, x3
# was:	mv	_mainres_1_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_42_, _size_32_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_42_, _tmp_42_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_42_
	sw	x18, 0(x19)
# was:	sw	_size_32_, 0(_mainres_1_)
	addi	x20, x19, 4
# was:	addi	_addrg_36_, _mainres_1_, 4
	mv	x21, x0
# was:	mv	_i_37_, x0
	addi	x22, x10, 4
# was:	addi	_elem_34_, _arr_33_, 4
l.loop_beg_38_:
	bge	x21, x18, l.loop_end_39_
# was:	bge	_i_37_, _size_32_, l.loop_end_39_
	lw	x23, 0(x22)
# was:	lw	_res_35_, 0(_elem_34_)
	addi	x22, x22, 4
# was:	addi	_elem_34_, _elem_34_, 4
# 	mv	_tmp_41_,_res_35_
# 	mv	_fun_arg_res_40_,_tmp_41_
	mv	x10, x23
# was:	mv	x10, _fun_arg_res_40_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_35_,_fun_arg_res_40_
	sw	x23, 0(x20)
# was:	sw	_res_35_, 0(_addrg_36_)
	addi	x20, x20, 4
# was:	addi	_addrg_36_, _addrg_36_, 4
	addi	x21, x21, 1
# was:	addi	_i_37_, _i_37_, 1
	j	l.loop_beg_38_
l.loop_end_39_:
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