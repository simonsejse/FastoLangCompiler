	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x28, -48(x2)
	sw	x27, -44(x2)
	sw	x26, -40(x2)
	sw	x25, -36(x2)
	sw	x24, -32(x2)
	sw	x23, -28(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -48
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_n_2_,x10
	mv	x12, x10
# was:	mv	_size_8_, _let_n_2_
	bge	x12, x0, l.safe_9_
# was:	bge	_size_8_, x0, l.safe_9_
	li	x10, 11
# was:	li	x10, 11
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_9_:
	mv	x10, x3
# was:	mv	_arr_5_, x3
	slli	x11, x12, 2
# was:	slli	_tmp_14_, _size_8_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_14_, _tmp_14_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_14_
	sw	x12, 0(x10)
# was:	sw	_size_8_, 0(_arr_5_)
	addi	x11, x10, 4
# was:	addi	_addr_10_, _arr_5_, 4
	mv	x13, x0
# was:	mv	_i_11_, x0
l.loop_beg_12_:
	bge	x13, x12, l.loop_end_13_
# was:	bge	_i_11_, _size_8_, l.loop_end_13_
	sw	x13, 0(x11)
# was:	sw	_i_11_, 0(_addr_10_)
	addi	x11, x11, 4
# was:	addi	_addr_10_, _addr_10_, 4
	addi	x13, x13, 1
# was:	addi	_i_11_, _i_11_, 1
	j	l.loop_beg_12_
l.loop_end_13_:
	lw	x15, 0(x10)
# was:	lw	_size_4_, 0(_arr_5_)
	mv	x12, x3
# was:	mv	_let_a2d_3_, x3
	slli	x11, x15, 2
# was:	slli	_tmp_29_, _size_4_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_29_, _tmp_29_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_29_
	sw	x15, 0(x12)
# was:	sw	_size_4_, 0(_let_a2d_3_)
	addi	x13, x12, 4
# was:	addi	_addrg_15_, _let_a2d_3_, 4
	mv	x14, x0
# was:	mv	_i_16_, x0
	addi	x16, x10, 4
# was:	addi	_elem_6_, _arr_5_, 4
l.loop_beg_17_:
	bge	x14, x15, l.loop_end_18_
# was:	bge	_i_16_, _size_4_, l.loop_end_18_
	lw	x10, 0(x16)
# was:	lw	_res_7_, 0(_elem_6_)
	addi	x16, x16, 4
# was:	addi	_elem_6_, _elem_6_, 4
# 	mv	_plus_L_21_,_res_7_
	li	x11, 2
# was:	li	_plus_R_22_, 2
	add	x11, x10, x11
# was:	add	_size_20_, _plus_L_21_, _plus_R_22_
	bge	x11, x0, l.safe_23_
# was:	bge	_size_20_, x0, l.safe_23_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_23_:
	mv	x10, x3
# was:	mv	_fun_arg_res_19_, x3
	slli	x17, x11, 2
# was:	slli	_tmp_28_, _size_20_, 2
	addi	x17, x17, 4
# was:	addi	_tmp_28_, _tmp_28_, 4
	add	x3, x3, x17
# was:	add	x3, x3, _tmp_28_
	sw	x11, 0(x10)
# was:	sw	_size_20_, 0(_fun_arg_res_19_)
	addi	x18, x10, 4
# was:	addi	_addr_24_, _fun_arg_res_19_, 4
	mv	x17, x0
# was:	mv	_i_25_, x0
l.loop_beg_26_:
	bge	x17, x11, l.loop_end_27_
# was:	bge	_i_25_, _size_20_, l.loop_end_27_
	sw	x17, 0(x18)
# was:	sw	_i_25_, 0(_addr_24_)
	addi	x18, x18, 4
# was:	addi	_addr_24_, _addr_24_, 4
	addi	x17, x17, 1
# was:	addi	_i_25_, _i_25_, 1
	j	l.loop_beg_26_
l.loop_end_27_:
# 	mv	_res_7_,_fun_arg_res_19_
	sw	x10, 0(x13)
# was:	sw	_res_7_, 0(_addrg_15_)
	addi	x13, x13, 4
# was:	addi	_addrg_15_, _addrg_15_, 4
	addi	x14, x14, 1
# was:	addi	_i_16_, _i_16_, 1
	j	l.loop_beg_17_
l.loop_end_18_:
	mv	x11, x12
# was:	mv	_filter_arr_31_, _let_a2d_3_
	lw	x12, 0(x11)
# was:	lw	_filter_size_32_, 0(_filter_arr_31_)
	mv	x10, x3
# was:	mv	_let_a2df_30_, x3
	slli	x13, x12, 2
# was:	slli	_tmp_60_, _filter_size_32_, 2
	addi	x13, x13, 4
# was:	addi	_tmp_60_, _tmp_60_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_60_
	sw	x12, 0(x10)
# was:	sw	_filter_size_32_, 0(_let_a2df_30_)
	addi	x11, x11, 4
# was:	addi	_filter_arr_31_, _filter_arr_31_, 4
	mv	x13, x0
# was:	mv	_filter_i_36_, x0
	mv	x16, x0
# was:	mv	_filter_counter_35_, x0
	mv	x15, x10
# was:	mv	_filter_current_place_37_, _let_a2df_30_
	addi	x15, x15, 4
# was:	addi	_filter_current_place_37_, _filter_current_place_37_, 4
l.filter_start_38_:
	bge	x13, x12, l.filter_end_40_
# was:	bge	_filter_i_36_, _filter_size_32_, l.filter_end_40_
	lw	x14, 0(x11)
# was:	lw	_filter_elem_33_, 0(_filter_arr_31_)
	mv	x19, x14
# was:	mv	_arr_43_, _filter_elem_33_
	lw	x17, 0(x19)
# was:	lw	_size_44_, 0(_arr_43_)
	li	x21, 0
# was:	li	_let_r_42_, 0
	addi	x19, x19, 4
# was:	addi	_arr_43_, _arr_43_, 4
	mv	x18, x0
# was:	mv	_ind_var_45_, x0
l.loop_beg_47_:
	bge	x18, x17, l.loop_end_48_
# was:	bge	_ind_var_45_, _size_44_, l.loop_end_48_
	lw	x20, 0(x19)
# was:	lw	_tmp_46_, 0(_arr_43_)
	addi	x19, x19, 4
# was:	addi	_arr_43_, _arr_43_, 4
# 	mv	_plus_L_50_,_let_r_42_
# 	mv	_plus_R_51_,_tmp_46_
	add	x21, x21, x20
# was:	add	_fun_arg_res_49_, _plus_L_50_, _plus_R_51_
# 	mv	_let_r_42_,_fun_arg_res_49_
	addi	x18, x18, 1
# was:	addi	_ind_var_45_, _ind_var_45_, 1
	j	l.loop_beg_47_
l.loop_end_48_:
# 	mv	_div_L_56_,_let_r_42_
	li	x17, 2
# was:	li	_div_R_57_, 2
	bne	x17, x0, l.divZeroSafe_58_
# was:	bne	_div_R_57_, x0, l.divZeroSafe_58_
	li	x10, 6
# was:	li	x10, 6
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_58_:
	div	x18, x21, x17
# was:	div	_times_L_54_, _div_L_56_, _div_R_57_
	li	x17, 2
# was:	li	_times_R_55_, 2
	mul	x17, x18, x17
# was:	mul	_eq_L_52_, _times_L_54_, _times_R_55_
# 	mv	_eq_R_53_,_let_r_42_
	li	x18, 0
# was:	li	_fun_arg_res_41_, 0
	bne	x17, x21, l.false_59_
# was:	bne	_eq_L_52_, _eq_R_53_, l.false_59_
	li	x18, 1
# was:	li	_fun_arg_res_41_, 1
l.false_59_:
# 	mv	_filter_predicate_res_34_,_fun_arg_res_41_
	beq	x18, x0, l.filter_skip_39_
# was:	beq	_filter_predicate_res_34_, x0, l.filter_skip_39_
	sw	x14, 0(x15)
# was:	sw	_filter_elem_33_, 0(_filter_current_place_37_)
	addi	x15, x15, 4
# was:	addi	_filter_current_place_37_, _filter_current_place_37_, 4
	addi	x16, x16, 1
# was:	addi	_filter_counter_35_, _filter_counter_35_, 1
l.filter_skip_39_:
	addi	x11, x11, 4
# was:	addi	_filter_arr_31_, _filter_arr_31_, 4
	addi	x13, x13, 1
# was:	addi	_filter_i_36_, _filter_i_36_, 1
	j	l.filter_start_38_
l.filter_end_40_:
	sw	x16, 0(x10)
# was:	sw	_filter_counter_35_, 0(_let_a2df_30_)
# 	mv	_arr_62_,_let_a2df_30_
	lw	x21, 0(x10)
# was:	lw	_size_61_, 0(_arr_62_)
	mv	x20, x3
# was:	mv	_mainres_1_, x3
	slli	x11, x21, 2
# was:	slli	_tmp_81_, _size_61_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_81_, _tmp_81_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_81_
	sw	x21, 0(x20)
# was:	sw	_size_61_, 0(_mainres_1_)
	addi	x23, x20, 4
# was:	addi	_addrg_65_, _mainres_1_, 4
	mv	x22, x0
# was:	mv	_i_66_, x0
	addi	x24, x10, 4
# was:	addi	_elem_63_, _arr_62_, 4
l.loop_beg_67_:
	bge	x22, x21, l.loop_end_68_
# was:	bge	_i_66_, _size_61_, l.loop_end_68_
	lw	x10, 0(x24)
# was:	lw	_res_64_, 0(_elem_63_)
	addi	x24, x24, 4
# was:	addi	_elem_63_, _elem_63_, 4
# 	mv	_arr_71_,_res_64_
	lw	x25, 0(x10)
# was:	lw	_size_70_, 0(_arr_71_)
	mv	x26, x3
# was:	mv	_fun_arg_res_69_, x3
	slli	x11, x25, 2
# was:	slli	_tmp_80_, _size_70_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_80_, _tmp_80_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_80_
	sw	x25, 0(x26)
# was:	sw	_size_70_, 0(_fun_arg_res_69_)
	addi	x18, x26, 4
# was:	addi	_addrg_74_, _fun_arg_res_69_, 4
	mv	x19, x0
# was:	mv	_i_75_, x0
	addi	x27, x10, 4
# was:	addi	_elem_72_, _arr_71_, 4
l.loop_beg_76_:
	bge	x19, x25, l.loop_end_77_
# was:	bge	_i_75_, _size_70_, l.loop_end_77_
	lw	x28, 0(x27)
# was:	lw	_res_73_, 0(_elem_72_)
	addi	x27, x27, 4
# was:	addi	_elem_72_, _elem_72_, 4
# 	mv	_tmp_79_,_res_73_
# 	mv	_fun_arg_res_78_,_tmp_79_
	mv	x10, x28
# was:	mv	x10, _fun_arg_res_78_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_73_,_fun_arg_res_78_
	sw	x28, 0(x18)
# was:	sw	_res_73_, 0(_addrg_74_)
	addi	x18, x18, 4
# was:	addi	_addrg_74_, _addrg_74_, 4
	addi	x19, x19, 1
# was:	addi	_i_75_, _i_75_, 1
	j	l.loop_beg_76_
l.loop_end_77_:
	mv	x10, x26
# was:	mv	_res_64_, _fun_arg_res_69_
	sw	x10, 0(x23)
# was:	sw	_res_64_, 0(_addrg_65_)
	addi	x23, x23, 4
# was:	addi	_addrg_65_, _addrg_65_, 4
	addi	x22, x22, 1
# was:	addi	_i_66_, _i_66_, 1
	j	l.loop_beg_67_
l.loop_end_68_:
	mv	x10, x20
# was:	mv	x10, _mainres_1_
	addi	x2, x2, 48
	lw	x28, -48(x2)
	lw	x27, -44(x2)
	lw	x26, -40(x2)
	lw	x25, -36(x2)
	lw	x24, -32(x2)
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