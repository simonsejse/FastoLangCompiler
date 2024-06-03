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
# 	mv	_size_5_,_let_n_2_
	bge	x10, x0, l.safe_6_
# was:	bge	_size_5_, x0, l.safe_6_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_6_:
	mv	x13, x3
# was:	mv	_filter_arr_4_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_11_, _size_5_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_11_, _tmp_11_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_11_
	sw	x10, 0(x13)
# was:	sw	_size_5_, 0(_filter_arr_4_)
	addi	x11, x13, 4
# was:	addi	_addr_7_, _filter_arr_4_, 4
	mv	x12, x0
# was:	mv	_i_8_, x0
l.loop_beg_9_:
	bge	x12, x10, l.loop_end_10_
# was:	bge	_i_8_, _size_5_, l.loop_end_10_
	sw	x12, 0(x11)
# was:	sw	_i_8_, 0(_addr_7_)
	addi	x11, x11, 4
# was:	addi	_addr_7_, _addr_7_, 4
	addi	x12, x12, 1
# was:	addi	_i_8_, _i_8_, 1
	j	l.loop_beg_9_
l.loop_end_10_:
	lw	x15, 0(x13)
# was:	lw	_filter_size_12_, 0(_filter_arr_4_)
	mv	x14, x3
# was:	mv	_let_x_3_, x3
	slli	x10, x15, 2
# was:	slli	_tmp_30_, _filter_size_12_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_30_, _tmp_30_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_30_
	sw	x15, 0(x14)
# was:	sw	_filter_size_12_, 0(_let_x_3_)
	addi	x13, x13, 4
# was:	addi	_filter_arr_4_, _filter_arr_4_, 4
	mv	x11, x0
# was:	mv	_filter_i_16_, x0
	mv	x10, x0
# was:	mv	_filter_counter_15_, x0
	mv	x12, x14
# was:	mv	_filter_current_place_17_, _let_x_3_
	addi	x12, x12, 4
# was:	addi	_filter_current_place_17_, _filter_current_place_17_, 4
l.filter_start_18_:
	bge	x11, x15, l.filter_end_20_
# was:	bge	_filter_i_16_, _filter_size_12_, l.filter_end_20_
	lw	x18, 0(x13)
# was:	lw	_filter_elem_13_, 0(_filter_arr_4_)
# 	mv	_eq_L_22_,_filter_elem_13_
	mv	x17, x18
# was:	mv	_div_L_26_, _filter_elem_13_
	li	x16, 2
# was:	li	_div_R_27_, 2
	bne	x16, x0, l.divZeroSafe_28_
# was:	bne	_div_R_27_, x0, l.divZeroSafe_28_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_28_:
	div	x17, x17, x16
# was:	div	_times_L_24_, _div_L_26_, _div_R_27_
	li	x16, 2
# was:	li	_times_R_25_, 2
	mul	x17, x17, x16
# was:	mul	_eq_R_23_, _times_L_24_, _times_R_25_
	li	x16, 0
# was:	li	_fun_arg_res_21_, 0
	bne	x18, x17, l.false_29_
# was:	bne	_eq_L_22_, _eq_R_23_, l.false_29_
	li	x16, 1
# was:	li	_fun_arg_res_21_, 1
l.false_29_:
# 	mv	_filter_predicate_res_14_,_fun_arg_res_21_
	beq	x16, x0, l.filter_skip_19_
# was:	beq	_filter_predicate_res_14_, x0, l.filter_skip_19_
	sw	x18, 0(x12)
# was:	sw	_filter_elem_13_, 0(_filter_current_place_17_)
	addi	x12, x12, 4
# was:	addi	_filter_current_place_17_, _filter_current_place_17_, 4
	addi	x10, x10, 1
# was:	addi	_filter_counter_15_, _filter_counter_15_, 1
l.filter_skip_19_:
	addi	x13, x13, 4
# was:	addi	_filter_arr_4_, _filter_arr_4_, 4
	addi	x11, x11, 1
# was:	addi	_filter_i_16_, _filter_i_16_, 1
	j	l.filter_start_18_
l.filter_end_20_:
	sw	x10, 0(x14)
# was:	sw	_filter_counter_15_, 0(_let_x_3_)
# 	mv	_arr_33_,_let_x_3_
	lw	x11, 0(x14)
# was:	lw	_size_32_, 0(_arr_33_)
	mv	x15, x3
# was:	mv	_let_y_31_, x3
	slli	x10, x11, 2
# was:	slli	_tmp_43_, _size_32_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_43_, _tmp_43_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_43_
	sw	x11, 0(x15)
# was:	sw	_size_32_, 0(_let_y_31_)
	addi	x12, x15, 4
# was:	addi	_addrg_36_, _let_y_31_, 4
	mv	x13, x0
# was:	mv	_i_37_, x0
	addi	x10, x14, 4
# was:	addi	_elem_34_, _arr_33_, 4
l.loop_beg_38_:
	bge	x13, x11, l.loop_end_39_
# was:	bge	_i_37_, _size_32_, l.loop_end_39_
	lw	x14, 0(x10)
# was:	lw	_res_35_, 0(_elem_34_)
	addi	x10, x10, 4
# was:	addi	_elem_34_, _elem_34_, 4
# 	mv	_times_L_41_,_res_35_
	mv	x16, x14
# was:	mv	_times_R_42_, _res_35_
	mul	x14, x14, x16
# was:	mul	_fun_arg_res_40_, _times_L_41_, _times_R_42_
# 	mv	_res_35_,_fun_arg_res_40_
	sw	x14, 0(x12)
# was:	sw	_res_35_, 0(_addrg_36_)
	addi	x12, x12, 4
# was:	addi	_addrg_36_, _addrg_36_, 4
	addi	x13, x13, 1
# was:	addi	_i_37_, _i_37_, 1
	j	l.loop_beg_38_
l.loop_end_39_:
# 	mv	_filter_arr_45_,_let_y_31_
	lw	x14, 0(x15)
# was:	lw	_filter_size_46_, 0(_filter_arr_45_)
	mv	x13, x3
# was:	mv	_let_z_44_, x3
	slli	x10, x14, 2
# was:	slli	_tmp_64_, _filter_size_46_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_64_, _tmp_64_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_64_
	sw	x14, 0(x13)
# was:	sw	_filter_size_46_, 0(_let_z_44_)
	addi	x15, x15, 4
# was:	addi	_filter_arr_45_, _filter_arr_45_, 4
	mv	x11, x0
# was:	mv	_filter_i_50_, x0
	mv	x10, x0
# was:	mv	_filter_counter_49_, x0
	mv	x12, x13
# was:	mv	_filter_current_place_51_, _let_z_44_
	addi	x12, x12, 4
# was:	addi	_filter_current_place_51_, _filter_current_place_51_, 4
l.filter_start_52_:
	bge	x11, x14, l.filter_end_54_
# was:	bge	_filter_i_50_, _filter_size_46_, l.filter_end_54_
	lw	x18, 0(x15)
# was:	lw	_filter_elem_47_, 0(_filter_arr_45_)
# 	mv	_div_L_60_,_filter_elem_47_
	li	x16, 16
# was:	li	_div_R_61_, 16
	bne	x16, x0, l.divZeroSafe_62_
# was:	bne	_div_R_61_, x0, l.divZeroSafe_62_
	li	x10, 6
# was:	li	x10, 6
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_62_:
	div	x16, x18, x16
# was:	div	_times_L_58_, _div_L_60_, _div_R_61_
	li	x17, 16
# was:	li	_times_R_59_, 16
	mul	x16, x16, x17
# was:	mul	_eq_L_56_, _times_L_58_, _times_R_59_
# 	mv	_eq_R_57_,_filter_elem_47_
	li	x17, 0
# was:	li	_fun_arg_res_55_, 0
	bne	x16, x18, l.false_63_
# was:	bne	_eq_L_56_, _eq_R_57_, l.false_63_
	li	x17, 1
# was:	li	_fun_arg_res_55_, 1
l.false_63_:
# 	mv	_filter_predicate_res_48_,_fun_arg_res_55_
	beq	x17, x0, l.filter_skip_53_
# was:	beq	_filter_predicate_res_48_, x0, l.filter_skip_53_
	sw	x18, 0(x12)
# was:	sw	_filter_elem_47_, 0(_filter_current_place_51_)
	addi	x12, x12, 4
# was:	addi	_filter_current_place_51_, _filter_current_place_51_, 4
	addi	x10, x10, 1
# was:	addi	_filter_counter_49_, _filter_counter_49_, 1
l.filter_skip_53_:
	addi	x15, x15, 4
# was:	addi	_filter_arr_45_, _filter_arr_45_, 4
	addi	x11, x11, 1
# was:	addi	_filter_i_50_, _filter_i_50_, 1
	j	l.filter_start_52_
l.filter_end_54_:
	sw	x10, 0(x13)
# was:	sw	_filter_counter_49_, 0(_let_z_44_)
# 	mv	_arr_66_,_let_z_44_
	lw	x18, 0(x13)
# was:	lw	_size_65_, 0(_arr_66_)
	mv	x19, x3
# was:	mv	_mainres_1_, x3
	slli	x10, x18, 2
# was:	slli	_tmp_75_, _size_65_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_75_, _tmp_75_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_75_
	sw	x18, 0(x19)
# was:	sw	_size_65_, 0(_mainres_1_)
	addi	x20, x19, 4
# was:	addi	_addrg_69_, _mainres_1_, 4
	mv	x21, x0
# was:	mv	_i_70_, x0
	addi	x22, x13, 4
# was:	addi	_elem_67_, _arr_66_, 4
l.loop_beg_71_:
	bge	x21, x18, l.loop_end_72_
# was:	bge	_i_70_, _size_65_, l.loop_end_72_
	lw	x23, 0(x22)
# was:	lw	_res_68_, 0(_elem_67_)
	addi	x22, x22, 4
# was:	addi	_elem_67_, _elem_67_, 4
# 	mv	_tmp_74_,_res_68_
# 	mv	_fun_arg_res_73_,_tmp_74_
	mv	x10, x23
# was:	mv	x10, _fun_arg_res_73_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_68_,_fun_arg_res_73_
	sw	x23, 0(x20)
# was:	sw	_res_68_, 0(_addrg_69_)
	addi	x20, x20, 4
# was:	addi	_addrg_69_, _addrg_69_, 4
	addi	x21, x21, 1
# was:	addi	_i_70_, _i_70_, 1
	j	l.loop_beg_71_
l.loop_end_72_:
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