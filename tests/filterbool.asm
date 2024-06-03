	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function writeBool
f.writeBool:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_x_1_,x10
	mv	x18, x10
# was:	mv	_tmp_3_, _param_x_1_
# 	mv	_writeBoolres_2_,_tmp_3_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x18, x0, l.wBoolF_4_
# was:	bne	_writeBoolres_2_, x0, l.wBoolF_4_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_4_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	x10, _writeBoolres_2_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function writeBoolArray
f.writeBoolArray:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_x_5_,x10
# 	mv	_arr_8_,_param_x_5_
	lw	x18, 0(x10)
# was:	lw	_size_7_, 0(_arr_8_)
	mv	x19, x3
# was:	mv	_writeBoolArrayres_6_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_16_, _size_7_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_16_, _tmp_16_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_16_, _tmp_16_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_16_
	sw	x18, 0(x19)
# was:	sw	_size_7_, 0(_writeBoolArrayres_6_)
	addi	x20, x19, 4
# was:	addi	_addrg_11_, _writeBoolArrayres_6_, 4
	mv	x21, x0
# was:	mv	_i_12_, x0
	addi	x22, x10, 4
# was:	addi	_elem_9_, _arr_8_, 4
l.loop_beg_13_:
	bge	x21, x18, l.loop_end_14_
# was:	bge	_i_12_, _size_7_, l.loop_end_14_
	lbu	x10, 0(x22)
# was:	lbu	_res_10_, 0(_elem_9_)
	addi	x22, x22, 1
# was:	addi	_elem_9_, _elem_9_, 1
# 	mv	x10,_res_10_
	jal	f.writeBool
# was:	jal	f.writeBool, x10
# 	mv	_tmp_15_,x10
# 	mv	_res_10_,_tmp_15_
	sb	x10, 0(x20)
# was:	sb	_res_10_, 0(_addrg_11_)
	addi	x20, x20, 1
# was:	addi	_addrg_11_, _addrg_11_, 1
	addi	x21, x21, 1
# was:	addi	_i_12_, _i_12_, 1
	j	l.loop_beg_13_
l.loop_end_14_:
	mv	x10, x19
# was:	mv	x10, _writeBoolArrayres_6_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function isBoolTrue
f.isBoolTrue:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_17_,x10
	mv	x12, x10
# was:	mv	_eq_L_19_, _param_x_17_
	li	x11, 1
# was:	li	_eq_R_20_, 1
	li	x10, 0
# was:	li	_isBoolTrueres_18_, 0
	bne	x12, x11, l.false_21_
# was:	bne	_eq_L_19_, _eq_R_20_, l.false_21_
	li	x10, 1
# was:	li	_isBoolTrueres_18_, 1
l.false_21_:
# 	mv	x10,_isBoolTrueres_18_
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
	li	x11, 3
# was:	li	_size_24_, 3
	mv	x19, x3
# was:	mv	_let_y_23_, x3
	addi	x10, x11, 3
# was:	addi	_tmp_27_, _size_24_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_27_, _tmp_27_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_27_, _tmp_27_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_27_
	sw	x11, 0(x19)
# was:	sw	_size_24_, 0(_let_y_23_)
	addi	x10, x19, 4
# was:	addi	_addr_25_, _let_y_23_, 4
	li	x13, 2
# was:	li	_eq_L_28_, 2
	li	x12, 2
# was:	li	_eq_R_29_, 2
	li	x11, 0
# was:	li	_tmp_26_, 0
	bne	x13, x12, l.false_30_
# was:	bne	_eq_L_28_, _eq_R_29_, l.false_30_
	li	x11, 1
# was:	li	_tmp_26_, 1
l.false_30_:
	sb	x11, 0(x10)
# was:	sb	_tmp_26_, 0(_addr_25_)
	addi	x10, x10, 1
# was:	addi	_addr_25_, _addr_25_, 1
	li	x13, 2
# was:	li	_eq_L_31_, 2
	li	x12, 4
# was:	li	_eq_R_32_, 4
	li	x11, 0
# was:	li	_tmp_26_, 0
	bne	x13, x12, l.false_33_
# was:	bne	_eq_L_31_, _eq_R_32_, l.false_33_
	li	x11, 1
# was:	li	_tmp_26_, 1
l.false_33_:
	sb	x11, 0(x10)
# was:	sb	_tmp_26_, 0(_addr_25_)
	addi	x10, x10, 1
# was:	addi	_addr_25_, _addr_25_, 1
	li	x12, 2
# was:	li	_div_L_36_, 2
	li	x11, 3
# was:	li	_div_R_37_, 3
	bne	x11, x0, l.divZeroSafe_38_
# was:	bne	_div_R_37_, x0, l.divZeroSafe_38_
	li	x10, 8
# was:	li	x10, 8
	la	x11, m.DivZero
# was:	la	x11, m.DivZero
	j	p.RuntimeError
l.divZeroSafe_38_:
	div	x13, x12, x11
# was:	div	_eq_L_34_, _div_L_36_, _div_R_37_
	li	x12, 1
# was:	li	_eq_R_35_, 1
	li	x11, 0
# was:	li	_tmp_26_, 0
	bne	x13, x12, l.false_39_
# was:	bne	_eq_L_34_, _eq_R_35_, l.false_39_
	li	x11, 1
# was:	li	_tmp_26_, 1
l.false_39_:
	sb	x11, 0(x10)
# was:	sb	_tmp_26_, 0(_addr_25_)
	addi	x10, x10, 1
# was:	addi	_addr_25_, _addr_25_, 1
# 	mv	_filter_arr_41_,_let_y_23_
	lw	x20, 0(x19)
# was:	lw	_filter_size_42_, 0(_filter_arr_41_)
	mv	x18, x3
# was:	mv	_let_z_40_, x3
	addi	x10, x20, 3
# was:	addi	_tmp_52_, _filter_size_42_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_52_, _tmp_52_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_52_, _tmp_52_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_52_
	sw	x20, 0(x18)
# was:	sw	_filter_size_42_, 0(_let_z_40_)
	addi	x19, x19, 1
# was:	addi	_filter_arr_41_, _filter_arr_41_, 1
	mv	x21, x0
# was:	mv	_filter_i_46_, x0
	mv	x24, x0
# was:	mv	_filter_counter_45_, x0
	mv	x23, x18
# was:	mv	_filter_current_place_47_, _let_z_40_
	addi	x23, x23, 1
# was:	addi	_filter_current_place_47_, _filter_current_place_47_, 1
l.filter_start_48_:
	bge	x21, x20, l.filter_end_50_
# was:	bge	_filter_i_46_, _filter_size_42_, l.filter_end_50_
	lbu	x22, 0(x19)
# was:	lbu	_filter_elem_43_, 0(_filter_arr_41_)
	mv	x10, x22
# was:	mv	x10, _filter_elem_43_
	jal	f.isBoolTrue
# was:	jal	f.isBoolTrue, x10
# 	mv	_tmp_51_,x10
# 	mv	_filter_predicate_res_44_,_tmp_51_
	beq	x10, x0, l.filter_skip_49_
# was:	beq	_filter_predicate_res_44_, x0, l.filter_skip_49_
	sb	x22, 0(x23)
# was:	sb	_filter_elem_43_, 0(_filter_current_place_47_)
	addi	x23, x23, 1
# was:	addi	_filter_current_place_47_, _filter_current_place_47_, 1
	addi	x24, x24, 1
# was:	addi	_filter_counter_45_, _filter_counter_45_, 1
l.filter_skip_49_:
	addi	x19, x19, 1
# was:	addi	_filter_arr_41_, _filter_arr_41_, 1
	addi	x21, x21, 1
# was:	addi	_filter_i_46_, _filter_i_46_, 1
	j	l.filter_start_48_
l.filter_end_50_:
	sw	x24, 0(x18)
# was:	sw	_filter_counter_45_, 0(_let_z_40_)
	mv	x10, x18
# was:	mv	_arg_53_, _let_z_40_
# 	mv	x10,_arg_53_
	jal	f.writeBoolArray
# was:	jal	f.writeBoolArray, x10
# 	mv	_mainres_22_,x10
# 	mv	x10,_mainres_22_
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