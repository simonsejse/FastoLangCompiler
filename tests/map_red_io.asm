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
# 	mv	_let_n_2_,x10
	mv	x11, x10
# was:	mv	_size_4_, _let_n_2_
	bge	x11, x0, l.safe_5_
# was:	bge	_size_4_, x0, l.safe_5_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_5_:
	mv	x10, x3
# was:	mv	_let_a_3_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_10_, _size_4_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_10_, _tmp_10_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_10_
	sw	x11, 0(x10)
# was:	sw	_size_4_, 0(_let_a_3_)
	addi	x12, x10, 4
# was:	addi	_addr_6_, _let_a_3_, 4
	mv	x13, x0
# was:	mv	_i_7_, x0
l.loop_beg_8_:
	bge	x13, x11, l.loop_end_9_
# was:	bge	_i_7_, _size_4_, l.loop_end_9_
	sw	x13, 0(x12)
# was:	sw	_i_7_, 0(_addr_6_)
	addi	x12, x12, 4
# was:	addi	_addr_6_, _addr_6_, 4
	addi	x13, x13, 1
# was:	addi	_i_7_, _i_7_, 1
	j	l.loop_beg_8_
l.loop_end_9_:
# 	mv	_arr_13_,_let_a_3_
	lw	x11, 0(x10)
# was:	lw	_size_12_, 0(_arr_13_)
	mv	x12, x3
# was:	mv	_let_b_11_, x3
	slli	x13, x11, 2
# was:	slli	_tmp_23_, _size_12_, 2
	addi	x13, x13, 4
# was:	addi	_tmp_23_, _tmp_23_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_23_
	sw	x11, 0(x12)
# was:	sw	_size_12_, 0(_let_b_11_)
	addi	x14, x12, 4
# was:	addi	_addrg_16_, _let_b_11_, 4
	mv	x13, x0
# was:	mv	_i_17_, x0
	addi	x15, x10, 4
# was:	addi	_elem_14_, _arr_13_, 4
l.loop_beg_18_:
	bge	x13, x11, l.loop_end_19_
# was:	bge	_i_17_, _size_12_, l.loop_end_19_
	lw	x16, 0(x15)
# was:	lw	_res_15_, 0(_elem_14_)
	addi	x15, x15, 4
# was:	addi	_elem_14_, _elem_14_, 4
	mv	x17, x16
# was:	mv	_plus_L_21_, _res_15_
	li	x16, 100
# was:	li	_plus_R_22_, 100
	add	x16, x17, x16
# was:	add	_fun_arg_res_20_, _plus_L_21_, _plus_R_22_
# 	mv	_res_15_,_fun_arg_res_20_
	sw	x16, 0(x14)
# was:	sw	_res_15_, 0(_addrg_16_)
	addi	x14, x14, 4
# was:	addi	_addrg_16_, _addrg_16_, 4
	addi	x13, x13, 1
# was:	addi	_i_17_, _i_17_, 1
	j	l.loop_beg_18_
l.loop_end_19_:
# 	mv	_arr_25_,_let_b_11_
	lw	x11, 0(x12)
# was:	lw	_size_26_, 0(_arr_25_)
	li	x20, 0
# was:	li	_let_d_24_, 0
	addi	x12, x12, 4
# was:	addi	_arr_25_, _arr_25_, 4
	mv	x13, x0
# was:	mv	_ind_var_27_, x0
l.loop_beg_29_:
	bge	x13, x11, l.loop_end_30_
# was:	bge	_ind_var_27_, _size_26_, l.loop_end_30_
	lw	x14, 0(x12)
# was:	lw	_tmp_28_, 0(_arr_25_)
	addi	x12, x12, 4
# was:	addi	_arr_25_, _arr_25_, 4
# 	mv	_plus_L_32_,_let_d_24_
# 	mv	_plus_R_33_,_tmp_28_
	add	x20, x20, x14
# was:	add	_fun_arg_res_31_, _plus_L_32_, _plus_R_33_
# 	mv	_let_d_24_,_fun_arg_res_31_
	addi	x13, x13, 1
# was:	addi	_ind_var_27_, _ind_var_27_, 1
	j	l.loop_beg_29_
l.loop_end_30_:
# 	mv	_arr_36_,_let_a_3_
	lw	x19, 0(x10)
# was:	lw	_size_35_, 0(_arr_36_)
	mv	x18, x3
# was:	mv	_let_c_34_, x3
	addi	x11, x19, 3
# was:	addi	_tmp_44_, _size_35_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_44_, _tmp_44_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_44_, _tmp_44_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_44_
	sw	x19, 0(x18)
# was:	sw	_size_35_, 0(_let_c_34_)
	addi	x22, x18, 4
# was:	addi	_addrg_39_, _let_c_34_, 4
	mv	x21, x0
# was:	mv	_i_40_, x0
	addi	x23, x10, 4
# was:	addi	_elem_37_, _arr_36_, 4
l.loop_beg_41_:
	bge	x21, x19, l.loop_end_42_
# was:	bge	_i_40_, _size_35_, l.loop_end_42_
	lw	x10, 0(x23)
# was:	lw	_res_38_, 0(_elem_37_)
	addi	x23, x23, 4
# was:	addi	_elem_37_, _elem_37_, 4
	jal	p.getchar
# was:	jal	p.getchar, 
# 	mv	_fun_arg_res_43_,x10
# 	mv	_res_38_,_fun_arg_res_43_
	sb	x10, 0(x22)
# was:	sb	_res_38_, 0(_addrg_39_)
	addi	x22, x22, 1
# was:	addi	_addrg_39_, _addrg_39_, 1
	addi	x21, x21, 1
# was:	addi	_i_40_, _i_40_, 1
	j	l.loop_beg_41_
l.loop_end_42_:
	mv	x10, x18
# was:	mv	_arr_46_, _let_c_34_
	lw	x11, 0(x10)
# was:	lw	_size_47_, 0(_arr_46_)
	li	x19, 97
# was:	li	_let_m_45_, 97
	addi	x10, x10, 4
# was:	addi	_arr_46_, _arr_46_, 4
	mv	x12, x0
# was:	mv	_ind_var_48_, x0
l.loop_beg_50_:
	bge	x12, x11, l.loop_end_51_
# was:	bge	_ind_var_48_, _size_47_, l.loop_end_51_
	lbu	x13, 0(x10)
# was:	lbu	_tmp_49_, 0(_arr_46_)
	addi	x10, x10, 1
# was:	addi	_arr_46_, _arr_46_, 1
# 	mv	_lt_L_57_,_let_m_45_
# 	mv	_lt_R_58_,_tmp_49_
	slt	x14, x19, x13
# was:	slt	_cond_56_, _lt_L_57_, _lt_R_58_
	bne	x14, x0, l.then_53_
# was:	bne	_cond_56_, x0, l.then_53_
	j	l.else_54_
l.then_53_:
# 	mv	_fun_arg_res_52_,_tmp_49_
	j	l.endif_55_
l.else_54_:
	mv	x13, x19
# was:	mv	_fun_arg_res_52_, _let_m_45_
l.endif_55_:
	mv	x19, x13
# was:	mv	_let_m_45_, _fun_arg_res_52_
	addi	x12, x12, 1
# was:	addi	_ind_var_48_, _ind_var_48_, 1
	j	l.loop_beg_50_
l.loop_end_51_:
	la	x10, s.SumXX_61_
# was:	la	_tmp_60_, s.SumXX_61_
# s.SumXX_61_: string "Sum: "
# 	mv	_let_tmp_59_,_tmp_60_
# 	mv	x10,_tmp_60_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_tmp_63_,_let_d_24_
	mv	x10, x20
# was:	mv	_let_tmp_62_, _tmp_63_
# 	mv	x10,_let_tmp_62_
	jal	p.putint
# was:	jal	p.putint, x10
	la	x10, s.X_66_
# was:	la	_tmp_65_, s.X_66_
# s.X_66_: string "\n"
# 	mv	_let_tmp_64_,_tmp_65_
# 	mv	x10,_tmp_65_
	jal	p.putstring
# was:	jal	p.putstring, x10
	la	x10, s.MaxXcha_69_
# was:	la	_tmp_68_, s.MaxXcha_69_
# s.MaxXcha_69_: string "Max char: "
# 	mv	_let_tmp_67_,_tmp_68_
# 	mv	x10,_tmp_68_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_tmp_71_,_let_m_45_
	mv	x10, x19
# was:	mv	_let_tmp_70_, _tmp_71_
# 	mv	x10,_let_tmp_70_
	jal	p.putchar
# was:	jal	p.putchar, x10
	mv	x10, x18
# was:	mv	_mainres_1_, _let_c_34_
# 	mv	x10,_mainres_1_
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
s.MaxXcha_69_:
	.word	10
	.ascii	"Max char: "
	.align	2
s.X_66_:
	.word	1
	.ascii	"\n"
	.align	2
s.SumXX_61_:
	.word	5
	.ascii	"Sum: "
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