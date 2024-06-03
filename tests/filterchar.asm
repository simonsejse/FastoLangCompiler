	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function writeChar
f.writeChar:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_x_1_,x10
	mv	x18, x10
# was:	mv	_tmp_3_, _param_x_1_
# 	mv	_writeCharres_2_,_tmp_3_
	mv	x10, x18
# was:	mv	x10, _writeCharres_2_
	jal	p.putchar
# was:	jal	p.putchar, x10
	mv	x10, x18
# was:	mv	x10, _writeCharres_2_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function writeCharArray
f.writeCharArray:
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
# was:	mv	_writeCharArrayres_5_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_15_, _size_6_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_15_, _tmp_15_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_15_
	sw	x18, 0(x19)
# was:	sw	_size_6_, 0(_writeCharArrayres_5_)
	addi	x20, x19, 4
# was:	addi	_addrg_10_, _writeCharArrayres_5_, 4
	mv	x21, x0
# was:	mv	_i_11_, x0
	addi	x22, x10, 4
# was:	addi	_elem_8_, _arr_7_, 4
l.loop_beg_12_:
	bge	x21, x18, l.loop_end_13_
# was:	bge	_i_11_, _size_6_, l.loop_end_13_
	lbu	x10, 0(x22)
# was:	lbu	_res_9_, 0(_elem_8_)
	addi	x22, x22, 1
# was:	addi	_elem_8_, _elem_8_, 1
# 	mv	x10,_res_9_
	jal	f.writeChar
# was:	jal	f.writeChar, x10
# 	mv	_tmp_14_,x10
# 	mv	_res_9_,_tmp_14_
	sb	x10, 0(x20)
# was:	sb	_res_9_, 0(_addrg_10_)
	addi	x20, x20, 1
# was:	addi	_addrg_10_, _addrg_10_, 1
	addi	x21, x21, 1
# was:	addi	_i_11_, _i_11_, 1
	j	l.loop_beg_12_
l.loop_end_13_:
	mv	x10, x19
# was:	mv	x10, _writeCharArrayres_5_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function isCharB
f.isCharB:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_16_,x10
	mv	x12, x10
# was:	mv	_eq_L_18_, _param_x_16_
	li	x11, 98
# was:	li	_eq_R_19_, 98
	li	x10, 0
# was:	li	_isCharBres_17_, 0
	bne	x12, x11, l.false_20_
# was:	bne	_eq_L_18_, _eq_R_19_, l.false_20_
	li	x10, 1
# was:	li	_isCharBres_17_, 1
l.false_20_:
# 	mv	x10,_isCharBres_17_
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
# was:	li	_size_23_, 3
	mv	x19, x3
# was:	mv	_let_y_22_, x3
	addi	x10, x11, 3
# was:	addi	_tmp_26_, _size_23_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_26_, _tmp_26_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_26_, _tmp_26_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_26_
	sw	x11, 0(x19)
# was:	sw	_size_23_, 0(_let_y_22_)
	addi	x10, x19, 4
# was:	addi	_addr_24_, _let_y_22_, 4
	li	x11, 97
# was:	li	_tmp_25_, 97
	sb	x11, 0(x10)
# was:	sb	_tmp_25_, 0(_addr_24_)
	addi	x10, x10, 1
# was:	addi	_addr_24_, _addr_24_, 1
	li	x11, 98
# was:	li	_tmp_25_, 98
	sb	x11, 0(x10)
# was:	sb	_tmp_25_, 0(_addr_24_)
	addi	x10, x10, 1
# was:	addi	_addr_24_, _addr_24_, 1
	li	x11, 99
# was:	li	_tmp_25_, 99
	sb	x11, 0(x10)
# was:	sb	_tmp_25_, 0(_addr_24_)
	addi	x10, x10, 1
# was:	addi	_addr_24_, _addr_24_, 1
# 	mv	_filter_arr_28_,_let_y_22_
	lw	x20, 0(x19)
# was:	lw	_filter_size_29_, 0(_filter_arr_28_)
	mv	x18, x3
# was:	mv	_let_z_27_, x3
	addi	x10, x20, 3
# was:	addi	_tmp_39_, _filter_size_29_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_39_, _tmp_39_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_39_, _tmp_39_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_39_
	sw	x20, 0(x18)
# was:	sw	_filter_size_29_, 0(_let_z_27_)
	addi	x19, x19, 1
# was:	addi	_filter_arr_28_, _filter_arr_28_, 1
	mv	x21, x0
# was:	mv	_filter_i_33_, x0
	mv	x24, x0
# was:	mv	_filter_counter_32_, x0
	mv	x23, x18
# was:	mv	_filter_current_place_34_, _let_z_27_
	addi	x23, x23, 1
# was:	addi	_filter_current_place_34_, _filter_current_place_34_, 1
l.filter_start_35_:
	bge	x21, x20, l.filter_end_37_
# was:	bge	_filter_i_33_, _filter_size_29_, l.filter_end_37_
	lbu	x22, 0(x19)
# was:	lbu	_filter_elem_30_, 0(_filter_arr_28_)
	mv	x10, x22
# was:	mv	x10, _filter_elem_30_
	jal	f.isCharB
# was:	jal	f.isCharB, x10
# 	mv	_tmp_38_,x10
# 	mv	_filter_predicate_res_31_,_tmp_38_
	beq	x10, x0, l.filter_skip_36_
# was:	beq	_filter_predicate_res_31_, x0, l.filter_skip_36_
	sb	x22, 0(x23)
# was:	sb	_filter_elem_30_, 0(_filter_current_place_34_)
	addi	x23, x23, 1
# was:	addi	_filter_current_place_34_, _filter_current_place_34_, 1
	addi	x24, x24, 1
# was:	addi	_filter_counter_32_, _filter_counter_32_, 1
l.filter_skip_36_:
	addi	x19, x19, 1
# was:	addi	_filter_arr_28_, _filter_arr_28_, 1
	addi	x21, x21, 1
# was:	addi	_filter_i_33_, _filter_i_33_, 1
	j	l.filter_start_35_
l.filter_end_37_:
	sw	x24, 0(x18)
# was:	sw	_filter_counter_32_, 0(_let_z_27_)
	mv	x10, x18
# was:	mv	_arg_40_, _let_z_27_
# 	mv	x10,_arg_40_
	jal	f.writeCharArray
# was:	jal	f.writeCharArray, x10
# 	mv	_mainres_21_,x10
# 	mv	x10,_mainres_21_
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