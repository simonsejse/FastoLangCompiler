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
	mv	x12, x10
# was:	mv	_size_4_, _let_N_2_
	bge	x12, x0, l.safe_5_
# was:	bge	_size_4_, x0, l.safe_5_
	li	x10, 7
# was:	li	x10, 7
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_5_:
	mv	x14, x3
# was:	mv	_let_z_3_, x3
	slli	x10, x12, 2
# was:	slli	_tmp_10_, _size_4_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_10_, _tmp_10_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_10_
	sw	x12, 0(x14)
# was:	sw	_size_4_, 0(_let_z_3_)
	addi	x11, x14, 4
# was:	addi	_addr_6_, _let_z_3_, 4
	mv	x10, x0
# was:	mv	_i_7_, x0
l.loop_beg_8_:
	bge	x10, x12, l.loop_end_9_
# was:	bge	_i_7_, _size_4_, l.loop_end_9_
	sw	x10, 0(x11)
# was:	sw	_i_7_, 0(_addr_6_)
	addi	x11, x11, 4
# was:	addi	_addr_6_, _addr_6_, 4
	addi	x10, x10, 1
# was:	addi	_i_7_, _i_7_, 1
	j	l.loop_beg_8_
l.loop_end_9_:
# 	mv	_arr_13_,_let_z_3_
	lw	x11, 0(x14)
# was:	lw	_size_12_, 0(_arr_13_)
	mv	x10, x3
# was:	mv	_let_x_I1_11_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_23_, _size_12_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_23_, _tmp_23_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_23_
	sw	x11, 0(x10)
# was:	sw	_size_12_, 0(_let_x_I1_11_)
	addi	x12, x10, 4
# was:	addi	_addrg_16_, _let_x_I1_11_, 4
	mv	x13, x0
# was:	mv	_i_17_, x0
	addi	x14, x14, 4
# was:	addi	_elem_14_, _arr_13_, 4
l.loop_beg_18_:
	bge	x13, x11, l.loop_end_19_
# was:	bge	_i_17_, _size_12_, l.loop_end_19_
	lw	x15, 0(x14)
# was:	lw	_res_15_, 0(_elem_14_)
	addi	x14, x14, 4
# was:	addi	_elem_14_, _elem_14_, 4
# 	mv	_plus_L_21_,_res_15_
	li	x16, 2
# was:	li	_plus_R_22_, 2
	add	x15, x15, x16
# was:	add	_fun_arg_res_20_, _plus_L_21_, _plus_R_22_
# 	mv	_res_15_,_fun_arg_res_20_
	sw	x15, 0(x12)
# was:	sw	_res_15_, 0(_addrg_16_)
	addi	x12, x12, 4
# was:	addi	_addrg_16_, _addrg_16_, 4
	addi	x13, x13, 1
# was:	addi	_i_17_, _i_17_, 1
	j	l.loop_beg_18_
l.loop_end_19_:
# 	mv	_arr_26_,_let_x_I1_11_
	lw	x19, 0(x10)
# was:	lw	_size_25_, 0(_arr_26_)
	mv	x18, x3
# was:	mv	_let_w_24_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_35_, _size_25_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_35_, _tmp_35_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_35_
	sw	x19, 0(x18)
# was:	sw	_size_25_, 0(_let_w_24_)
	addi	x20, x18, 4
# was:	addi	_addrg_29_, _let_w_24_, 4
	mv	x21, x0
# was:	mv	_i_30_, x0
	addi	x22, x10, 4
# was:	addi	_elem_27_, _arr_26_, 4
l.loop_beg_31_:
	bge	x21, x19, l.loop_end_32_
# was:	bge	_i_30_, _size_25_, l.loop_end_32_
	lw	x23, 0(x22)
# was:	lw	_res_28_, 0(_elem_27_)
	addi	x22, x22, 4
# was:	addi	_elem_27_, _elem_27_, 4
# 	mv	_tmp_34_,_res_28_
# 	mv	_fun_arg_res_33_,_tmp_34_
	mv	x10, x23
# was:	mv	x10, _fun_arg_res_33_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_28_,_fun_arg_res_33_
	sw	x23, 0(x20)
# was:	sw	_res_28_, 0(_addrg_29_)
	addi	x20, x20, 4
# was:	addi	_addrg_29_, _addrg_29_, 4
	addi	x21, x21, 1
# was:	addi	_i_30_, _i_30_, 1
	j	l.loop_beg_31_
l.loop_end_32_:
	la	x10, s.X_38_
# was:	la	_tmp_37_, s.X_38_
# s.X_38_: string "\n"
# 	mv	_let_nl_36_,_tmp_37_
# 	mv	x10,_tmp_37_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_arr_40_,_let_w_24_
	lw	x10, 0(x18)
# was:	lw	_size_41_, 0(_arr_40_)
	li	x11, 0
# was:	li	_let_x_I2_39_, 0
	addi	x18, x18, 4
# was:	addi	_arr_40_, _arr_40_, 4
	mv	x13, x0
# was:	mv	_ind_var_42_, x0
l.loop_beg_44_:
	bge	x13, x10, l.loop_end_45_
# was:	bge	_ind_var_42_, _size_41_, l.loop_end_45_
	lw	x12, 0(x18)
# was:	lw	_tmp_43_, 0(_arr_40_)
	addi	x18, x18, 4
# was:	addi	_arr_40_, _arr_40_, 4
# 	mv	_plus_L_47_,_let_x_I2_39_
# 	mv	_plus_R_48_,_tmp_43_
	add	x11, x11, x12
# was:	add	_fun_arg_res_46_, _plus_L_47_, _plus_R_48_
# 	mv	_let_x_I2_39_,_fun_arg_res_46_
	addi	x13, x13, 1
# was:	addi	_ind_var_42_, _ind_var_42_, 1
	j	l.loop_beg_44_
l.loop_end_45_:
# 	mv	_tmp_49_,_let_x_I2_39_
	mv	x18, x11
# was:	mv	_mainres_1_, _tmp_49_
	mv	x10, x18
# was:	mv	x10, _mainres_1_
	jal	p.putint
# was:	jal	p.putint, x10
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
s.X_38_:
	.word	1
	.ascii	"\n"
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