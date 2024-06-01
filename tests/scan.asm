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
	mv	x13, x3
# was:	mv	_let_a_2_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_6_, _size_3_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_6_, _tmp_6_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_6_
	sw	x10, 0(x13)
# was:	sw	_size_3_, 0(_let_a_2_)
	addi	x11, x13, 4
# was:	addi	_addr_4_, _let_a_2_, 4
	li	x10, 1
# was:	li	_tmp_5_, 1
	sw	x10, 0(x11)
# was:	sw	_tmp_5_, 0(_addr_4_)
	addi	x11, x11, 4
# was:	addi	_addr_4_, _addr_4_, 4
	li	x10, 2
# was:	li	_tmp_5_, 2
	sw	x10, 0(x11)
# was:	sw	_tmp_5_, 0(_addr_4_)
	addi	x11, x11, 4
# was:	addi	_addr_4_, _addr_4_, 4
	li	x10, 3
# was:	li	_tmp_5_, 3
	sw	x10, 0(x11)
# was:	sw	_tmp_5_, 0(_addr_4_)
	addi	x11, x11, 4
# was:	addi	_addr_4_, _addr_4_, 4
	li	x16, 0
# was:	li	_scan_ne_8_, 0
# 	mv	_scan_arr_9_,_let_a_2_
	lw	x11, 0(x13)
# was:	lw	_scan_size_10_, 0(_scan_arr_9_)
	addi	x13, x13, 4
# was:	addi	_scan_arr_9_, _scan_arr_9_, 4
	mv	x10, x3
# was:	mv	_let_b_7_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_20_, _scan_size_10_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_20_, _tmp_20_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_20_
	sw	x11, 0(x10)
# was:	sw	_scan_size_10_, 0(_let_b_7_)
	mv	x12, x0
# was:	mv	_scan_i_11_, x0
# 	mv	_scan_acc_12_,_scan_ne_8_
	mv	x14, x10
# was:	mv	_scan_current_place_14_, _let_b_7_
	addi	x14, x14, 4
# was:	addi	_scan_current_place_14_, _scan_current_place_14_, 4
l.scan_start_15_:
	bge	x12, x11, l.scan_end_16_
# was:	bge	_scan_i_11_, _scan_size_10_, l.scan_end_16_
	lw	x15, 0(x13)
# was:	lw	_scan_elem_13_, 0(_scan_arr_9_)
# 	mv	_plus_L_18_,_scan_acc_12_
# 	mv	_plus_R_19_,_scan_elem_13_
	add	x16, x16, x15
# was:	add	_fun_arg_res_17_, _plus_L_18_, _plus_R_19_
# 	mv	_scan_acc_12_,_fun_arg_res_17_
	sw	x16, 0(x14)
# was:	sw	_scan_acc_12_, 0(_scan_current_place_14_)
	addi	x14, x14, 4
# was:	addi	_scan_current_place_14_, _scan_current_place_14_, 4
	addi	x13, x13, 4
# was:	addi	_scan_arr_9_, _scan_arr_9_, 4
	addi	x12, x12, 1
# was:	addi	_scan_i_11_, _scan_i_11_, 1
	j	l.scan_start_15_
l.scan_end_16_:
# 	mv	_arr_22_,_let_b_7_
	lw	x19, 0(x10)
# was:	lw	_size_21_, 0(_arr_22_)
	mv	x18, x3
# was:	mv	_mainres_1_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_31_, _size_21_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_31_, _tmp_31_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_31_
	sw	x19, 0(x18)
# was:	sw	_size_21_, 0(_mainres_1_)
	addi	x20, x18, 4
# was:	addi	_addrg_25_, _mainres_1_, 4
	mv	x21, x0
# was:	mv	_i_26_, x0
	addi	x23, x10, 4
# was:	addi	_elem_23_, _arr_22_, 4
l.loop_beg_27_:
	bge	x21, x19, l.loop_end_28_
# was:	bge	_i_26_, _size_21_, l.loop_end_28_
	lw	x22, 0(x23)
# was:	lw	_res_24_, 0(_elem_23_)
	addi	x23, x23, 4
# was:	addi	_elem_23_, _elem_23_, 4
# 	mv	_tmp_30_,_res_24_
# 	mv	_fun_arg_res_29_,_tmp_30_
	mv	x10, x22
# was:	mv	x10, _fun_arg_res_29_
	jal	p.putint
# was:	jal	p.putint, x10
# 	mv	_res_24_,_fun_arg_res_29_
	sw	x22, 0(x20)
# was:	sw	_res_24_, 0(_addrg_25_)
	addi	x20, x20, 4
# was:	addi	_addrg_25_, _addrg_25_, 4
	addi	x21, x21, 1
# was:	addi	_i_26_, _i_26_, 1
	j	l.loop_beg_27_
l.loop_end_28_:
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