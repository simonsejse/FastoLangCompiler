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
	li	x10, 3
# was:	li	_size_3_, 3
	mv	x12, x3
# was:	mv	_let_x_2_, x3
	addi	x11, x10, 3
# was:	addi	_tmp_6_, _size_3_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_6_, _tmp_6_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_6_, _tmp_6_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_6_
	sw	x10, 0(x12)
# was:	sw	_size_3_, 0(_let_x_2_)
	addi	x10, x12, 4
# was:	addi	_addr_4_, _let_x_2_, 4
	li	x11, 0
# was:	li	_tmp_5_, 0
	sb	x11, 0(x10)
# was:	sb	_tmp_5_, 0(_addr_4_)
	addi	x10, x10, 1
# was:	addi	_addr_4_, _addr_4_, 1
	li	x11, 1
# was:	li	_tmp_5_, 1
	sb	x11, 0(x10)
# was:	sb	_tmp_5_, 0(_addr_4_)
	addi	x10, x10, 1
# was:	addi	_addr_4_, _addr_4_, 1
	li	x11, 0
# was:	li	_tmp_5_, 0
	sb	x11, 0(x10)
# was:	sb	_tmp_5_, 0(_addr_4_)
	addi	x10, x10, 1
# was:	addi	_addr_4_, _addr_4_, 1
	li	x16, 0
# was:	li	_scan_ne_8_, 0
# 	mv	_scan_arr_9_,_let_x_2_
	lbu	x11, 0(x12)
# was:	lbu	_scan_size_10_, 0(_scan_arr_9_)
	addi	x12, x12, 1
# was:	addi	_scan_arr_9_, _scan_arr_9_, 1
	mv	x10, x3
# was:	mv	_let_y_7_, x3
	addi	x13, x11, 3
# was:	addi	_tmp_22_, _scan_size_10_, 3
	andi	x13, x13, -4
# was:	andi	_tmp_22_, _tmp_22_, -4
	addi	x13, x13, 4
# was:	addi	_tmp_22_, _tmp_22_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_22_
	sw	x11, 0(x10)
# was:	sw	_scan_size_10_, 0(_let_y_7_)
	mv	x13, x0
# was:	mv	_scan_i_11_, x0
# 	mv	_scan_acc_12_,_scan_ne_8_
	mv	x14, x10
# was:	mv	_scan_current_place_14_, _let_y_7_
	addi	x14, x14, 1
# was:	addi	_scan_current_place_14_, _scan_current_place_14_, 1
l.scan_start_15_:
	bge	x13, x11, l.scan_end_16_
# was:	bge	_scan_i_11_, _scan_size_10_, l.scan_end_16_
	lbu	x15, 0(x12)
# was:	lbu	_scan_elem_13_, 0(_scan_arr_9_)
# 	mv	_and_L_18_,_scan_acc_12_
	beq	x16, x0, l.and_false_20_
# was:	beq	_and_L_18_, x0, l.and_false_20_
# 	mv	_and_R_19_,_scan_elem_13_
	beq	x15, x0, l.and_false_20_
# was:	beq	_and_R_19_, x0, l.and_false_20_
	li	x16, 1
# was:	li	_fun_arg_res_17_, 1
	j	l.and_end_21_
l.and_false_20_:
	li	x16, 0
# was:	li	_fun_arg_res_17_, 0
l.and_end_21_:
# 	mv	_scan_acc_12_,_fun_arg_res_17_
	sb	x16, 0(x14)
# was:	sb	_scan_acc_12_, 0(_scan_current_place_14_)
	addi	x14, x14, 1
# was:	addi	_scan_current_place_14_, _scan_current_place_14_, 1
	addi	x12, x12, 1
# was:	addi	_scan_arr_9_, _scan_arr_9_, 1
	addi	x13, x13, 1
# was:	addi	_scan_i_11_, _scan_i_11_, 1
	j	l.scan_start_15_
l.scan_end_16_:
# 	mv	_arr_24_,_let_y_7_
	lw	x19, 0(x10)
# was:	lw	_size_23_, 0(_arr_24_)
	mv	x18, x3
# was:	mv	_mainres_1_, x3
	addi	x11, x19, 3
# was:	addi	_tmp_34_, _size_23_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_34_, _tmp_34_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_34_, _tmp_34_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_34_
	sw	x19, 0(x18)
# was:	sw	_size_23_, 0(_mainres_1_)
	addi	x20, x18, 4
# was:	addi	_addrg_27_, _mainres_1_, 4
	mv	x21, x0
# was:	mv	_i_28_, x0
	addi	x22, x10, 4
# was:	addi	_elem_25_, _arr_24_, 4
l.loop_beg_29_:
	bge	x21, x19, l.loop_end_30_
# was:	bge	_i_28_, _size_23_, l.loop_end_30_
	lbu	x23, 0(x22)
# was:	lbu	_res_26_, 0(_elem_25_)
	addi	x22, x22, 1
# was:	addi	_elem_25_, _elem_25_, 1
# 	mv	_tmp_32_,_res_26_
# 	mv	_fun_arg_res_31_,_tmp_32_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x23, x0, l.wBoolF_33_
# was:	bne	_fun_arg_res_31_, x0, l.wBoolF_33_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_33_:
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_res_26_,_fun_arg_res_31_
	sb	x23, 0(x20)
# was:	sb	_res_26_, 0(_addrg_27_)
	addi	x20, x20, 1
# was:	addi	_addrg_27_, _addrg_27_, 1
	addi	x21, x21, 1
# was:	addi	_i_28_, _i_28_, 1
	j	l.loop_beg_29_
l.loop_end_30_:
	mv	x10, x18
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