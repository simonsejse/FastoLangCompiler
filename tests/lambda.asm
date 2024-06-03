	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function write_int
f.write_int:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_x_1_,x10
	mv	x18, x10
# was:	mv	_tmp_3_, _param_x_1_
# 	mv	_write_intres_2_,_tmp_3_
	mv	x10, x18
# was:	mv	x10, _write_intres_2_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _write_intres_2_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function write_int_arr
f.write_int_arr:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_x_4_,x10
# 	mv	_arr_7_,_param_x_4_
	lw	x18, 0(x10)
# was:	lw	_size_6_, 0(_arr_7_)
	mv	x19, x3
# was:	mv	_write_int_arrres_5_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_15_, _size_6_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_15_
	sw	x18, 0(x19)
# was:	sw	_size_6_, 0(_write_int_arrres_5_)
	addi	x20, x19, 4
# was:	addi	_addrg_10_, _write_int_arrres_5_, 4
	mv	x21, x0
# was:	mv	_i_11_, x0
	addi	x22, x10, 4
# was:	addi	_elem_8_, _arr_7_, 4
l.loop_beg_12_:
	bge	x21, x18, l.loop_end_13_
# was:	bge	_i_11_, _size_6_, l.loop_end_13_
	lw	x10, 0(x22)
# was:	lw	_res_9_, 0(_elem_8_)
	addi	x22, x22, 4
# was:	addi	_elem_8_, _elem_8_, 4
# 	mv	x10,_res_9_
	jal	f.write_int
# was:	jal	f.write_int, x10
# 	mv	_tmp_14_,x10
# 	mv	_res_9_,_tmp_14_
	sw	x10, 0(x20)
# was:	sw	_res_9_, 0(_addrg_10_)
	addi	x20, x20, 4
# was:	addi	_addrg_10_, _addrg_10_, 4
	addi	x21, x21, 1
# was:	addi	_i_11_, _i_11_, 1
	j	l.loop_beg_12_
l.loop_end_13_:
	mv	x10, x19
# was:	mv	x10, _write_int_arrres_5_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_N_17_,x10
	mv	x11, x10
# was:	mv	_size_19_, _let_N_17_
	bge	x11, x0, l.safe_20_
# was:	bge	_size_19_, x0, l.safe_20_
	li	x10, 7
# was:	li	x10, 7
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_20_:
	mv	x14, x3
# was:	mv	_let_z_18_, x3
	slli	x10, x11, 2
# was:	slli	_tmp_25_, _size_19_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_25_, _tmp_25_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_25_
	sw	x11, 0(x14)
# was:	sw	_size_19_, 0(_let_z_18_)
	addi	x10, x14, 4
# was:	addi	_addr_21_, _let_z_18_, 4
	mv	x12, x0
# was:	mv	_i_22_, x0
l.loop_beg_23_:
	bge	x12, x11, l.loop_end_24_
# was:	bge	_i_22_, _size_19_, l.loop_end_24_
	sw	x12, 0(x10)
# was:	sw	_i_22_, 0(_addr_21_)
	addi	x10, x10, 4
# was:	addi	_addr_21_, _addr_21_, 4
	addi	x12, x12, 1
# was:	addi	_i_22_, _i_22_, 1
	j	l.loop_beg_23_
l.loop_end_24_:
# 	mv	_arr_29_,_let_z_18_
	lw	x11, 0(x14)
# was:	lw	_size_28_, 0(_arr_29_)
	mv	x10, x3
# was:	mv	_arg_27_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_39_, _size_28_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_39_, _tmp_39_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_39_
	sw	x11, 0(x10)
# was:	sw	_size_28_, 0(_arg_27_)
	addi	x12, x10, 4
# was:	addi	_addrg_32_, _arg_27_, 4
	mv	x13, x0
# was:	mv	_i_33_, x0
	addi	x14, x14, 4
# was:	addi	_elem_30_, _arr_29_, 4
l.loop_beg_34_:
	bge	x13, x11, l.loop_end_35_
# was:	bge	_i_33_, _size_28_, l.loop_end_35_
	lw	x15, 0(x14)
# was:	lw	_res_31_, 0(_elem_30_)
	addi	x14, x14, 4
# was:	addi	_elem_30_, _elem_30_, 4
	mv	x16, x15
# was:	mv	_plus_L_37_, _res_31_
	li	x15, 2
# was:	li	_plus_R_38_, 2
	add	x15, x16, x15
# was:	add	_fun_arg_res_36_, _plus_L_37_, _plus_R_38_
# 	mv	_res_31_,_fun_arg_res_36_
	sw	x15, 0(x12)
# was:	sw	_res_31_, 0(_addrg_32_)
	addi	x12, x12, 4
# was:	addi	_addrg_32_, _addrg_32_, 4
	addi	x13, x13, 1
# was:	addi	_i_33_, _i_33_, 1
	j	l.loop_beg_34_
l.loop_end_35_:
# 	mv	x10,_arg_27_
	jal	f.write_int_arr
# was:	jal	f.write_int_arr, x10
	mv	x18, x10
# was:	mv	_let_w_26_, x10
	la	x10, s.X_42_
# was:	la	_tmp_41_, s.X_42_
# s.X_42_: string "\n"
# 	mv	_let_nl_40_,_tmp_41_
# 	mv	x10,_tmp_41_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_arr_44_,_let_w_26_
	lw	x11, 0(x18)
# was:	lw	_size_45_, 0(_arr_44_)
	li	x10, 0
# was:	li	_arg_43_, 0
	addi	x18, x18, 4
# was:	addi	_arr_44_, _arr_44_, 4
	mv	x12, x0
# was:	mv	_ind_var_46_, x0
l.loop_beg_48_:
	bge	x12, x11, l.loop_end_49_
# was:	bge	_ind_var_46_, _size_45_, l.loop_end_49_
	lw	x13, 0(x18)
# was:	lw	_tmp_47_, 0(_arr_44_)
	addi	x18, x18, 4
# was:	addi	_arr_44_, _arr_44_, 4
# 	mv	_plus_L_51_,_arg_43_
# 	mv	_plus_R_52_,_tmp_47_
	add	x10, x10, x13
# was:	add	_fun_arg_res_50_, _plus_L_51_, _plus_R_52_
# 	mv	_arg_43_,_fun_arg_res_50_
	addi	x12, x12, 1
# was:	addi	_ind_var_46_, _ind_var_46_, 1
	j	l.loop_beg_48_
l.loop_end_49_:
# 	mv	x10,_arg_43_
	jal	f.write_int
# was:	jal	f.write_int, x10
# 	mv	_mainres_16_,x10
# 	mv	x10,_mainres_16_
	addi	x2, x2, 8
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
s.X_42_:
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