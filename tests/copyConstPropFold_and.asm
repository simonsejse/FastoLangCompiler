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
	li	x10, 1
# was:	li	_let_x1_2_, 1
# 	mv	_and_L_4_,_let_x1_2_
	beq	x10, x0, l.and_false_6_
# was:	beq	_and_L_4_, x0, l.and_false_6_
# 	mv	_and_R_5_,_let_x1_2_
	beq	x10, x0, l.and_false_6_
# was:	beq	_and_R_5_, x0, l.and_false_6_
	li	x11, 1
# was:	li	_let_y1_3_, 1
	j	l.and_end_7_
l.and_false_6_:
	li	x11, 0
# was:	li	_let_y1_3_, 0
l.and_end_7_:
# 	mv	_tmp_9_,_let_y1_3_
# 	mv	_let_a_8_,_tmp_9_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_10_
# was:	bne	_let_a_8_, x0, l.wBoolF_10_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_10_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 0
# was:	li	_let_x2_11_, 0
# 	mv	_and_L_13_,_let_x2_11_
	beq	x10, x0, l.and_false_15_
# was:	beq	_and_L_13_, x0, l.and_false_15_
	li	x10, 1
# was:	li	_and_R_14_, 1
	beq	x10, x0, l.and_false_15_
# was:	beq	_and_R_14_, x0, l.and_false_15_
	li	x11, 1
# was:	li	_let_y2_12_, 1
	j	l.and_end_16_
l.and_false_15_:
	li	x11, 0
# was:	li	_let_y2_12_, 0
l.and_end_16_:
# 	mv	_tmp_18_,_let_y2_12_
# 	mv	_let_b_17_,_tmp_18_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_19_
# was:	bne	_let_b_17_, x0, l.wBoolF_19_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_19_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 1
# was:	li	_let_x3_20_, 1
# 	mv	_and_L_22_,_let_x3_20_
	beq	x10, x0, l.and_false_24_
# was:	beq	_and_L_22_, x0, l.and_false_24_
	li	x10, 0
# was:	li	_and_R_23_, 0
	beq	x10, x0, l.and_false_24_
# was:	beq	_and_R_23_, x0, l.and_false_24_
	li	x11, 1
# was:	li	_let_y3_21_, 1
	j	l.and_end_25_
l.and_false_24_:
	li	x11, 0
# was:	li	_let_y3_21_, 0
l.and_end_25_:
# 	mv	_tmp_27_,_let_y3_21_
# 	mv	_let_c_26_,_tmp_27_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_28_
# was:	bne	_let_c_26_, x0, l.wBoolF_28_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_28_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 0
# was:	li	_let_x4_29_, 0
# 	mv	_and_L_31_,_let_x4_29_
	beq	x10, x0, l.and_false_33_
# was:	beq	_and_L_31_, x0, l.and_false_33_
# 	mv	_and_R_32_,_let_x4_29_
	beq	x10, x0, l.and_false_33_
# was:	beq	_and_R_32_, x0, l.and_false_33_
	li	x11, 1
# was:	li	_let_y4_30_, 1
	j	l.and_end_34_
l.and_false_33_:
	li	x11, 0
# was:	li	_let_y4_30_, 0
l.and_end_34_:
# 	mv	_tmp_36_,_let_y4_30_
# 	mv	_let_d_35_,_tmp_36_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_37_
# was:	bne	_let_d_35_, x0, l.wBoolF_37_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_37_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 1
# was:	li	_let_x5_38_, 1
	li	x11, 0
# was:	li	_let_y5_39_, 0
# 	mv	_and_L_41_,_let_x5_38_
	beq	x10, x0, l.and_false_47_
# was:	beq	_and_L_41_, x0, l.and_false_47_
# 	mv	_and_L_43_,_let_y5_39_
	beq	x11, x0, l.and_false_45_
# was:	beq	_and_L_43_, x0, l.and_false_45_
# 	mv	_and_R_44_,_let_x5_38_
	beq	x10, x0, l.and_false_45_
# was:	beq	_and_R_44_, x0, l.and_false_45_
	li	x10, 1
# was:	li	_and_R_42_, 1
	j	l.and_end_46_
l.and_false_45_:
	li	x10, 0
# was:	li	_and_R_42_, 0
l.and_end_46_:
	beq	x10, x0, l.and_false_47_
# was:	beq	_and_R_42_, x0, l.and_false_47_
	li	x10, 1
# was:	li	_let_z5_40_, 1
	j	l.and_end_48_
l.and_false_47_:
	li	x10, 0
# was:	li	_let_z5_40_, 0
l.and_end_48_:
# 	mv	_tmp_50_,_let_z5_40_
	mv	x11, x10
# was:	mv	_let_e_49_, _tmp_50_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_51_
# was:	bne	_let_e_49_, x0, l.wBoolF_51_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_51_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 1
# was:	li	_let_x6_52_, 1
# 	mv	_and_L_54_,_let_x6_52_
	beq	x10, x0, l.and_false_56_
# was:	beq	_and_L_54_, x0, l.and_false_56_
	li	x10, 0
# was:	li	_and_R_55_, 0
	beq	x10, x0, l.and_false_56_
# was:	beq	_and_R_55_, x0, l.and_false_56_
	li	x10, 1
# was:	li	_let_y6_53_, 1
	j	l.and_end_57_
l.and_false_56_:
	li	x10, 0
# was:	li	_let_y6_53_, 0
l.and_end_57_:
# 	mv	_and_L_59_,_let_y6_53_
	beq	x10, x0, l.and_false_61_
# was:	beq	_and_L_59_, x0, l.and_false_61_
	li	x10, 1
# was:	li	_and_R_60_, 1
	beq	x10, x0, l.and_false_61_
# was:	beq	_and_R_60_, x0, l.and_false_61_
	li	x10, 1
# was:	li	_let_z6_58_, 1
	j	l.and_end_62_
l.and_false_61_:
	li	x10, 0
# was:	li	_let_z6_58_, 0
l.and_end_62_:
# 	mv	_tmp_64_,_let_z6_58_
	mv	x11, x10
# was:	mv	_let_f_63_, _tmp_64_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x11, x0, l.wBoolF_65_
# was:	bne	_let_f_63_, x0, l.wBoolF_65_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_65_:
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x0, 1
# was:	li	_let_x7_66_, 1
	li	x10, 0
# was:	li	_let_x7_67_, 0
# 	mv	_and_L_69_,_let_x7_67_
	beq	x10, x0, l.and_false_71_
# was:	beq	_and_L_69_, x0, l.and_false_71_
	li	x10, 1
# was:	li	_and_R_70_, 1
	beq	x10, x0, l.and_false_71_
# was:	beq	_and_R_70_, x0, l.and_false_71_
	li	x10, 1
# was:	li	_let_y7_68_, 1
	j	l.and_end_72_
l.and_false_71_:
	li	x10, 0
# was:	li	_let_y7_68_, 0
l.and_end_72_:
# 	mv	_tmp_73_,_let_y7_68_
	mv	x18, x10
# was:	mv	_mainres_1_, _tmp_73_
	la	x10, s.true
# was:	la	x10, s.true
	bne	x18, x0, l.wBoolF_74_
# was:	bne	_mainres_1_, x0, l.wBoolF_74_
	la	x10, s.false
# was:	la	x10, s.false
l.wBoolF_74_:
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