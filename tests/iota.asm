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
	li	x10, 7
# was:	li	_size_3_, 7
	bge	x10, x0, l.safe_4_
# was:	bge	_size_3_, x0, l.safe_4_
	li	x10, 2
# was:	li	x10, 2
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_4_:
	mv	x18, x3
# was:	mv	_let_a_2_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_9_, _size_3_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_9_, _tmp_9_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_9_
	sw	x10, 0(x18)
# was:	sw	_size_3_, 0(_let_a_2_)
	addi	x12, x18, 4
# was:	addi	_addr_5_, _let_a_2_, 4
	mv	x11, x0
# was:	mv	_i_6_, x0
l.loop_beg_7_:
	bge	x11, x10, l.loop_end_8_
# was:	bge	_i_6_, _size_3_, l.loop_end_8_
	sw	x11, 0(x12)
# was:	sw	_i_6_, 0(_addr_5_)
	addi	x12, x12, 4
# was:	addi	_addr_5_, _addr_5_, 4
	addi	x11, x11, 1
# was:	addi	_i_6_, _i_6_, 1
	j	l.loop_beg_7_
l.loop_end_8_:
	li	x11, 0
# was:	li	_arr_ind_12_, 0
	addi	x12, x18, 4
# was:	addi	_arr_data_13_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_16_
# was:	bge	_arr_ind_12_, x0, l.nonneg_16_
l.error_15_:
	li	x10, 3
# was:	li	x10, 3
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_16_:
	lw	x10, 0(x18)
# was:	lw	_size_14_, 0(_let_a_2_)
	bge	x11, x10, l.error_15_
# was:	bge	_arr_ind_12_, _size_14_, l.error_15_
	slli	x11, x11, 2
# was:	slli	_arr_ind_12_, _arr_ind_12_, 2
	add	x12, x12, x11
# was:	add	_arr_data_13_, _arr_data_13_, _arr_ind_12_
	lw	x10, 0(x12)
# was:	lw	_tmp_11_, 0(_arr_data_13_)
# 	mv	_let_tmp_10_,_tmp_11_
# 	mv	x10,_let_tmp_10_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 1
# was:	li	_arr_ind_19_, 1
	addi	x12, x18, 4
# was:	addi	_arr_data_20_, _let_a_2_, 4
	bge	x10, x0, l.nonneg_23_
# was:	bge	_arr_ind_19_, x0, l.nonneg_23_
l.error_22_:
	li	x10, 4
# was:	li	x10, 4
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_23_:
	lw	x11, 0(x18)
# was:	lw	_size_21_, 0(_let_a_2_)
	bge	x10, x11, l.error_22_
# was:	bge	_arr_ind_19_, _size_21_, l.error_22_
	slli	x10, x10, 2
# was:	slli	_arr_ind_19_, _arr_ind_19_, 2
	add	x12, x12, x10
# was:	add	_arr_data_20_, _arr_data_20_, _arr_ind_19_
	lw	x10, 0(x12)
# was:	lw	_tmp_18_, 0(_arr_data_20_)
# 	mv	_let_tmp_17_,_tmp_18_
# 	mv	x10,_let_tmp_17_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x11, 2
# was:	li	_arr_ind_26_, 2
	addi	x12, x18, 4
# was:	addi	_arr_data_27_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_30_
# was:	bge	_arr_ind_26_, x0, l.nonneg_30_
l.error_29_:
	li	x10, 5
# was:	li	x10, 5
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_30_:
	lw	x10, 0(x18)
# was:	lw	_size_28_, 0(_let_a_2_)
	bge	x11, x10, l.error_29_
# was:	bge	_arr_ind_26_, _size_28_, l.error_29_
	slli	x11, x11, 2
# was:	slli	_arr_ind_26_, _arr_ind_26_, 2
	add	x12, x12, x11
# was:	add	_arr_data_27_, _arr_data_27_, _arr_ind_26_
	lw	x10, 0(x12)
# was:	lw	_tmp_25_, 0(_arr_data_27_)
# 	mv	_let_tmp_24_,_tmp_25_
# 	mv	x10,_let_tmp_24_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x11, 3
# was:	li	_arr_ind_33_, 3
	addi	x12, x18, 4
# was:	addi	_arr_data_34_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_37_
# was:	bge	_arr_ind_33_, x0, l.nonneg_37_
l.error_36_:
	li	x10, 6
# was:	li	x10, 6
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_37_:
	lw	x10, 0(x18)
# was:	lw	_size_35_, 0(_let_a_2_)
	bge	x11, x10, l.error_36_
# was:	bge	_arr_ind_33_, _size_35_, l.error_36_
	slli	x11, x11, 2
# was:	slli	_arr_ind_33_, _arr_ind_33_, 2
	add	x12, x12, x11
# was:	add	_arr_data_34_, _arr_data_34_, _arr_ind_33_
	lw	x10, 0(x12)
# was:	lw	_tmp_32_, 0(_arr_data_34_)
# 	mv	_let_tmp_31_,_tmp_32_
# 	mv	x10,_let_tmp_31_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x11, 4
# was:	li	_arr_ind_40_, 4
	addi	x10, x18, 4
# was:	addi	_arr_data_41_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_44_
# was:	bge	_arr_ind_40_, x0, l.nonneg_44_
l.error_43_:
	li	x10, 7
# was:	li	x10, 7
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_44_:
	lw	x12, 0(x18)
# was:	lw	_size_42_, 0(_let_a_2_)
	bge	x11, x12, l.error_43_
# was:	bge	_arr_ind_40_, _size_42_, l.error_43_
	slli	x11, x11, 2
# was:	slli	_arr_ind_40_, _arr_ind_40_, 2
	add	x10, x10, x11
# was:	add	_arr_data_41_, _arr_data_41_, _arr_ind_40_
	lw	x10, 0(x10)
# was:	lw	_tmp_39_, 0(_arr_data_41_)
# 	mv	_let_tmp_38_,_tmp_39_
# 	mv	x10,_let_tmp_38_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x11, 5
# was:	li	_arr_ind_47_, 5
	addi	x10, x18, 4
# was:	addi	_arr_data_48_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_51_
# was:	bge	_arr_ind_47_, x0, l.nonneg_51_
l.error_50_:
	li	x10, 8
# was:	li	x10, 8
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_51_:
	lw	x12, 0(x18)
# was:	lw	_size_49_, 0(_let_a_2_)
	bge	x11, x12, l.error_50_
# was:	bge	_arr_ind_47_, _size_49_, l.error_50_
	slli	x11, x11, 2
# was:	slli	_arr_ind_47_, _arr_ind_47_, 2
	add	x10, x10, x11
# was:	add	_arr_data_48_, _arr_data_48_, _arr_ind_47_
	lw	x10, 0(x10)
# was:	lw	_tmp_46_, 0(_arr_data_48_)
# 	mv	_let_tmp_45_,_tmp_46_
# 	mv	x10,_let_tmp_45_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x11, 6
# was:	li	_arr_ind_54_, 6
	addi	x10, x18, 4
# was:	addi	_arr_data_55_, _let_a_2_, 4
	bge	x11, x0, l.nonneg_58_
# was:	bge	_arr_ind_54_, x0, l.nonneg_58_
l.error_57_:
	li	x10, 9
# was:	li	x10, 9
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_58_:
	lw	x12, 0(x18)
# was:	lw	_size_56_, 0(_let_a_2_)
	bge	x11, x12, l.error_57_
# was:	bge	_arr_ind_54_, _size_56_, l.error_57_
	slli	x11, x11, 2
# was:	slli	_arr_ind_54_, _arr_ind_54_, 2
	add	x10, x10, x11
# was:	add	_arr_data_55_, _arr_data_55_, _arr_ind_54_
	lw	x10, 0(x10)
# was:	lw	_tmp_53_, 0(_arr_data_55_)
# 	mv	_let_tmp_52_,_tmp_53_
# 	mv	x10,_let_tmp_52_
	jal	p.putint
# was:	jal	p.putint, x10
	li	x10, 0
# was:	li	_mainres_1_, 0
# 	mv	x10,_mainres_1_
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