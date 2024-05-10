	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function read_char
f.read_char:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_i_1_,x10
	jal	p.getchar
# was:	jal	p.getchar, 
# 	mv	_read_charres_2_,x10
# 	mv	x10,_read_charres_2_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function read_string
f.read_string:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_n_3_,x10
	mv	x12, x10
# was:	mv	_size_9_, _param_n_3_
	bge	x12, x0, l.safe_10_
# was:	bge	_size_9_, x0, l.safe_10_
	li	x10, 3
# was:	li	x10, 3
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_10_:
	mv	x10, x3
# was:	mv	_arr_6_, x3
	slli	x11, x12, 2
# was:	slli	_tmp_15_, _size_9_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_15_, _tmp_15_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_15_
	sw	x12, 0(x10)
# was:	sw	_size_9_, 0(_arr_6_)
	addi	x13, x10, 4
# was:	addi	_addr_11_, _arr_6_, 4
	mv	x11, x0
# was:	mv	_i_12_, x0
l.loop_beg_13_:
	bge	x11, x12, l.loop_end_14_
# was:	bge	_i_12_, _size_9_, l.loop_end_14_
	sw	x11, 0(x13)
# was:	sw	_i_12_, 0(_addr_11_)
	addi	x13, x13, 4
# was:	addi	_addr_11_, _addr_11_, 4
	addi	x11, x11, 1
# was:	addi	_i_12_, _i_12_, 1
	j	l.loop_beg_13_
l.loop_end_14_:
	lw	x18, 0(x10)
# was:	lw	_size_5_, 0(_arr_6_)
	mv	x19, x3
# was:	mv	_read_stringres_4_, x3
	addi	x11, x18, 3
# was:	addi	_tmp_21_, _size_5_, 3
	andi	x11, x11, -4
# was:	andi	_tmp_21_, _tmp_21_, -4
	addi	x11, x11, 4
# was:	addi	_tmp_21_, _tmp_21_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_21_
	sw	x18, 0(x19)
# was:	sw	_size_5_, 0(_read_stringres_4_)
	addi	x20, x19, 4
# was:	addi	_addrg_16_, _read_stringres_4_, 4
	mv	x21, x0
# was:	mv	_i_17_, x0
	addi	x22, x10, 4
# was:	addi	_elem_7_, _arr_6_, 4
l.loop_beg_18_:
	bge	x21, x18, l.loop_end_19_
# was:	bge	_i_17_, _size_5_, l.loop_end_19_
	lw	x10, 0(x22)
# was:	lw	_res_8_, 0(_elem_7_)
	addi	x22, x22, 4
# was:	addi	_elem_7_, _elem_7_, 4
# 	mv	x10,_res_8_
	jal	f.read_char
# was:	jal	f.read_char, x10
# 	mv	_tmp_20_,x10
# 	mv	_res_8_,_tmp_20_
	sb	x10, 0(x20)
# was:	sb	_res_8_, 0(_addrg_16_)
	addi	x20, x20, 1
# was:	addi	_addrg_16_, _addrg_16_, 1
	addi	x21, x21, 1
# was:	addi	_i_17_, _i_17_, 1
	j	l.loop_beg_18_
l.loop_end_19_:
	mv	x10, x19
# was:	mv	x10, _read_stringres_4_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function add_one
f.add_one:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_22_,x10
	mv	x11, x10
# was:	mv	_plus_L_24_, _param_x_22_
	li	x10, 1
# was:	li	_plus_R_25_, 1
	add	x10, x11, x10
# was:	add	_add_oneres_23_, _plus_L_24_, _plus_R_25_
# 	mv	x10,_add_oneres_23_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_let_n_27_,x10
# 	mv	_arg_29_,_let_n_27_
# 	mv	x10,_arg_29_
	jal	f.read_string
# was:	jal	f.read_string, x10
# 	mv	_let_s1_28_,x10
# 	mv	_arr_40_,_let_s1_28_
	lw	x21, 0(x10)
# was:	lw	_size_39_, 0(_arr_40_)
	mv	x18, x3
# was:	mv	_arr_36_, x3
	slli	x11, x21, 2
# was:	slli	_tmp_48_, _size_39_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_48_, _tmp_48_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_48_
	sw	x21, 0(x18)
# was:	sw	_size_39_, 0(_arr_36_)
	addi	x20, x18, 4
# was:	addi	_addrg_43_, _arr_36_, 4
	mv	x19, x0
# was:	mv	_i_44_, x0
	addi	x22, x10, 4
# was:	addi	_elem_41_, _arr_40_, 4
l.loop_beg_45_:
	bge	x19, x21, l.loop_end_46_
# was:	bge	_i_44_, _size_39_, l.loop_end_46_
	lbu	x10, 0(x22)
# was:	lbu	_res_42_, 0(_elem_41_)
	addi	x22, x22, 1
# was:	addi	_elem_41_, _elem_41_, 1
# 	mv	x10,_res_42_
	jal	f.ord
# was:	jal	f.ord, x10
# 	mv	_tmp_47_,x10
# 	mv	_res_42_,_tmp_47_
	sw	x10, 0(x20)
# was:	sw	_res_42_, 0(_addrg_43_)
	addi	x20, x20, 4
# was:	addi	_addrg_43_, _addrg_43_, 4
	addi	x19, x19, 1
# was:	addi	_i_44_, _i_44_, 1
	j	l.loop_beg_45_
l.loop_end_46_:
	lw	x22, 0(x18)
# was:	lw	_size_35_, 0(_arr_36_)
	mv	x19, x3
# was:	mv	_arr_32_, x3
	slli	x10, x22, 2
# was:	slli	_tmp_54_, _size_35_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_54_, _tmp_54_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_54_
	sw	x22, 0(x19)
# was:	sw	_size_35_, 0(_arr_32_)
	addi	x21, x19, 4
# was:	addi	_addrg_49_, _arr_32_, 4
	mv	x20, x0
# was:	mv	_i_50_, x0
	addi	x18, x18, 4
# was:	addi	_elem_37_, _arr_36_, 4
l.loop_beg_51_:
	bge	x20, x22, l.loop_end_52_
# was:	bge	_i_50_, _size_35_, l.loop_end_52_
	lw	x10, 0(x18)
# was:	lw	_res_38_, 0(_elem_37_)
	addi	x18, x18, 4
# was:	addi	_elem_37_, _elem_37_, 4
# 	mv	x10,_res_38_
	jal	f.add_one
# was:	jal	f.add_one, x10
# 	mv	_tmp_53_,x10
# 	mv	_res_38_,_tmp_53_
	sw	x10, 0(x21)
# was:	sw	_res_38_, 0(_addrg_49_)
	addi	x21, x21, 4
# was:	addi	_addrg_49_, _addrg_49_, 4
	addi	x20, x20, 1
# was:	addi	_i_50_, _i_50_, 1
	j	l.loop_beg_51_
l.loop_end_52_:
	lw	x20, 0(x19)
# was:	lw	_size_31_, 0(_arr_32_)
	mv	x18, x3
# was:	mv	_let_s2_30_, x3
	addi	x10, x20, 3
# was:	addi	_tmp_60_, _size_31_, 3
	andi	x10, x10, -4
# was:	andi	_tmp_60_, _tmp_60_, -4
	addi	x10, x10, 4
# was:	addi	_tmp_60_, _tmp_60_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_60_
	sw	x20, 0(x18)
# was:	sw	_size_31_, 0(_let_s2_30_)
	addi	x21, x18, 4
# was:	addi	_addrg_55_, _let_s2_30_, 4
	mv	x22, x0
# was:	mv	_i_56_, x0
	addi	x19, x19, 4
# was:	addi	_elem_33_, _arr_32_, 4
l.loop_beg_57_:
	bge	x22, x20, l.loop_end_58_
# was:	bge	_i_56_, _size_31_, l.loop_end_58_
	lw	x10, 0(x19)
# was:	lw	_res_34_, 0(_elem_33_)
	addi	x19, x19, 4
# was:	addi	_elem_33_, _elem_33_, 4
# 	mv	x10,_res_34_
	jal	f.chr
# was:	jal	f.chr, x10
# 	mv	_tmp_59_,x10
# 	mv	_res_34_,_tmp_59_
	sb	x10, 0(x21)
# was:	sb	_res_34_, 0(_addrg_55_)
	addi	x21, x21, 1
# was:	addi	_addrg_55_, _addrg_55_, 1
	addi	x22, x22, 1
# was:	addi	_i_56_, _i_56_, 1
	j	l.loop_beg_57_
l.loop_end_58_:
	mv	x10, x18
# was:	mv	_tmp_61_, _let_s2_30_
	mv	x18, x10
# was:	mv	_mainres_26_, _tmp_61_
# 	mv	x10,_tmp_61_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	x10, _mainres_26_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
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