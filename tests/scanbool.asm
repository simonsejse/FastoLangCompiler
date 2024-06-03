	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function fAnd
f.fAnd:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_1_,x10
# 	mv	_param_b_2_,x11
# 	mv	_and_L_4_,_param_a_1_
	beq	x10, x0, l.and_false_6_
# was:	beq	_and_L_4_, x0, l.and_false_6_
# 	mv	_and_R_5_,_param_b_2_
	beq	x11, x0, l.and_false_6_
# was:	beq	_and_R_5_, x0, l.and_false_6_
	li	x10, 1
# was:	li	_fAndres_3_, 1
	j	l.and_end_7_
l.and_false_6_:
	li	x10, 0
# was:	li	_fAndres_3_, 0
l.and_end_7_:
# 	mv	x10,_fAndres_3_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function writeBool
f.writeBool:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_b_8_,x10
	mv	x18, x10
# was:	mv	_tmp_10_, _param_b_8_
# 	mv	_writeBoolres_9_,_tmp_10_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x18, x0, l.wBoolF_11_
# was:	bne	_writeBoolres_9_, x0, l.wBoolF_11_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_11_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	x10, _writeBoolres_9_
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
	li	x10, 3
# was:	li	_size_14_, 3
	mv	x19, x3
# was:	mv	_let_x_13_, x3
	addi	x11, x10, 3
# was:	addi	_tmp_17_, _size_14_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_17_, _tmp_17_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_17_, _tmp_17_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_17_
	sw	x10, 0(x19)
# was:	sw	_size_14_, 0(_let_x_13_)
	addi	x10, x19, 4
# was:	addi	_addr_15_, _let_x_13_, 4
	li	x11, 0
# was:	li	_tmp_16_, 0
	sb	x11, 0(x10)
# was:	sb	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 1
# was:	addi	_addr_15_, _addr_15_, 1
	li	x11, 1
# was:	li	_tmp_16_, 1
	sb	x11, 0(x10)
# was:	sb	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 1
# was:	addi	_addr_15_, _addr_15_, 1
	li	x11, 0
# was:	li	_tmp_16_, 0
	sb	x11, 0(x10)
# was:	sb	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 1
# was:	addi	_addr_15_, _addr_15_, 1
	li	x10, 0
# was:	li	_scan_ne_19_, 0
# 	mv	_scan_arr_20_,_let_x_13_
	lbu	x20, 0(x19)
# was:	lbu	_scan_size_21_, 0(_scan_arr_20_)
	addi	x19, x19, 1
# was:	addi	_scan_arr_20_, _scan_arr_20_, 1
	mv	x18, x3
# was:	mv	_let_y_18_, x3
	addi	x11, x20, 3
# was:	addi	_tmp_29_, _scan_size_21_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_29_, _tmp_29_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_29_, _tmp_29_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_29_
	sw	x20, 0(x18)
# was:	sw	_scan_size_21_, 0(_let_y_18_)
	mv	x21, x0
# was:	mv	_scan_i_22_, x0
# 	mv	_scan_acc_23_,_scan_ne_19_
	mv	x22, x18
# was:	mv	_scan_current_place_25_, _let_y_18_
	addi	x22, x22, 1
# was:	addi	_scan_current_place_25_, _scan_current_place_25_, 1
l.scan_start_26_:
	bge	x21, x20, l.scan_end_27_
# was:	bge	_scan_i_22_, _scan_size_21_, l.scan_end_27_
	lbu	x11, 0(x19)
# was:	lbu	_scan_elem_24_, 0(_scan_arr_20_)
# 	mv	x10,_scan_acc_23_
# 	mv	x11,_scan_elem_24_
	jal	f.fAnd
# was:	jal	f.fAnd, x10 x11
# 	mv	_tmp_28_,x10
# 	mv	_scan_acc_23_,_tmp_28_
	sb	x10, 0(x22)
# was:	sb	_scan_acc_23_, 0(_scan_current_place_25_)
	addi	x22, x22, 1
# was:	addi	_scan_current_place_25_, _scan_current_place_25_, 1
	addi	x19, x19, 1
# was:	addi	_scan_arr_20_, _scan_arr_20_, 1
	addi	x21, x21, 1
# was:	addi	_scan_i_22_, _scan_i_22_, 1
	j	l.scan_start_26_
l.scan_end_27_:
	mv	x10, x18
# was:	mv	_arr_31_, _let_y_18_
	lw	x18, 0(x10)
# was:	lw	_size_30_, 0(_arr_31_)
	mv	x19, x3
# was:	mv	_mainres_12_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_39_, _size_30_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_39_, _tmp_39_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_39_, _tmp_39_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_39_
	sw	x18, 0(x19)
# was:	sw	_size_30_, 0(_mainres_12_)
	addi	x20, x19, 4
# was:	addi	_addrg_34_, _mainres_12_, 4
	mv	x21, x0
# was:	mv	_i_35_, x0
	addi	x22, x10, 4
# was:	addi	_elem_32_, _arr_31_, 4
l.loop_beg_36_:
	bge	x21, x18, l.loop_end_37_
# was:	bge	_i_35_, _size_30_, l.loop_end_37_
	lbu	x10, 0(x22)
# was:	lbu	_res_33_, 0(_elem_32_)
	addi	x22, x22, 1
# was:	addi	_elem_32_, _elem_32_, 1
# 	mv	x10,_res_33_
	jal	f.writeBool
# was:	jal	f.writeBool, x10
# 	mv	_tmp_38_,x10
# 	mv	_res_33_,_tmp_38_
	sb	x10, 0(x20)
# was:	sb	_res_33_, 0(_addrg_34_)
	addi	x20, x20, 1
# was:	addi	_addrg_34_, _addrg_34_, 1
	addi	x21, x21, 1
# was:	addi	_i_35_, _i_35_, 1
	j	l.loop_beg_36_
l.loop_end_37_:
	mv	x10, x19
# was:	mv	x10, _mainres_12_
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