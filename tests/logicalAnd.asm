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
	li	x12, 1
# was:	li	_let_a_6_, 1
	li	x13, 0
# was:	li	_let_b_7_, 0
	li	x11, 1
# was:	li	_let_c_8_, 1
# 	mv	_and_L_10_,_let_a_6_
l.and_false_12_:
# 	mv	_and_R_11_,_let_b_7_
# 	mv	_and_L_14_,_let_b_7_
l.and_false_16_:
# 	mv	_and_R_15_,_let_a_6_
# 	mv	_and_L_18_,_let_a_6_
l.and_false_20_:
# 	mv	_and_R_19_,_let_c_8_
# 	mv	_and_L_22_,_let_c_8_
l.and_false_24_:
# 	mv	_and_R_23_,_let_a_6_
	li	x12, 4
# was:	li	_size_29_, 4
	mv	x11, x3
# was:	mv	_arr_26_, x3
	addi	x13, x12, 3
# was:	addi	_tmp_32_, _size_29_, 3
	andi	x13, x13, -4
# was:	andi	_tmp_32_, _tmp_32_, -4
	addi	x13, x13, 4
# was:	addi	_tmp_32_, _tmp_32_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_32_
	sw	x12, 0(x11)
# was:	sw	_size_29_, 0(_arr_26_)
	addi	x12, x11, 4
# was:	addi	_addr_30_, _arr_26_, 4
	mv	x13, x10
# was:	mv	_tmp_31_, _let_result1_9_
	sb	x13, 0(x12)
# was:	sb	_tmp_31_, 0(_addr_30_)
	addi	x12, x12, 1
# was:	addi	_addr_30_, _addr_30_, 1
	mv	x13, x10
# was:	mv	_tmp_31_, _let_result2_13_
	sb	x13, 0(x12)
# was:	sb	_tmp_31_, 0(_addr_30_)
	addi	x12, x12, 1
# was:	addi	_addr_30_, _addr_30_, 1
	mv	x13, x10
# was:	mv	_tmp_31_, _let_result3_17_
	sb	x13, 0(x12)
# was:	sb	_tmp_31_, 0(_addr_30_)
	addi	x12, x12, 1
# was:	addi	_addr_30_, _addr_30_, 1
	mv	x13, x10
# was:	mv	_tmp_31_, _let_result4_21_
	sb	x13, 0(x12)
# was:	sb	_tmp_31_, 0(_addr_30_)
	addi	x12, x12, 1
# was:	addi	_addr_30_, _addr_30_, 1
	lw	x19, 0(x11)
# was:	lw	_size_25_, 0(_arr_26_)
	mv	x18, x3
# was:	mv	_mainres_5_, x3
	addi	x10, x19, 3
# was:	addi	_tmp_38_, _size_25_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_38_, _tmp_38_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_38_, _tmp_38_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_38_
	sw	x19, 0(x18)
# was:	sw	_size_25_, 0(_mainres_5_)
	addi	x20, x18, 4
# was:	addi	_addrg_33_, _mainres_5_, 4
	mv	x21, x0
# was:	mv	_i_34_, x0
	addi	x22, x11, 4
# was:	addi	_elem_27_, _arr_26_, 4
l.loop_beg_35_:
	bge	x21, x19, l.loop_end_36_
# was:	bge	_i_34_, _size_25_, l.loop_end_36_
	lbu	x10, 0(x22)
# was:	lbu	_res_28_, 0(_elem_27_)
	addi	x22, x22, 1
# was:	addi	_elem_27_, _elem_27_, 1
# 	mv	x10,_res_28_
	jal	f.print
# was:	jal	f.print, x10
# 	mv	_tmp_37_,x10
# 	mv	_res_28_,_tmp_37_
	sb	x10, 0(x20)
# was:	sb	_res_28_, 0(_addrg_33_)
	addi	x20, x20, 1
# was:	addi	_addrg_33_, _addrg_33_, 1
	addi	x21, x21, 1
# was:	addi	_i_34_, _i_34_, 1
	j	l.loop_beg_35_
l.loop_end_36_:
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