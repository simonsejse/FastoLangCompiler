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
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -16
	li	x11, 3
# was:	li	_size_14_, 3
	mv	x18, x3
# was:	mv	_arr_8_, x3
	slli	x10, x11, 2
# was:	slli	_tmp_17_, _size_14_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_17_, _tmp_17_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_17_
	sw	x11, 0(x18)
# was:	sw	_size_14_, 0(_arr_8_)
	addi	x10, x18, 4
# was:	addi	_addr_15_, _arr_8_, 4
	li	x11, 1
# was:	li	_tmp_16_, 1
	sw	x11, 0(x10)
# was:	sw	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 4
# was:	addi	_addr_15_, _addr_15_, 4
	li	x11, 2
# was:	li	_tmp_16_, 2
	sw	x11, 0(x10)
# was:	sw	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 4
# was:	addi	_addr_15_, _addr_15_, 4
	li	x11, 3
# was:	li	_tmp_16_, 3
	sw	x11, 0(x10)
# was:	sw	_tmp_16_, 0(_addr_15_)
	addi	x10, x10, 4
# was:	addi	_addr_15_, _addr_15_, 4
	lw	x19, 0(x18)
# was:	lw	_size_9_, 0(_arr_8_)
	li	x10, 0
# was:	li	_let_n_7_, 0
	addi	x18, x18, 4
# was:	addi	_arr_8_, _arr_8_, 4
	mv	x20, x0
# was:	mv	_ind_var_10_, x0
l.loop_beg_12_:
	bge	x20, x19, l.loop_end_13_
# was:	bge	_ind_var_10_, _size_9_, l.loop_end_13_
	lw	x11, 0(x18)
# was:	lw	_tmp_11_, 0(_arr_8_)
	addi	x18, x18, 4
# was:	addi	_arr_8_, _arr_8_, 4
# 	mv	x10,_let_n_7_
# 	mv	x11,_tmp_11_
	jal	f.incr
# was:	jal	f.incr, x10 x11
# 	mv	_tmp_18_,x10
# 	mv	_let_n_7_,_tmp_18_
	addi	x20, x20, 1
# was:	addi	_ind_var_10_, _ind_var_10_, 1
	j	l.loop_beg_12_
l.loop_end_13_:
# 	mv	_tmp_19_,_let_n_7_
	mv	x18, x10
# was:	mv	_mainres_6_, _tmp_19_
	mv	x10, x18
# was:	mv	x10, _mainres_6_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_6_
	addi	x2, x2, 16
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