	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function f
f.f:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_1_,x10
# 	mv	_param_y_2_,x11
	mv	x12, x10
# was:	mv	_plus_L_6_, _param_x_1_
	li	x10, 2
# was:	li	_plus_R_7_, 2
	add	x10, x12, x10
# was:	add	_times_L_4_, _plus_L_6_, _plus_R_7_
	mv	x12, x11
# was:	mv	_minus_L_8_, _param_y_2_
	li	x11, 2
# was:	li	_minus_R_9_, 2
	sub	x11, x12, x11
# was:	sub	_times_R_5_, _minus_L_8_, _minus_R_9_
	mul	x10, x10, x11
# was:	mul	_fres_3_, _times_L_4_, _times_R_5_
# 	mv	x10,_fres_3_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_a_11_,x10
	mv	x12, x10
# was:	mv	_let_x_13_, _let_a_11_
	li	x10, 2
# was:	li	_let_y_14_, 2
# 	mv	_plus_L_17_,_let_x_13_
	li	x11, 2
# was:	li	_plus_R_18_, 2
	add	x11, x12, x11
# was:	add	_times_L_15_, _plus_L_17_, _plus_R_18_
	mv	x12, x10
# was:	mv	_minus_L_19_, _let_y_14_
	li	x10, 2
# was:	li	_minus_R_20_, 2
	sub	x10, x12, x10
# was:	sub	_times_R_16_, _minus_L_19_, _minus_R_20_
	mul	x10, x11, x10
# was:	mul	_let_b_12_, _times_L_15_, _times_R_16_
# 	mv	_tmp_21_,_let_b_12_
	mv	x18, x10
# was:	mv	_mainres_10_, _tmp_21_
	mv	x10, x18
# was:	mv	x10, _mainres_10_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_10_
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