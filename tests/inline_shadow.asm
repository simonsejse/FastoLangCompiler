	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function f
f.f:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_a_1_,x10
# 	mv	_param_b_2_,x11
# 	mv	_param_c_3_,x12
# 	mv	_param_d_4_,x13
	li	x14, 1000
# was:	li	_times_L_16_, 1000
# 	mv	_times_R_17_,_param_a_1_
	mul	x14, x14, x10
# was:	mul	_plus_L_14_, _times_L_16_, _times_R_17_
	li	x10, 100
# was:	li	_plus_R_15_, 100
	add	x10, x14, x10
# was:	add	_times_L_12_, _plus_L_14_, _plus_R_15_
# 	mv	_times_R_13_,_param_b_2_
	mul	x11, x10, x11
# was:	mul	_plus_L_10_, _times_L_12_, _times_R_13_
	li	x10, 10
# was:	li	_plus_R_11_, 10
	add	x10, x11, x10
# was:	add	_times_L_8_, _plus_L_10_, _plus_R_11_
# 	mv	_times_R_9_,_param_c_3_
	mul	x10, x10, x12
# was:	mul	_plus_L_6_, _times_L_8_, _times_R_9_
# 	mv	_plus_R_7_,_param_d_4_
	add	x10, x10, x13
# was:	add	_fres_5_, _plus_L_6_, _plus_R_7_
# 	mv	x10,_fres_5_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function zero
f.zero:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_b_18_,x10
# 	mv	_cond_23_,_param_b_18_
	bne	x10, x0, l.then_20_
# was:	bne	_cond_23_, x0, l.then_20_
	j	l.else_21_
l.then_20_:
	li	x10, 0
# was:	li	_zerores_19_, 0
	j	l.endif_22_
l.else_21_:
# 	mv	_arg_24_,_param_b_18_
# 	mv	x10,_arg_24_
	jal	f.zero
# was:	jal	f.zero, x10
# 	mv	_zerores_19_,x10
l.endif_22_:
# 	mv	x10,_zerores_19_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function test
f.test:
	sw	x1, -4(x2)
	addi	x2, x2, -4
	mv	x14, x10
# was:	mv	_param_z_25_, x10
	li	x10, 1
# was:	li	_plus_L_28_, 1
# 	mv	_plus_R_29_,_param_z_25_
	add	x11, x10, x14
# was:	add	_let_a_27_, _plus_L_28_, _plus_R_29_
	li	x10, 2
# was:	li	_plus_L_31_, 2
# 	mv	_plus_R_32_,_param_z_25_
	add	x13, x10, x14
# was:	add	_let_b_30_, _plus_L_31_, _plus_R_32_
	li	x10, 3
# was:	li	_plus_L_34_, 3
# 	mv	_plus_R_35_,_param_z_25_
	add	x12, x10, x14
# was:	add	_let_c_33_, _plus_L_34_, _plus_R_35_
	li	x10, 4
# was:	li	_plus_L_37_, 4
# 	mv	_plus_R_38_,_param_z_25_
	add	x10, x10, x14
# was:	add	_let_d_36_, _plus_L_37_, _plus_R_38_
# 	mv	_arg_39_,_let_d_36_
# 	mv	_arg_40_,_let_a_27_
# 	mv	_arg_41_,_let_c_33_
# 	mv	_arg_42_,_let_b_30_
# 	mv	x10,_arg_39_
# 	mv	x11,_arg_40_
# 	mv	x12,_arg_41_
# 	mv	x13,_arg_42_
	jal	f.f
# was:	jal	f.f, x10 x11 x12 x13
# 	mv	_testres_26_,x10
# 	mv	x10,_testres_26_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -12
	li	x10, 0
# was:	li	_arg_46_, 0
# 	mv	x10,_arg_46_
	jal	f.test
# was:	jal	f.test, x10
# 	mv	_tmp_45_,x10
	mv	x19, x10
# was:	mv	_let_r1_44_, _tmp_45_
	mv	x10, x19
# was:	mv	x10, _let_r1_44_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 1
# was:	li	_arg_50_, 1
# 	mv	x10,_arg_50_
	jal	f.zero
# was:	jal	f.zero, x10
# 	mv	_arg_49_,x10
# 	mv	x10,_arg_49_
	jal	f.test
# was:	jal	f.test, x10
# 	mv	_tmp_48_,x10
	mv	x18, x10
# was:	mv	_let_r2_47_, _tmp_48_
	mv	x10, x18
# was:	mv	x10, _let_r2_47_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 10000
# was:	li	_times_L_53_, 10000
# 	mv	_times_R_54_,_let_r1_44_
	mul	x10, x10, x19
# was:	mul	_plus_L_51_, _times_L_53_, _times_R_54_
# 	mv	_plus_R_52_,_let_r2_47_
	add	x10, x10, x18
# was:	add	_mainres_43_, _plus_L_51_, _plus_R_52_
# 	mv	x10,_mainres_43_
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