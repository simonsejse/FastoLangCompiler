	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function print
f.print:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_a_1_,x10
# 	mv	_tmp_3_,_param_a_1_
	mv	x18, x10
# was:	mv	_printres_2_, _tmp_3_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x18, x0, l.wBoolF_4_
# was:	bne	_printres_2_, x0, l.wBoolF_4_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_4_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	x10, _printres_2_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
	li	x11, 1
# was:	li	_let_a_6_, 1
	li	x10, 0
# was:	li	_let_b_7_, 0
	li	x13, 1
# was:	li	_let_c_8_, 1
# 	mv	_and_L_10_,_let_a_6_
	bne	x11, x0, l.or_true_12_
# was:	bne	_and_L_10_, x0, l.or_true_12_
# 	mv	_and_R_11_,_let_b_7_
	bne	x10, x0, l.or_true_12_
# was:	bne	_and_R_11_, x0, l.or_true_12_
	li	x15, 0
# was:	li	_let_result1_9_, 0
	j	l.or_end_13_
l.or_true_12_:
	li	x15, 1
# was:	li	_let_result1_9_, 1
l.or_end_13_:
# 	mv	_and_L_15_,_let_b_7_
	bne	x10, x0, l.or_true_17_
# was:	bne	_and_L_15_, x0, l.or_true_17_
# 	mv	_and_R_16_,_let_a_6_
	bne	x11, x0, l.or_true_17_
# was:	bne	_and_R_16_, x0, l.or_true_17_
	li	x11, 0
# was:	li	_let_result2_14_, 0
	j	l.or_end_18_
l.or_true_17_:
	li	x11, 1
# was:	li	_let_result2_14_, 1
l.or_end_18_:
# 	mv	_and_L_20_,_let_b_7_
	bne	x10, x0, l.or_true_22_
# was:	bne	_and_L_20_, x0, l.or_true_22_
# 	mv	_and_R_21_,_let_c_8_
	bne	x13, x0, l.or_true_22_
# was:	bne	_and_R_21_, x0, l.or_true_22_
	li	x12, 0
# was:	li	_let_result3_19_, 0
	j	l.or_end_23_
l.or_true_22_:
	li	x12, 1
# was:	li	_let_result3_19_, 1
l.or_end_23_:
# 	mv	_and_L_25_,_let_c_8_
	bne	x13, x0, l.or_true_27_
# was:	bne	_and_L_25_, x0, l.or_true_27_
# 	mv	_and_R_26_,_let_b_7_
	bne	x10, x0, l.or_true_27_
# was:	bne	_and_R_26_, x0, l.or_true_27_
	li	x13, 0
# was:	li	_let_result4_24_, 0
	j	l.or_end_28_
l.or_true_27_:
	li	x13, 1
# was:	li	_let_result4_24_, 1
l.or_end_28_:
# 	mv	_and_L_30_,_let_b_7_
	bne	x10, x0, l.or_true_32_
# was:	bne	_and_L_30_, x0, l.or_true_32_
# 	mv	_and_R_31_,_let_b_7_
	bne	x10, x0, l.or_true_32_
# was:	bne	_and_R_31_, x0, l.or_true_32_
	li	x14, 0
# was:	li	_let_result5_29_, 0
	j	l.or_end_33_
l.or_true_32_:
	li	x14, 1
# was:	li	_let_result5_29_, 1
l.or_end_33_:
	li	x16, 5
# was:	li	_size_38_, 5
	mv	x10, x3
# was:	mv	_arr_35_, x3
	addi	x17, x16, 3
# was:	addi	_tmp_41_, _size_38_, 3
	andi	x17, x17, -4
# was:	andi	_tmp_41_, _tmp_41_, -4
	addi	x17, x17, 4
# was:	addi	_tmp_41_, _tmp_41_, 4
	add	x3, x3, x17
# was:	add	x3, x3, _tmp_41_
	sw	x16, 0(x10)
# was:	sw	_size_38_, 0(_arr_35_)
	addi	x16, x10, 4
# was:	addi	_addr_39_, _arr_35_, 4
# 	mv	_tmp_40_,_let_result1_9_
	sb	x15, 0(x16)
# was:	sb	_tmp_40_, 0(_addr_39_)
	addi	x16, x16, 1
# was:	addi	_addr_39_, _addr_39_, 1
	mv	x15, x11
# was:	mv	_tmp_40_, _let_result2_14_
	sb	x15, 0(x16)
# was:	sb	_tmp_40_, 0(_addr_39_)
	addi	x16, x16, 1
# was:	addi	_addr_39_, _addr_39_, 1
	mv	x15, x12
# was:	mv	_tmp_40_, _let_result3_19_
	sb	x15, 0(x16)
# was:	sb	_tmp_40_, 0(_addr_39_)
	addi	x16, x16, 1
# was:	addi	_addr_39_, _addr_39_, 1
	mv	x15, x13
# was:	mv	_tmp_40_, _let_result4_24_
	sb	x15, 0(x16)
# was:	sb	_tmp_40_, 0(_addr_39_)
	addi	x16, x16, 1
# was:	addi	_addr_39_, _addr_39_, 1
	mv	x15, x14
# was:	mv	_tmp_40_, _let_result5_29_
	sb	x15, 0(x16)
# was:	sb	_tmp_40_, 0(_addr_39_)
	addi	x16, x16, 1
# was:	addi	_addr_39_, _addr_39_, 1
	lw	x19, 0(x10)
# was:	lw	_size_34_, 0(_arr_35_)
	mv	x18, x3
# was:	mv	_mainres_5_, x3
	addi	x11, x19, 3
# was:	addi	_tmp_47_, _size_34_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_47_, _tmp_47_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_47_, _tmp_47_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_47_
	sw	x19, 0(x18)
# was:	sw	_size_34_, 0(_mainres_5_)
	addi	x20, x18, 4
# was:	addi	_addrg_42_, _mainres_5_, 4
	mv	x21, x0
# was:	mv	_i_43_, x0
	addi	x22, x10, 4
# was:	addi	_elem_36_, _arr_35_, 4
l.loop_beg_44_:
	bge	x21, x19, l.loop_end_45_
# was:	bge	_i_43_, _size_34_, l.loop_end_45_
	lbu	x10, 0(x22)
# was:	lbu	_res_37_, 0(_elem_36_)
	addi	x22, x22, 1
# was:	addi	_elem_36_, _elem_36_, 1
# 	mv	x10,_res_37_
	jal	f.print
# was:	jal	f.print, x10
# 	mv	_tmp_46_,x10
# 	mv	_res_37_,_tmp_46_
	sb	x10, 0(x20)
# was:	sb	_res_37_, 0(_addrg_42_)
	addi	x20, x20, 1
# was:	addi	_addrg_42_, _addrg_42_, 1
	addi	x21, x21, 1
# was:	addi	_i_43_, _i_43_, 1
	j	l.loop_beg_44_
l.loop_end_45_:
	mv	x10, x18
# was:	mv	x10, _mainres_5_
	addi	x2, x2, 24
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