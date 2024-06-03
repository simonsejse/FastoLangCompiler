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
	li	x11, 0
# was:	li	_minus_L_8_, 0
	li	x10, 5
# was:	li	_minus_R_9_, 5
	sub	x10, x11, x10
# was:	sub	_negate_7_, _minus_L_8_, _minus_R_9_
	sub	x12, x0, x10
# was:	sub	_eq_L_5_, x0, _negate_7_
	li	x11, 5
# was:	li	_eq_R_6_, 5
	li	x10, 0
# was:	li	_and_L_3_, 0
	bne	x12, x11, l.false_10_
# was:	bne	_eq_L_5_, _eq_R_6_, l.false_10_
	li	x10, 1
# was:	li	_and_L_3_, 1
l.false_10_:
	beq	x10, x0, l.and_false_17_
# was:	beq	_and_L_3_, x0, l.and_false_17_
	li	x10, 5
# was:	li	_negate_13_, 5
	sub	x10, x0, x10
# was:	sub	_eq_L_11_, x0, _negate_13_
	li	x11, 0
# was:	li	_minus_L_14_, 0
	li	x12, 5
# was:	li	_minus_R_15_, 5
	sub	x12, x11, x12
# was:	sub	_eq_R_12_, _minus_L_14_, _minus_R_15_
	li	x11, 0
# was:	li	_and_R_4_, 0
	bne	x10, x12, l.false_16_
# was:	bne	_eq_L_11_, _eq_R_12_, l.false_16_
	li	x11, 1
# was:	li	_and_R_4_, 1
l.false_16_:
	beq	x11, x0, l.and_false_17_
# was:	beq	_and_R_4_, x0, l.and_false_17_
	li	x18, 1
# was:	li	_tmp_2_, 1
	j	l.and_end_18_
l.and_false_17_:
	li	x18, 0
# was:	li	_tmp_2_, 0
l.and_end_18_:
# 	mv	_mainres_1_,_tmp_2_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x18, x0, l.wBoolF_19_
# was:	bne	_mainres_1_, x0, l.wBoolF_19_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_19_:
	jal	p.putstring
# was:	jal	p.putstring, x10
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