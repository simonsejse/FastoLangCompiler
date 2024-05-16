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
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_y_2_,x10
	mv	x11, x10
# was:	mv	_times_L_4_, _let_y_2_
# 	mv	_times_R_5_,_let_y_2_
	mul	x12, x11, x10
# was:	mul	_let_x_3_, _times_L_4_, _times_R_5_
# 	mv	_plus_L_9_,_let_x_3_
	li	x11, 3
# was:	li	_plus_R_10_, 3
	add	x11, x12, x11
# was:	add	_let_x_8_, _plus_L_9_, _plus_R_10_
# 	mv	_plus_L_12_,_let_x_8_
# 	mv	_plus_R_13_,_let_y_2_
	add	x12, x11, x10
# was:	add	_let_x_11_, _plus_L_12_, _plus_R_13_
# 	mv	_plus_L_14_,_let_x_11_
	li	x11, 8
# was:	li	_plus_R_15_, 8
	add	x0, x12, x11
# was:	add	_let_x_7_, _plus_L_14_, _plus_R_15_
# 	mv	_let_z_6_,_let_y_2_
	mv	x12, x10
# was:	mv	_plus_L_17_, _let_y_2_
	li	x11, 2
# was:	li	_plus_R_18_, 2
	add	x11, x12, x11
# was:	add	_let_x_16_, _plus_L_17_, _plus_R_18_
# 	mv	_plus_L_22_,_let_x_16_
	li	x12, 2
# was:	li	_plus_R_23_, 2
	add	x12, x11, x12
# was:	add	_plus_L_20_, _plus_L_22_, _plus_R_23_
	mv	x13, x10
# was:	mv	_plus_R_21_, _let_z_6_
	add	x0, x12, x13
# was:	add	_let_w_19_, _plus_L_20_, _plus_R_21_
	mv	x12, x10
# was:	mv	_plus_L_26_, _let_y_2_
	li	x10, 3
# was:	li	_plus_R_27_, 3
	add	x10, x12, x10
# was:	add	_let_y_25_, _plus_L_26_, _plus_R_27_
# 	mv	_times_L_28_,_let_x_16_
# 	mv	_times_R_29_,_let_y_25_
	mul	x10, x11, x10
# was:	mul	_let_v_24_, _times_L_28_, _times_R_29_
# 	mv	_tmp_30_,_let_v_24_
	mv	x18, x10
# was:	mv	_mainres_1_, _tmp_30_
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