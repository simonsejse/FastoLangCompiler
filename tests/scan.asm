	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function incr
f.incr:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_1_,x10
# 	mv	_param_b_2_,x11
# 	mv	_plus_L_4_,_param_a_1_
# 	mv	_plus_R_5_,_param_b_2_
	add	x10, x10, x11
# was:	add	_incrres_3_, _plus_L_4_, _plus_R_5_
# 	mv	x10,_incrres_3_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function writeInt
f.writeInt:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_n_6_,x10
	mv	x18, x10
# was:	mv	_tmp_8_, _param_n_6_
# 	mv	_writeIntres_7_,_tmp_8_
	mv	x10, x18
# was:	mv	x10, _writeIntres_7_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _writeIntres_7_
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
# was:	li	_size_11_, 3
	mv	x19, x3
# was:	mv	_let_a_10_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_14_, _size_11_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_14_, _tmp_14_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_14_
	sw	x10, 0(x19)
# was:	sw	_size_11_, 0(_let_a_10_)
	addi	x10, x19, 4
# was:	addi	_addr_12_, _let_a_10_, 4
	li	x11, 1
# was:	li	_tmp_13_, 1
	sw	x11, 0(x10)
# was:	sw	_tmp_13_, 0(_addr_12_)
	addi	x10, x10, 4
# was:	addi	_addr_12_, _addr_12_, 4
	li	x11, 2
# was:	li	_tmp_13_, 2
	sw	x11, 0(x10)
# was:	sw	_tmp_13_, 0(_addr_12_)
	addi	x10, x10, 4
# was:	addi	_addr_12_, _addr_12_, 4
	li	x11, 3
# was:	li	_tmp_13_, 3
	sw	x11, 0(x10)
# was:	sw	_tmp_13_, 0(_addr_12_)
	addi	x10, x10, 4
# was:	addi	_addr_12_, _addr_12_, 4
	li	x10, 0
# was:	li	_scan_ne_16_, 0
# 	mv	_scan_arr_17_,_let_a_10_
	lw	x20, 0(x19)
# was:	lw	_scan_size_18_, 0(_scan_arr_17_)
	addi	x19, x19, 4
# was:	addi	_scan_arr_17_, _scan_arr_17_, 4
	mv	x18, x3
# was:	mv	_let_b_15_, x3
	slli	x11, x20, 2
# was:	slli	_tmp_26_, _scan_size_18_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_26_, _tmp_26_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_26_
	sw	x20, 0(x18)
# was:	sw	_scan_size_18_, 0(_let_b_15_)
	mv	x21, x0
# was:	mv	_scan_i_19_, x0
# 	mv	_scan_acc_20_,_scan_ne_16_
	mv	x22, x18
# was:	mv	_scan_current_place_22_, _let_b_15_
	addi	x22, x22, 4
# was:	addi	_scan_current_place_22_, _scan_current_place_22_, 4
l.scan_start_23_:
	bge	x21, x20, l.scan_end_24_
# was:	bge	_scan_i_19_, _scan_size_18_, l.scan_end_24_
	lw	x11, 0(x19)
# was:	lw	_scan_elem_21_, 0(_scan_arr_17_)
# 	mv	x10,_scan_acc_20_
# 	mv	x11,_scan_elem_21_
	jal	f.incr
# was:	jal	f.incr, x10 x11
# 	mv	_tmp_25_,x10
# 	mv	_scan_acc_20_,_tmp_25_
	sw	x10, 0(x22)
# was:	sw	_scan_acc_20_, 0(_scan_current_place_22_)
	addi	x22, x22, 4
# was:	addi	_scan_current_place_22_, _scan_current_place_22_, 4
	addi	x19, x19, 4
# was:	addi	_scan_arr_17_, _scan_arr_17_, 4
	addi	x21, x21, 1
# was:	addi	_scan_i_19_, _scan_i_19_, 1
	j	l.scan_start_23_
l.scan_end_24_:
	mv	x10, x18
# was:	mv	_arr_28_, _let_b_15_
	lw	x18, 0(x10)
# was:	lw	_size_27_, 0(_arr_28_)
	mv	x19, x3
# was:	mv	_mainres_9_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_36_, _size_27_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_36_, _tmp_36_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_36_
	sw	x18, 0(x19)
# was:	sw	_size_27_, 0(_mainres_9_)
	addi	x20, x19, 4
# was:	addi	_addrg_31_, _mainres_9_, 4
	mv	x21, x0
# was:	mv	_i_32_, x0
	addi	x22, x10, 4
# was:	addi	_elem_29_, _arr_28_, 4
l.loop_beg_33_:
	bge	x21, x18, l.loop_end_34_
# was:	bge	_i_32_, _size_27_, l.loop_end_34_
	lw	x10, 0(x22)
# was:	lw	_res_30_, 0(_elem_29_)
	addi	x22, x22, 4
# was:	addi	_elem_29_, _elem_29_, 4
# 	mv	x10,_res_30_
	jal	f.writeInt
# was:	jal	f.writeInt, x10
# 	mv	_tmp_35_,x10
# 	mv	_res_30_,_tmp_35_
	sw	x10, 0(x20)
# was:	sw	_res_30_, 0(_addrg_31_)
	addi	x20, x20, 4
# was:	addi	_addrg_31_, _addrg_31_, 4
	addi	x21, x21, 1
# was:	addi	_i_32_, _i_32_, 1
	j	l.loop_beg_33_
l.loop_end_34_:
	mv	x10, x19
# was:	mv	x10, _mainres_9_
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