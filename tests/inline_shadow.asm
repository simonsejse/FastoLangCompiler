	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function zero
f.zero:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_b_1_,x10
# 	mv	_cond_6_,_param_b_1_
	bne	x10, x0, l.then_3_
# was:	bne	_cond_6_, x0, l.then_3_
	j	l.else_4_
l.then_3_:
	li	x10, 0
# was:	li	_zerores_2_, 0
	j	l.endif_5_
l.else_4_:
# 	mv	_arg_7_,_param_b_1_
# 	mv	x10,_arg_7_
	jal	f.zero
# was:	jal	f.zero, x10
# 	mv	_zerores_2_,x10
l.endif_5_:
# 	mv	x10,_zerores_2_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -12
	li	x18, 12332
# was:	li	_tmp_10_, 12332
# 	mv	_let_r1_9_,_tmp_10_
	mv	x10, x18
# was:	mv	x10, _let_r1_9_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 1
# was:	li	_arg_14_, 1
# 	mv	x10,_arg_14_
	jal	f.zero
# was:	jal	f.zero, x10
# 	mv	_let_z_I4_13_,x10
	li	x11, 1
# was:	li	_plus_L_16_, 1
# 	mv	_plus_R_17_,_let_z_I4_13_
	add	x0, x11, x10
# was:	add	_let_a_15_, _plus_L_16_, _plus_R_17_
	li	x11, 2
# was:	li	_plus_L_19_, 2
# 	mv	_plus_R_20_,_let_z_I4_13_
	add	x0, x11, x10
# was:	add	_let_b_18_, _plus_L_19_, _plus_R_20_
	li	x11, 3
# was:	li	_plus_L_22_, 3
# 	mv	_plus_R_23_,_let_z_I4_13_
	add	x11, x11, x10
# was:	add	_let_c_21_, _plus_L_22_, _plus_R_23_
	li	x12, 4
# was:	li	_plus_L_25_, 4
# 	mv	_plus_R_26_,_let_z_I4_13_
	add	x13, x12, x10
# was:	add	_let_d_24_, _plus_L_25_, _plus_R_26_
# 	mv	_let_a_27_,_let_d_24_
# 	mv	_let_b_28_,_let_a_27_
	mv	x10, x11
# was:	mv	_let_c_29_, _let_c_21_
	mv	x12, x13
# was:	mv	_let_d_30_, _let_b_28_
	li	x11, 1000
# was:	li	_times_L_41_, 1000
# 	mv	_times_R_42_,_let_d_30_
	mul	x11, x11, x12
# was:	mul	_plus_L_39_, _times_L_41_, _times_R_42_
	li	x12, 100
# was:	li	_plus_R_40_, 100
	add	x11, x11, x12
# was:	add	_times_L_37_, _plus_L_39_, _plus_R_40_
	mv	x12, x13
# was:	mv	_times_R_38_, _let_a_27_
	mul	x11, x11, x12
# was:	mul	_plus_L_35_, _times_L_37_, _times_R_38_
	li	x12, 10
# was:	li	_plus_R_36_, 10
	add	x11, x11, x12
# was:	add	_times_L_33_, _plus_L_35_, _plus_R_36_
# 	mv	_times_R_34_,_let_c_29_
	mul	x10, x11, x10
# was:	mul	_plus_L_31_, _times_L_33_, _times_R_34_
# 	mv	_plus_R_32_,_let_b_28_
	add	x19, x10, x13
# was:	add	_tmp_12_, _plus_L_31_, _plus_R_32_
# 	mv	_let_r2_11_,_tmp_12_
	mv	x10, x19
# was:	mv	x10, _let_r2_11_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 10000
# was:	li	_times_L_45_, 10000
# 	mv	_times_R_46_,_let_r1_9_
	mul	x10, x10, x18
# was:	mul	_plus_L_43_, _times_L_45_, _times_R_46_
# 	mv	_plus_R_44_,_let_r2_11_
	add	x10, x10, x19
# was:	add	_mainres_8_, _plus_L_43_, _plus_R_44_
# 	mv	x10,_mainres_8_
	addi	x2, x2, 12
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