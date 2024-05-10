	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function fibo
f.fibo:
	sw	x1, -4(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -12
	mv	x18, x10
# was:	mv	_param_n_1_, x10
# 	mv	_eq_L_7_,_param_n_1_
	li	x11, 0
# was:	li	_eq_R_8_, 0
	li	x10, 0
# was:	li	_cond_6_, 0
	bne	x18, x11, l.false_9_
# was:	bne	_eq_L_7_, _eq_R_8_, l.false_9_
	li	x10, 1
# was:	li	_cond_6_, 1
l.false_9_:
	bne	x10, x0, l.then_3_
# was:	bne	_cond_6_, x0, l.then_3_
	j	l.else_4_
l.then_3_:
	li	x10, 0
# was:	li	_fibores_2_, 0
	j	l.endif_5_
l.else_4_:
# 	mv	_eq_L_14_,_param_n_1_
	li	x11, 1
# was:	li	_eq_R_15_, 1
	li	x10, 0
# was:	li	_cond_13_, 0
	bne	x18, x11, l.false_16_
# was:	bne	_eq_L_14_, _eq_R_15_, l.false_16_
	li	x10, 1
# was:	li	_cond_13_, 1
l.false_16_:
	bne	x10, x0, l.then_10_
# was:	bne	_cond_13_, x0, l.then_10_
	j	l.else_11_
l.then_10_:
	li	x10, 1
# was:	li	_fibores_2_, 1
	j	l.endif_12_
l.else_11_:
# 	mv	_minus_L_20_,_param_n_1_
	li	x10, 1
# was:	li	_minus_R_21_, 1
	sub	x10, x18, x10
# was:	sub	_arg_19_, _minus_L_20_, _minus_R_21_
# 	mv	x10,_arg_19_
	jal	f.fibo
# was:	jal	f.fibo, x10
	mv	x19, x10
# was:	mv	_plus_L_17_, x10
# 	mv	_minus_L_23_,_param_n_1_
	li	x10, 2
# was:	li	_minus_R_24_, 2
	sub	x10, x18, x10
# was:	sub	_arg_22_, _minus_L_23_, _minus_R_24_
# 	mv	x10,_arg_22_
	jal	f.fibo
# was:	jal	f.fibo, x10
# 	mv	_plus_R_18_,x10
	add	x10, x19, x10
# was:	add	_fibores_2_, _plus_L_17_, _plus_R_18_
l.endif_12_:
l.endif_5_:
# 	mv	x10,_fibores_2_
	addi	x2, x2, 12
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_n_26_,x10
# 	mv	_arg_28_,_let_n_26_
# 	mv	x10,_arg_28_
	jal	f.fibo
# was:	jal	f.fibo, x10
# 	mv	_tmp_27_,x10
	mv	x18, x10
# was:	mv	_mainres_25_, _tmp_27_
	mv	x10, x18
# was:	mv	x10, _mainres_25_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_25_
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