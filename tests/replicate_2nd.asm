	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function writeInt
f.writeInt:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_b_1_,x10
	mv	x18, x10
# was:	mv	_tmp_3_, _param_b_1_
# 	mv	_writeIntres_2_,_tmp_3_
	mv	x10, x18
# was:	mv	x10, _writeIntres_2_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _writeIntres_2_
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
	li	x11, 10
# was:	li	_replicate_n_6_, 10
	bge	x11, x0, l.safe_8_
# was:	bge	_replicate_n_6_, x0, l.safe_8_
	li	x10, 4
# was:	li	x10, 4
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_8_:
	li	x12, 1
# was:	li	_replicate_a_7_, 1
	mv	x10, x3
# was:	mv	_let_fs_5_, x3
	slli	x13, x11, 2
# was:	slli	_tmp_13_, _replicate_n_6_, 2
	addi	x13, x13, 4
# was:	addi	_tmp_13_, _tmp_13_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_13_
	sw	x11, 0(x10)
# was:	sw	_replicate_n_6_, 0(_let_fs_5_)
	addi	x14, x10, 4
# was:	addi	_replicate_addr_10_, _let_fs_5_, 4
	mv	x13, x0
# was:	mv	_replicate_i_9_, x0
l.replicate_start_11_:
	bge	x13, x11, l.replicate_end_12_
# was:	bge	_replicate_i_9_, _replicate_n_6_, l.replicate_end_12_
	sw	x12, 0(x14)
# was:	sw	_replicate_a_7_, 0(_replicate_addr_10_)
	addi	x14, x14, 4
# was:	addi	_replicate_addr_10_, _replicate_addr_10_, 4
	addi	x13, x13, 1
# was:	addi	_replicate_i_9_, _replicate_i_9_, 1
	j	l.replicate_start_11_
l.replicate_end_12_:
# 	mv	_arr_15_,_let_fs_5_
	lw	x19, 0(x10)
# was:	lw	_size_14_, 0(_arr_15_)
	mv	x18, x3
# was:	mv	_mainres_4_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_23_, _size_14_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_23_, _tmp_23_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_23_
	sw	x19, 0(x18)
# was:	sw	_size_14_, 0(_mainres_4_)
	addi	x20, x18, 4
# was:	addi	_addrg_18_, _mainres_4_, 4
	mv	x21, x0
# was:	mv	_i_19_, x0
	addi	x22, x10, 4
# was:	addi	_elem_16_, _arr_15_, 4
l.loop_beg_20_:
	bge	x21, x19, l.loop_end_21_
# was:	bge	_i_19_, _size_14_, l.loop_end_21_
	lw	x10, 0(x22)
# was:	lw	_res_17_, 0(_elem_16_)
	addi	x22, x22, 4
# was:	addi	_elem_16_, _elem_16_, 4
# 	mv	x10,_res_17_
	jal	f.writeInt
# was:	jal	f.writeInt, x10
# 	mv	_tmp_22_,x10
# 	mv	_res_17_,_tmp_22_
	sw	x10, 0(x20)
# was:	sw	_res_17_, 0(_addrg_18_)
	addi	x20, x20, 4
# was:	addi	_addrg_18_, _addrg_18_, 4
	addi	x21, x21, 1
# was:	addi	_i_19_, _i_19_, 1
	j	l.loop_beg_20_
l.loop_end_21_:
	mv	x10, x18
# was:	mv	x10, _mainres_4_
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