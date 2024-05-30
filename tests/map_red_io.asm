	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function plus100
f.plus100:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_1_,x10
	mv	x11, x10
# was:	mv	_plus_L_3_, _param_x_1_
	li	x10, 100
# was:	li	_plus_R_4_, 100
	add	x10, x11, x10
# was:	add	_plus100res_2_, _plus_L_3_, _plus_R_4_
# 	mv	x10,_plus100res_2_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function read_chr
f.read_chr:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_i_5_,x10
	jal	p.getchar
# was:	jal	p.getchar, 
# 	mv	_read_chrres_6_,x10
# 	mv	x10,_read_chrres_6_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function plus
f.plus:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_7_,x10
# 	mv	_param_y_8_,x11
# 	mv	_plus_L_10_,_param_x_7_
# 	mv	_plus_R_11_,_param_y_8_
	add	x10, x10, x11
# was:	add	_plusres_9_, _plus_L_10_, _plus_R_11_
# 	mv	x10,_plusres_9_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function max_chr
f.max_chr:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_12_,x10
# 	mv	_param_b_13_,x11
# 	mv	_lt_L_19_,_param_a_12_
# 	mv	_lt_R_20_,_param_b_13_
	slt	x12, x10, x11
# was:	slt	_cond_18_, _lt_L_19_, _lt_R_20_
	bne	x12, x0, l.then_15_
# was:	bne	_cond_18_, x0, l.then_15_
	j	l.else_16_
l.then_15_:
	mv	x10, x11
# was:	mv	_max_chrres_14_, _param_b_13_
	j	l.endif_17_
l.else_16_:
# 	mv	_max_chrres_14_,_param_a_12_
l.endif_17_:
# 	mv	x10,_max_chrres_14_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
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
# 	mv	_let_n_22_,x10
# 	mv	_size_24_,_let_n_22_
	bge	x10, x0, l.safe_25_
# was:	bge	_size_24_, x0, l.safe_25_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_25_:
	mv	x18, x3
# was:	mv	_let_a_23_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_30_, _size_24_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_30_, _tmp_30_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_30_
	sw	x10, 0(x18)
# was:	sw	_size_24_, 0(_let_a_23_)
	addi	x11, x18, 4
# was:	addi	_addr_26_, _let_a_23_, 4
	mv	x12, x0
# was:	mv	_i_27_, x0
l.loop_beg_28_:
	bge	x12, x10, l.loop_end_29_
# was:	bge	_i_27_, _size_24_, l.loop_end_29_
	sw	x12, 0(x11)
# was:	sw	_i_27_, 0(_addr_26_)
	addi	x11, x11, 4
# was:	addi	_addr_26_, _addr_26_, 4
	addi	x12, x12, 1
# was:	addi	_i_27_, _i_27_, 1
	j	l.loop_beg_28_
l.loop_end_29_:
# 	mv	_arr_33_,_let_a_23_
	lw	x20, 0(x18)
# was:	lw	_size_32_, 0(_arr_33_)
	mv	x21, x3
# was:	mv	_let_b_31_, x3
	slli	x10, x20, 2
# was:	slli	_tmp_41_, _size_32_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_41_, _tmp_41_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_41_
	sw	x20, 0(x21)
# was:	sw	_size_32_, 0(_let_b_31_)
	addi	x22, x21, 4
# was:	addi	_addrg_36_, _let_b_31_, 4
	mv	x23, x0
# was:	mv	_i_37_, x0
	addi	x19, x18, 4
# was:	addi	_elem_34_, _arr_33_, 4
l.loop_beg_38_:
	bge	x23, x20, l.loop_end_39_
# was:	bge	_i_37_, _size_32_, l.loop_end_39_
	lw	x10, 0(x19)
# was:	lw	_res_35_, 0(_elem_34_)
	addi	x19, x19, 4
# was:	addi	_elem_34_, _elem_34_, 4
# 	mv	x10,_res_35_
	jal	f.plus100
# was:	jal	f.plus100, x10
# 	mv	_tmp_40_,x10
# 	mv	_res_35_,_tmp_40_
	sw	x10, 0(x22)
# was:	sw	_res_35_, 0(_addrg_36_)
	addi	x22, x22, 4
# was:	addi	_addrg_36_, _addrg_36_, 4
	addi	x23, x23, 1
# was:	addi	_i_37_, _i_37_, 1
	j	l.loop_beg_38_
l.loop_end_39_:
# 	mv	_arr_43_,_let_b_31_
	lw	x20, 0(x21)
# was:	lw	_size_44_, 0(_arr_43_)
	li	x19, 0
# was:	li	_let_d_42_, 0
	addi	x21, x21, 4
# was:	addi	_arr_43_, _arr_43_, 4
	mv	x22, x0
# was:	mv	_ind_var_45_, x0
l.loop_beg_47_:
	bge	x22, x20, l.loop_end_48_
# was:	bge	_ind_var_45_, _size_44_, l.loop_end_48_
	lw	x11, 0(x21)
# was:	lw	_tmp_46_, 0(_arr_43_)
	addi	x21, x21, 4
# was:	addi	_arr_43_, _arr_43_, 4
	mv	x10, x19
# was:	mv	x10, _let_d_42_
# 	mv	x11,_tmp_46_
	jal	f.plus
# was:	jal	f.plus, x10 x11
# 	mv	_tmp_49_,x10
	mv	x19, x10
# was:	mv	_let_d_42_, _tmp_49_
	addi	x22, x22, 1
# was:	addi	_ind_var_45_, _ind_var_45_, 1
	j	l.loop_beg_47_
l.loop_end_48_:
	mv	x10, x18
# was:	mv	_arr_52_, _let_a_23_
	lw	x20, 0(x10)
# was:	lw	_size_51_, 0(_arr_52_)
	mv	x18, x3
# was:	mv	_let_c_50_, x3
	addi	x11, x20, 3
# was:	addi	_tmp_60_, _size_51_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_60_, _tmp_60_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_60_, _tmp_60_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_60_
	sw	x20, 0(x18)
# was:	sw	_size_51_, 0(_let_c_50_)
	addi	x22, x18, 4
# was:	addi	_addrg_55_, _let_c_50_, 4
	mv	x21, x0
# was:	mv	_i_56_, x0
	addi	x23, x10, 4
# was:	addi	_elem_53_, _arr_52_, 4
l.loop_beg_57_:
	bge	x21, x20, l.loop_end_58_
# was:	bge	_i_56_, _size_51_, l.loop_end_58_
	lw	x10, 0(x23)
# was:	lw	_res_54_, 0(_elem_53_)
	addi	x23, x23, 4
# was:	addi	_elem_53_, _elem_53_, 4
# 	mv	x10,_res_54_
	jal	f.read_chr
# was:	jal	f.read_chr, x10
# 	mv	_tmp_59_,x10
# 	mv	_res_54_,_tmp_59_
	sb	x10, 0(x22)
# was:	sb	_res_54_, 0(_addrg_55_)
	addi	x22, x22, 1
# was:	addi	_addrg_55_, _addrg_55_, 1
	addi	x21, x21, 1
# was:	addi	_i_56_, _i_56_, 1
	j	l.loop_beg_57_
l.loop_end_58_:
	mv	x21, x18
# was:	mv	_arr_62_, _let_c_50_
	lw	x22, 0(x21)
# was:	lw	_size_63_, 0(_arr_62_)
	li	x20, 97
# was:	li	_let_m_61_, 97
	addi	x21, x21, 4
# was:	addi	_arr_62_, _arr_62_, 4
	mv	x23, x0
# was:	mv	_ind_var_64_, x0
l.loop_beg_66_:
	bge	x23, x22, l.loop_end_67_
# was:	bge	_ind_var_64_, _size_63_, l.loop_end_67_
	lbu	x11, 0(x21)
# was:	lbu	_tmp_65_, 0(_arr_62_)
	addi	x21, x21, 1
# was:	addi	_arr_62_, _arr_62_, 1
	mv	x10, x20
# was:	mv	x10, _let_m_61_
# 	mv	x11,_tmp_65_
	jal	f.max_chr
# was:	jal	f.max_chr, x10 x11
# 	mv	_tmp_68_,x10
	mv	x20, x10
# was:	mv	_let_m_61_, _tmp_68_
	addi	x23, x23, 1
# was:	addi	_ind_var_64_, _ind_var_64_, 1
	j	l.loop_beg_66_
l.loop_end_67_:
	la	x10, s.SumXX_71_
# was:	la	_tmp_70_, s.SumXX_71_
# s.SumXX_71_: string "Sum: "
# 	mv	_let_tmp_69_,_tmp_70_
# 	mv	x10,_tmp_70_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x19
# was:	mv	_tmp_73_, _let_d_42_
# 	mv	_let_tmp_72_,_tmp_73_
# 	mv	x10,_let_tmp_72_
	jal	p.putint
# was:	jal	p.putint, x10
	la	x10, s.X_76_
# was:	la	_tmp_75_, s.X_76_
# s.X_76_: string "\n"
# 	mv	_let_tmp_74_,_tmp_75_
# 	mv	x10,_tmp_75_
	jal	p.putstring
# was:	jal	p.putstring, x10
	la	x10, s.MaxXcha_79_
# was:	la	_tmp_78_, s.MaxXcha_79_
# s.MaxXcha_79_: string "Max char: "
# 	mv	_let_tmp_77_,_tmp_78_
# 	mv	x10,_tmp_78_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_tmp_81_,_let_m_61_
	mv	x10, x20
# was:	mv	_let_tmp_80_, _tmp_81_
# 	mv	x10,_let_tmp_80_
	jal	p.putchar
# was:	jal	p.putchar, x10
	mv	x10, x18
# was:	mv	_mainres_21_, _let_c_50_
# 	mv	x10,_mainres_21_
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
s.MaxXcha_79_:
	.word	10
	.ascii	"Max char: "
	.align	2
s.X_76_:
	.word	1
	.ascii	"\n"
	.align	2
s.SumXX_71_:
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