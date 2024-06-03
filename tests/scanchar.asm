	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function fCheck
f.fCheck:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_1_,x10
	mv	x12, x11
# was:	mv	_param_b_2_, x11
# 	mv	_eq_L_8_,_param_a_1_
# 	mv	_eq_R_9_,_param_b_2_
	li	x11, 0
# was:	li	_cond_7_, 0
	bne	x10, x12, l.false_10_
# was:	bne	_eq_L_8_, _eq_R_9_, l.false_10_
	li	x11, 1
# was:	li	_cond_7_, 1
l.false_10_:
	bne	x11, x0, l.then_4_
# was:	bne	_cond_7_, x0, l.then_4_
	j	l.else_5_
l.then_4_:
# 	mv	_fCheckres_3_,_param_a_1_
	j	l.endif_6_
l.else_5_:
	mv	x10, x12
# was:	mv	_fCheckres_3_, _param_b_2_
l.endif_6_:
# 	mv	x10,_fCheckres_3_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function writeChar
f.writeChar:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_c_11_,x10
	mv	x18, x10
# was:	mv	_tmp_13_, _param_c_11_
# 	mv	_writeCharres_12_,_tmp_13_
	mv	x10, x18
# was:	mv	x10, _writeCharres_12_
	jal	p.putchar
# was:	jal	p.putchar, x10
	mv	x10, x18
# was:	mv	x10, _writeCharres_12_
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
# was:	li	_size_16_, 3
	mv	x19, x3
# was:	mv	_let_x_15_, x3
	addi	x11, x10, 3
# was:	addi	_tmp_19_, _size_16_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_19_, _tmp_19_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_19_, _tmp_19_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_19_
	sw	x10, 0(x19)
# was:	sw	_size_16_, 0(_let_x_15_)
	addi	x10, x19, 4
# was:	addi	_addr_17_, _let_x_15_, 4
	li	x11, 97
# was:	li	_tmp_18_, 97
	sb	x11, 0(x10)
# was:	sb	_tmp_18_, 0(_addr_17_)
	addi	x10, x10, 1
# was:	addi	_addr_17_, _addr_17_, 1
	li	x11, 97
# was:	li	_tmp_18_, 97
	sb	x11, 0(x10)
# was:	sb	_tmp_18_, 0(_addr_17_)
	addi	x10, x10, 1
# was:	addi	_addr_17_, _addr_17_, 1
	li	x11, 98
# was:	li	_tmp_18_, 98
	sb	x11, 0(x10)
# was:	sb	_tmp_18_, 0(_addr_17_)
	addi	x10, x10, 1
# was:	addi	_addr_17_, _addr_17_, 1
	li	x10, 97
# was:	li	_scan_ne_21_, 97
# 	mv	_scan_arr_22_,_let_x_15_
	lbu	x20, 0(x19)
# was:	lbu	_scan_size_23_, 0(_scan_arr_22_)
	addi	x19, x19, 1
# was:	addi	_scan_arr_22_, _scan_arr_22_, 1
	mv	x18, x3
# was:	mv	_let_y_20_, x3
	addi	x11, x20, 3
# was:	addi	_tmp_31_, _scan_size_23_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_31_, _tmp_31_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_31_, _tmp_31_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_31_
	sw	x20, 0(x18)
# was:	sw	_scan_size_23_, 0(_let_y_20_)
	mv	x21, x0
# was:	mv	_scan_i_24_, x0
# 	mv	_scan_acc_25_,_scan_ne_21_
	mv	x22, x18
# was:	mv	_scan_current_place_27_, _let_y_20_
	addi	x22, x22, 1
# was:	addi	_scan_current_place_27_, _scan_current_place_27_, 1
l.scan_start_28_:
	bge	x21, x20, l.scan_end_29_
# was:	bge	_scan_i_24_, _scan_size_23_, l.scan_end_29_
	lbu	x11, 0(x19)
# was:	lbu	_scan_elem_26_, 0(_scan_arr_22_)
# 	mv	x10,_scan_acc_25_
# 	mv	x11,_scan_elem_26_
	jal	f.fCheck
# was:	jal	f.fCheck, x10 x11
# 	mv	_tmp_30_,x10
# 	mv	_scan_acc_25_,_tmp_30_
	sb	x10, 0(x22)
# was:	sb	_scan_acc_25_, 0(_scan_current_place_27_)
	addi	x22, x22, 1
# was:	addi	_scan_current_place_27_, _scan_current_place_27_, 1
	addi	x19, x19, 1
# was:	addi	_scan_arr_22_, _scan_arr_22_, 1
	addi	x21, x21, 1
# was:	addi	_scan_i_24_, _scan_i_24_, 1
	j	l.scan_start_28_
l.scan_end_29_:
	mv	x10, x18
# was:	mv	_arr_33_, _let_y_20_
	lw	x18, 0(x10)
# was:	lw	_size_32_, 0(_arr_33_)
	mv	x19, x3
# was:	mv	_mainres_14_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_41_, _size_32_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_41_, _tmp_41_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_41_, _tmp_41_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_41_
	sw	x18, 0(x19)
# was:	sw	_size_32_, 0(_mainres_14_)
	addi	x20, x19, 4
# was:	addi	_addrg_36_, _mainres_14_, 4
	mv	x21, x0
# was:	mv	_i_37_, x0
	addi	x22, x10, 4
# was:	addi	_elem_34_, _arr_33_, 4
l.loop_beg_38_:
	bge	x21, x18, l.loop_end_39_
# was:	bge	_i_37_, _size_32_, l.loop_end_39_
	lbu	x10, 0(x22)
# was:	lbu	_res_35_, 0(_elem_34_)
	addi	x22, x22, 1
# was:	addi	_elem_34_, _elem_34_, 1
# 	mv	x10,_res_35_
	jal	f.writeChar
# was:	jal	f.writeChar, x10
# 	mv	_tmp_40_,x10
# 	mv	_res_35_,_tmp_40_
	sb	x10, 0(x20)
# was:	sb	_res_35_, 0(_addrg_36_)
	addi	x20, x20, 1
# was:	addi	_addrg_36_, _addrg_36_, 1
	addi	x21, x21, 1
# was:	addi	_i_37_, _i_37_, 1
	j	l.loop_beg_38_
l.loop_end_39_:
	mv	x10, x19
# was:	mv	x10, _mainres_14_
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