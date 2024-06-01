	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	li	x11, 40
# was:	li	_size_3_, 40
	bge	x11, x0, l.safe_4_
# was:	bge	_size_3_, x0, l.safe_4_
	li	x10, 3
# was:	li	x10, 3
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_4_:
	mv	x10, x3
# was:	mv	_let_array_2_, x3
	slli	x12, x11, 2
# was:	slli	_tmp_9_, _size_3_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_9_, _tmp_9_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_9_
	sw	x11, 0(x10)
# was:	sw	_size_3_, 0(_let_array_2_)
	addi	x13, x10, 4
# was:	addi	_addr_5_, _let_array_2_, 4
	mv	x12, x0
# was:	mv	_i_6_, x0
l.loop_beg_7_:
	bge	x12, x11, l.loop_end_8_
# was:	bge	_i_6_, _size_3_, l.loop_end_8_
	sw	x12, 0(x13)
# was:	sw	_i_6_, 0(_addr_5_)
	addi	x13, x13, 4
# was:	addi	_addr_5_, _addr_5_, 4
	addi	x12, x12, 1
# was:	addi	_i_6_, _i_6_, 1
	j	l.loop_beg_7_
l.loop_end_8_:
	li	x11, 4
# was:	li	_arr_ind_11_, 4
	addi	x12, x10, 4
# was:	addi	_arr_data_12_, _let_array_2_, 4
	bge	x11, x0, l.nonneg_15_
# was:	bge	_arr_ind_11_, x0, l.nonneg_15_
l.error_14_:
	li	x10, 5
# was:	li	x10, 5
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_15_:
	lw	x10, 0(x10)
# was:	lw	_size_13_, 0(_let_array_2_)
	bge	x11, x10, l.error_14_
# was:	bge	_arr_ind_11_, _size_13_, l.error_14_
	slli	x11, x11, 2
# was:	slli	_arr_ind_11_, _arr_ind_11_, 2
	add	x12, x12, x11
# was:	add	_arr_data_12_, _arr_data_12_, _arr_ind_11_
	lw	x10, 0(x12)
# was:	lw	_let_x_10_, 0(_arr_data_12_)
# 	mv	_tmp_16_,_let_x_10_
	mv	x18, x10
# was:	mv	_mainres_1_, _tmp_16_
	mv	x10, x18
# was:	mv	x10, _mainres_1_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_1_
	addi	x2, x2, 8
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