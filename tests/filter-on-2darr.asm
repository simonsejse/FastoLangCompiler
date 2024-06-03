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
# Function write_1darr
f.write_1darr:
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
# was:	mv	_write_1darrres_5_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_15_, _size_6_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_15_
	sw	x18, 0(x19)
# was:	sw	_size_6_, 0(_write_1darrres_5_)
	addi	x20, x19, 4
# was:	addi	_addrg_10_, _write_1darrres_5_, 4
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
# was:	mv	x10, _write_1darrres_5_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function write_2darr
f.write_2darr:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_x_16_,x10
# 	mv	_arr_19_,_param_x_16_
	lw	x18, 0(x10)
# was:	lw	_size_18_, 0(_arr_19_)
	mv	x19, x3
# was:	mv	_write_2darrres_17_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_27_, _size_18_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_27_, _tmp_27_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_27_
	sw	x18, 0(x19)
# was:	sw	_size_18_, 0(_write_2darrres_17_)
	addi	x20, x19, 4
# was:	addi	_addrg_22_, _write_2darrres_17_, 4
	mv	x21, x0
# was:	mv	_i_23_, x0
	addi	x22, x10, 4
# was:	addi	_elem_20_, _arr_19_, 4
l.loop_beg_24_:
	bge	x21, x18, l.loop_end_25_
# was:	bge	_i_23_, _size_18_, l.loop_end_25_
	lw	x10, 0(x22)
# was:	lw	_res_21_, 0(_elem_20_)
	addi	x22, x22, 4
# was:	addi	_elem_20_, _elem_20_, 4
# 	mv	x10,_res_21_
	jal	f.write_1darr
# was:	jal	f.write_1darr, x10
# 	mv	_tmp_26_,x10
# 	mv	_res_21_,_tmp_26_
	sw	x10, 0(x20)
# was:	sw	_res_21_, 0(_addrg_22_)
	addi	x20, x20, 4
# was:	addi	_addrg_22_, _addrg_22_, 4
	addi	x21, x21, 1
# was:	addi	_i_23_, _i_23_, 1
	j	l.loop_beg_24_
l.loop_end_25_:
	mv	x10, x19
# was:	mv	x10, _write_2darrres_17_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function even
f.even:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_28_,x10
# 	mv	_div_L_34_,_param_a_28_
	li	x11, 2
# was:	li	_div_R_35_, 2
	bne	x11, x0, l.divZeroSafe_36_
# was:	bne	_div_R_35_, x0, l.divZeroSafe_36_
	li	x10, 6
# was:	li	x10, 6
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_36_:
	div	x12, x10, x11
# was:	div	_times_L_32_, _div_L_34_, _div_R_35_
	li	x11, 2
# was:	li	_times_R_33_, 2
	mul	x11, x12, x11
# was:	mul	_eq_L_30_, _times_L_32_, _times_R_33_
	mv	x12, x10
# was:	mv	_eq_R_31_, _param_a_28_
	li	x10, 0
# was:	li	_evenres_29_, 0
	bne	x11, x12, l.false_37_
# was:	bne	_eq_L_30_, _eq_R_31_, l.false_37_
	li	x10, 1
# was:	li	_evenres_29_, 1
l.false_37_:
# 	mv	x10,_evenres_29_
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
# 	mv	_let_n_39_,x10
# 	mv	_size_45_,_let_n_39_
	bge	x10, x0, l.safe_46_
# was:	bge	_size_45_, x0, l.safe_46_
	li	x10, 11
# was:	li	x10, 11
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_46_:
	mv	x13, x3
# was:	mv	_arr_42_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_51_, _size_45_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_51_, _tmp_51_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_51_
	sw	x10, 0(x13)
# was:	sw	_size_45_, 0(_arr_42_)
	addi	x12, x13, 4
# was:	addi	_addr_47_, _arr_42_, 4
	mv	x11, x0
# was:	mv	_i_48_, x0
l.loop_beg_49_:
	bge	x11, x10, l.loop_end_50_
# was:	bge	_i_48_, _size_45_, l.loop_end_50_
	sw	x11, 0(x12)
# was:	sw	_i_48_, 0(_addr_47_)
	addi	x12, x12, 4
# was:	addi	_addr_47_, _addr_47_, 4
	addi	x11, x11, 1
# was:	addi	_i_48_, _i_48_, 1
	j	l.loop_beg_49_
l.loop_end_50_:
	lw	x11, 0(x13)
# was:	lw	_size_41_, 0(_arr_42_)
	mv	x18, x3
# was:	mv	_let_a2d_40_, x3
	slli	x10, x11, 2
# was:	slli	_tmp_66_, _size_41_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_66_, _tmp_66_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_66_
	sw	x11, 0(x18)
# was:	sw	_size_41_, 0(_let_a2d_40_)
	addi	x10, x18, 4
# was:	addi	_addrg_52_, _let_a2d_40_, 4
	mv	x12, x0
# was:	mv	_i_53_, x0
	addi	x13, x13, 4
# was:	addi	_elem_43_, _arr_42_, 4
l.loop_beg_54_:
	bge	x12, x11, l.loop_end_55_
# was:	bge	_i_53_, _size_41_, l.loop_end_55_
	lw	x15, 0(x13)
# was:	lw	_res_44_, 0(_elem_43_)
	addi	x13, x13, 4
# was:	addi	_elem_43_, _elem_43_, 4
# 	mv	_plus_L_58_,_res_44_
	li	x14, 2
# was:	li	_plus_R_59_, 2
	add	x14, x15, x14
# was:	add	_size_57_, _plus_L_58_, _plus_R_59_
	bge	x14, x0, l.safe_60_
# was:	bge	_size_57_, x0, l.safe_60_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_60_:
	mv	x15, x3
# was:	mv	_fun_arg_res_56_, x3
	slli	x16, x14, 2
# was:	slli	_tmp_65_, _size_57_, 2
	addi	x16, x16, 4
# was:	addi	_tmp_65_, _tmp_65_, 4
	add	x3, x3, x16
# was:	add	x3, x3, _tmp_65_
	sw	x14, 0(x15)
# was:	sw	_size_57_, 0(_fun_arg_res_56_)
	addi	x16, x15, 4
# was:	addi	_addr_61_, _fun_arg_res_56_, 4
	mv	x17, x0
# was:	mv	_i_62_, x0
l.loop_beg_63_:
	bge	x17, x14, l.loop_end_64_
# was:	bge	_i_62_, _size_57_, l.loop_end_64_
	sw	x17, 0(x16)
# was:	sw	_i_62_, 0(_addr_61_)
	addi	x16, x16, 4
# was:	addi	_addr_61_, _addr_61_, 4
	addi	x17, x17, 1
# was:	addi	_i_62_, _i_62_, 1
	j	l.loop_beg_63_
l.loop_end_64_:
# 	mv	_res_44_,_fun_arg_res_56_
	sw	x15, 0(x10)
# was:	sw	_res_44_, 0(_addrg_52_)
	addi	x10, x10, 4
# was:	addi	_addrg_52_, _addrg_52_, 4
	addi	x12, x12, 1
# was:	addi	_i_53_, _i_53_, 1
	j	l.loop_beg_54_
l.loop_end_55_:
# 	mv	_filter_arr_68_,_let_a2d_40_
	lw	x19, 0(x18)
# was:	lw	_filter_size_69_, 0(_filter_arr_68_)
	mv	x20, x3
# was:	mv	_let_a2df_67_, x3
	slli	x10, x19, 2
# was:	slli	_tmp_90_, _filter_size_69_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_90_, _tmp_90_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_90_
	sw	x19, 0(x20)
# was:	sw	_filter_size_69_, 0(_let_a2df_67_)
	addi	x18, x18, 4
# was:	addi	_filter_arr_68_, _filter_arr_68_, 4
	mv	x21, x0
# was:	mv	_filter_i_73_, x0
	mv	x24, x0
# was:	mv	_filter_counter_72_, x0
	mv	x23, x20
# was:	mv	_filter_current_place_74_, _let_a2df_67_
	addi	x23, x23, 4
# was:	addi	_filter_current_place_74_, _filter_current_place_74_, 4
l.filter_start_75_:
	bge	x21, x19, l.filter_end_77_
# was:	bge	_filter_i_73_, _filter_size_69_, l.filter_end_77_
	lw	x22, 0(x18)
# was:	lw	_filter_elem_70_, 0(_filter_arr_68_)
	mv	x10, x22
# was:	mv	_arr_80_, _filter_elem_70_
	lw	x11, 0(x10)
# was:	lw	_size_81_, 0(_arr_80_)
	li	x13, 0
# was:	li	_let_r_79_, 0
	addi	x10, x10, 4
# was:	addi	_arr_80_, _arr_80_, 4
	mv	x12, x0
# was:	mv	_ind_var_82_, x0
l.loop_beg_84_:
	bge	x12, x11, l.loop_end_85_
# was:	bge	_ind_var_82_, _size_81_, l.loop_end_85_
	lw	x14, 0(x10)
# was:	lw	_tmp_83_, 0(_arr_80_)
	addi	x10, x10, 4
# was:	addi	_arr_80_, _arr_80_, 4
# 	mv	_plus_L_87_,_let_r_79_
# 	mv	_plus_R_88_,_tmp_83_
	add	x13, x13, x14
# was:	add	_fun_arg_res_86_, _plus_L_87_, _plus_R_88_
# 	mv	_let_r_79_,_fun_arg_res_86_
	addi	x12, x12, 1
# was:	addi	_ind_var_82_, _ind_var_82_, 1
	j	l.loop_beg_84_
l.loop_end_85_:
	mv	x10, x13
# was:	mv	_arg_89_, _let_r_79_
# 	mv	x10,_arg_89_
	jal	f.even
# was:	jal	f.even, x10
# 	mv	_fun_arg_res_78_,x10
# 	mv	_filter_predicate_res_71_,_fun_arg_res_78_
	beq	x10, x0, l.filter_skip_76_
# was:	beq	_filter_predicate_res_71_, x0, l.filter_skip_76_
	sw	x22, 0(x23)
# was:	sw	_filter_elem_70_, 0(_filter_current_place_74_)
	addi	x23, x23, 4
# was:	addi	_filter_current_place_74_, _filter_current_place_74_, 4
	addi	x24, x24, 1
# was:	addi	_filter_counter_72_, _filter_counter_72_, 1
l.filter_skip_76_:
	addi	x18, x18, 4
# was:	addi	_filter_arr_68_, _filter_arr_68_, 4
	addi	x21, x21, 1
# was:	addi	_filter_i_73_, _filter_i_73_, 1
	j	l.filter_start_75_
l.filter_end_77_:
	sw	x24, 0(x20)
# was:	sw	_filter_counter_72_, 0(_let_a2df_67_)
	mv	x10, x20
# was:	mv	_arg_91_, _let_a2df_67_
# 	mv	x10,_arg_91_
	jal	f.write_2darr
# was:	jal	f.write_2darr, x10
# 	mv	_mainres_38_,x10
# 	mv	x10,_mainres_38_
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