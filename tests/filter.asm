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
# Function isMul16
f.isMul16:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_16_,x10
# 	mv	_div_L_22_,_param_a_16_
	li	x11, 16
# was:	li	_div_R_23_, 16
	bne	x11, x0, l.divZeroSafe_24_
# was:	bne	_div_R_23_, x0, l.divZeroSafe_24_
	li	x10, 6
# was:	li	x10, 6
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_24_:
	div	x12, x10, x11
# was:	div	_times_L_20_, _div_L_22_, _div_R_23_
	li	x11, 16
# was:	li	_times_R_21_, 16
	mul	x11, x12, x11
# was:	mul	_eq_L_18_, _times_L_20_, _times_R_21_
	mv	x12, x10
# was:	mv	_eq_R_19_, _param_a_16_
	li	x10, 0
# was:	li	_isMul16res_17_, 0
	bne	x11, x12, l.false_25_
# was:	bne	_eq_L_18_, _eq_R_19_, l.false_25_
	li	x10, 1
# was:	li	_isMul16res_17_, 1
l.false_25_:
# 	mv	x10,_isMul16res_17_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x24, -32(x2)
	sw	x23, -28(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -32
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_n_27_,x10
	mv	x11, x10
# was:	mv	_size_30_, _let_n_27_
	bge	x11, x0, l.safe_31_
# was:	bge	_size_30_, x0, l.safe_31_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_31_:
	mv	x10, x3
# was:	mv	_filter_arr_29_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_36_, _size_30_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_36_, _tmp_36_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_36_
	sw	x11, 0(x10)
# was:	sw	_size_30_, 0(_filter_arr_29_)
	addi	x12, x10, 4
# was:	addi	_addr_32_, _filter_arr_29_, 4
	mv	x13, x0
# was:	mv	_i_33_, x0
l.loop_beg_34_:
	bge	x13, x11, l.loop_end_35_
# was:	bge	_i_33_, _size_30_, l.loop_end_35_
	sw	x13, 0(x12)
# was:	sw	_i_33_, 0(_addr_32_)
	addi	x12, x12, 4
# was:	addi	_addr_32_, _addr_32_, 4
	addi	x13, x13, 1
# was:	addi	_i_33_, _i_33_, 1
	j	l.loop_beg_34_
l.loop_end_35_:
	lw	x11, 0(x10)
# was:	lw	_filter_size_37_, 0(_filter_arr_29_)
	mv	x12, x3
# was:	mv	_let_x_28_, x3
	slli	x13, x11, 2
# was:	slli	_tmp_55_, _filter_size_37_, 2
	addi	x13, x13, 4
# was:	addi	_tmp_55_, _tmp_55_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_55_
	sw	x11, 0(x12)
# was:	sw	_filter_size_37_, 0(_let_x_28_)
	addi	x10, x10, 4
# was:	addi	_filter_arr_29_, _filter_arr_29_, 4
	mv	x13, x0
# was:	mv	_filter_i_41_, x0
	mv	x15, x0
# was:	mv	_filter_counter_40_, x0
	mv	x14, x12
# was:	mv	_filter_current_place_42_, _let_x_28_
	addi	x14, x14, 4
# was:	addi	_filter_current_place_42_, _filter_current_place_42_, 4
l.filter_start_43_:
	bge	x13, x11, l.filter_end_45_
# was:	bge	_filter_i_41_, _filter_size_37_, l.filter_end_45_
	lw	x18, 0(x10)
# was:	lw	_filter_elem_38_, 0(_filter_arr_29_)
# 	mv	_eq_L_47_,_filter_elem_38_
	mv	x17, x18
# was:	mv	_div_L_51_, _filter_elem_38_
	li	x16, 2
# was:	li	_div_R_52_, 2
	bne	x16, x0, l.divZeroSafe_53_
# was:	bne	_div_R_52_, x0, l.divZeroSafe_53_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_53_:
	div	x17, x17, x16
# was:	div	_times_L_49_, _div_L_51_, _div_R_52_
	li	x16, 2
# was:	li	_times_R_50_, 2
	mul	x16, x17, x16
# was:	mul	_eq_R_48_, _times_L_49_, _times_R_50_
	li	x17, 0
# was:	li	_fun_arg_res_46_, 0
	bne	x18, x16, l.false_54_
# was:	bne	_eq_L_47_, _eq_R_48_, l.false_54_
	li	x17, 1
# was:	li	_fun_arg_res_46_, 1
l.false_54_:
# 	mv	_filter_predicate_res_39_,_fun_arg_res_46_
	beq	x17, x0, l.filter_skip_44_
# was:	beq	_filter_predicate_res_39_, x0, l.filter_skip_44_
	sw	x18, 0(x14)
# was:	sw	_filter_elem_38_, 0(_filter_current_place_42_)
	addi	x14, x14, 4
# was:	addi	_filter_current_place_42_, _filter_current_place_42_, 4
	addi	x15, x15, 1
# was:	addi	_filter_counter_40_, _filter_counter_40_, 1
l.filter_skip_44_:
	addi	x10, x10, 4
# was:	addi	_filter_arr_29_, _filter_arr_29_, 4
	addi	x13, x13, 1
# was:	addi	_filter_i_41_, _filter_i_41_, 1
	j	l.filter_start_43_
l.filter_end_45_:
	sw	x15, 0(x12)
# was:	sw	_filter_counter_40_, 0(_let_x_28_)
	mv	x13, x12
# was:	mv	_arr_58_, _let_x_28_
	lw	x10, 0(x13)
# was:	lw	_size_57_, 0(_arr_58_)
	mv	x18, x3
# was:	mv	_let_y_56_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_68_, _size_57_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_68_, _tmp_68_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_68_
	sw	x10, 0(x18)
# was:	sw	_size_57_, 0(_let_y_56_)
	addi	x12, x18, 4
# was:	addi	_addrg_61_, _let_y_56_, 4
	mv	x11, x0
# was:	mv	_i_62_, x0
	addi	x13, x13, 4
# was:	addi	_elem_59_, _arr_58_, 4
l.loop_beg_63_:
	bge	x11, x10, l.loop_end_64_
# was:	bge	_i_62_, _size_57_, l.loop_end_64_
	lw	x14, 0(x13)
# was:	lw	_res_60_, 0(_elem_59_)
	addi	x13, x13, 4
# was:	addi	_elem_59_, _elem_59_, 4
	mv	x15, x14
# was:	mv	_times_L_66_, _res_60_
# 	mv	_times_R_67_,_res_60_
	mul	x14, x15, x14
# was:	mul	_fun_arg_res_65_, _times_L_66_, _times_R_67_
# 	mv	_res_60_,_fun_arg_res_65_
	sw	x14, 0(x12)
# was:	sw	_res_60_, 0(_addrg_61_)
	addi	x12, x12, 4
# was:	addi	_addrg_61_, _addrg_61_, 4
	addi	x11, x11, 1
# was:	addi	_i_62_, _i_62_, 1
	j	l.loop_beg_63_
l.loop_end_64_:
# 	mv	_filter_arr_70_,_let_y_56_
	lw	x19, 0(x18)
# was:	lw	_filter_size_71_, 0(_filter_arr_70_)
	mv	x20, x3
# was:	mv	_let_z_69_, x3
	slli	x10, x19, 2
# was:	slli	_tmp_81_, _filter_size_71_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_81_, _tmp_81_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_81_
	sw	x19, 0(x20)
# was:	sw	_filter_size_71_, 0(_let_z_69_)
	addi	x18, x18, 4
# was:	addi	_filter_arr_70_, _filter_arr_70_, 4
	mv	x21, x0
# was:	mv	_filter_i_75_, x0
	mv	x24, x0
# was:	mv	_filter_counter_74_, x0
	mv	x22, x20
# was:	mv	_filter_current_place_76_, _let_z_69_
	addi	x22, x22, 4
# was:	addi	_filter_current_place_76_, _filter_current_place_76_, 4
l.filter_start_77_:
	bge	x21, x19, l.filter_end_79_
# was:	bge	_filter_i_75_, _filter_size_71_, l.filter_end_79_
	lw	x23, 0(x18)
# was:	lw	_filter_elem_72_, 0(_filter_arr_70_)
	mv	x10, x23
# was:	mv	x10, _filter_elem_72_
	jal	f.isMul16
# was:	jal	f.isMul16, x10
# 	mv	_tmp_80_,x10
# 	mv	_filter_predicate_res_73_,_tmp_80_
	beq	x10, x0, l.filter_skip_78_
# was:	beq	_filter_predicate_res_73_, x0, l.filter_skip_78_
	sw	x23, 0(x22)
# was:	sw	_filter_elem_72_, 0(_filter_current_place_76_)
	addi	x22, x22, 4
# was:	addi	_filter_current_place_76_, _filter_current_place_76_, 4
	addi	x24, x24, 1
# was:	addi	_filter_counter_74_, _filter_counter_74_, 1
l.filter_skip_78_:
	addi	x18, x18, 4
# was:	addi	_filter_arr_70_, _filter_arr_70_, 4
	addi	x21, x21, 1
# was:	addi	_filter_i_75_, _filter_i_75_, 1
	j	l.filter_start_77_
l.filter_end_79_:
	sw	x24, 0(x20)
# was:	sw	_filter_counter_74_, 0(_let_z_69_)
	mv	x10, x20
# was:	mv	_arg_82_, _let_z_69_
# 	mv	x10,_arg_82_
	jal	f.write_int_arr
# was:	jal	f.write_int_arr, x10
# 	mv	_mainres_26_,x10
# 	mv	x10,_mainres_26_
	addi	x2, x2, 32
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