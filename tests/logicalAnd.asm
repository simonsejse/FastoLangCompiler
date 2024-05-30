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
	li	x10, 1
# was:	li	_let_a_6_, 1
	li	x11, 0
# was:	li	_let_b_7_, 0
	li	x13, 1
# was:	li	_let_c_8_, 1
# 	mv	_and_L_10_,_let_a_6_
	beq	x10, x0, l.and_false_12_
# was:	beq	_and_L_10_, x0, l.and_false_12_
# 	mv	_and_R_11_,_let_b_7_
	beq	x11, x0, l.and_false_12_
# was:	beq	_and_R_11_, x0, l.and_false_12_
	li	x14, 1
# was:	li	_let_result1_9_, 1
	j	l.and_end_13_
l.and_false_12_:
	li	x14, 0
# was:	li	_let_result1_9_, 0
l.and_end_13_:
# 	mv	_and_L_15_,_let_b_7_
	beq	x11, x0, l.and_false_17_
# was:	beq	_and_L_15_, x0, l.and_false_17_
# 	mv	_and_R_16_,_let_a_6_
	beq	x10, x0, l.and_false_17_
# was:	beq	_and_R_16_, x0, l.and_false_17_
	li	x11, 1
# was:	li	_let_result2_14_, 1
	j	l.and_end_18_
l.and_false_17_:
	li	x11, 0
# was:	li	_let_result2_14_, 0
l.and_end_18_:
# 	mv	_and_L_20_,_let_a_6_
	beq	x10, x0, l.and_false_22_
# was:	beq	_and_L_20_, x0, l.and_false_22_
# 	mv	_and_R_21_,_let_c_8_
	beq	x13, x0, l.and_false_22_
# was:	beq	_and_R_21_, x0, l.and_false_22_
	li	x12, 1
# was:	li	_let_result3_19_, 1
	j	l.and_end_23_
l.and_false_22_:
	li	x12, 0
# was:	li	_let_result3_19_, 0
l.and_end_23_:
# 	mv	_and_L_25_,_let_c_8_
	beq	x13, x0, l.and_false_27_
# was:	beq	_and_L_25_, x0, l.and_false_27_
# 	mv	_and_R_26_,_let_a_6_
	beq	x10, x0, l.and_false_27_
# was:	beq	_and_R_26_, x0, l.and_false_27_
	li	x13, 1
# was:	li	_let_result4_24_, 1
	j	l.and_end_28_
l.and_false_27_:
	li	x13, 0
# was:	li	_let_result4_24_, 0
l.and_end_28_:
	li	x15, 4
# was:	li	_size_33_, 4
	mv	x10, x3
# was:	mv	_arr_30_, x3
	addi	x16, x15, 3
# was:	addi	_tmp_36_, _size_33_, 3
	andi	x16, x16, -4
# was:	andi	_tmp_36_, _tmp_36_, -4
	addi	x16, x16, 4
# was:	addi	_tmp_36_, _tmp_36_, 4
	add	x3, x3, x16
# was:	add	x3, x3, _tmp_36_
	sw	x15, 0(x10)
# was:	sw	_size_33_, 0(_arr_30_)
	addi	x15, x10, 4
# was:	addi	_addr_34_, _arr_30_, 4
# 	mv	_tmp_35_,_let_result1_9_
	sb	x14, 0(x15)
# was:	sb	_tmp_35_, 0(_addr_34_)
	addi	x15, x15, 1
# was:	addi	_addr_34_, _addr_34_, 1
	mv	x14, x11
# was:	mv	_tmp_35_, _let_result2_14_
	sb	x14, 0(x15)
# was:	sb	_tmp_35_, 0(_addr_34_)
	addi	x15, x15, 1
# was:	addi	_addr_34_, _addr_34_, 1
	mv	x14, x12
# was:	mv	_tmp_35_, _let_result3_19_
	sb	x14, 0(x15)
# was:	sb	_tmp_35_, 0(_addr_34_)
	addi	x15, x15, 1
# was:	addi	_addr_34_, _addr_34_, 1
	mv	x14, x13
# was:	mv	_tmp_35_, _let_result4_24_
	sb	x14, 0(x15)
# was:	sb	_tmp_35_, 0(_addr_34_)
	addi	x15, x15, 1
# was:	addi	_addr_34_, _addr_34_, 1
	lw	x18, 0(x10)
# was:	lw	_size_29_, 0(_arr_30_)
	mv	x19, x3
# was:	mv	_mainres_5_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_42_, _size_29_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_42_, _tmp_42_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_42_, _tmp_42_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_42_
	sw	x18, 0(x19)
# was:	sw	_size_29_, 0(_mainres_5_)
	addi	x20, x19, 4
# was:	addi	_addrg_37_, _mainres_5_, 4
	mv	x21, x0
# was:	mv	_i_38_, x0
	addi	x22, x10, 4
# was:	addi	_elem_31_, _arr_30_, 4
l.loop_beg_39_:
	bge	x21, x18, l.loop_end_40_
# was:	bge	_i_38_, _size_29_, l.loop_end_40_
	lbu	x10, 0(x22)
# was:	lbu	_res_32_, 0(_elem_31_)
	addi	x22, x22, 1
# was:	addi	_elem_31_, _elem_31_, 1
# 	mv	x10,_res_32_
	jal	f.print
# was:	jal	f.print, x10
# 	mv	_tmp_41_,x10
# 	mv	_res_32_,_tmp_41_
	sb	x10, 0(x20)
# was:	sb	_res_32_, 0(_addrg_37_)
	addi	x20, x20, 1
# was:	addi	_addrg_37_, _addrg_37_, 1
	addi	x21, x21, 1
# was:	addi	_i_38_, _i_38_, 1
	j	l.loop_beg_39_
l.loop_end_40_:
	mv	x10, x19
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