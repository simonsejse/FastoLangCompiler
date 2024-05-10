	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function mul
f.mul:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_x_1_,x10
# 	mv	_param_y_2_,x11
# 	mv	_eq_L_8_,_param_y_2_
	li	x12, 0
# was:	li	_eq_R_9_, 0
	li	x13, 0
# was:	li	_cond_7_, 0
	bne	x11, x12, l.false_10_
# was:	bne	_eq_L_8_, _eq_R_9_, l.false_10_
	li	x13, 1
# was:	li	_cond_7_, 1
l.false_10_:
	bne	x13, x0, l.then_4_
# was:	bne	_cond_7_, x0, l.then_4_
	j	l.else_5_
l.then_4_:
	li	x10, 0
# was:	li	_mulres_3_, 0
	j	l.endif_6_
l.else_5_:
# 	mv	_lt_L_15_,_param_y_2_
	li	x12, 0
# was:	li	_lt_R_16_, 0
	slt	x12, x11, x12
# was:	slt	_cond_14_, _lt_L_15_, _lt_R_16_
	bne	x12, x0, l.then_11_
# was:	bne	_cond_14_, x0, l.then_11_
	j	l.else_12_
l.then_11_:
	li	x12, 0
# was:	li	_minus_L_19_, 0
# 	mv	_minus_R_20_,_param_x_1_
	sub	x18, x12, x10
# was:	sub	_plus_L_17_, _minus_L_19_, _minus_R_20_
# 	mv	_arg_21_,_param_x_1_
# 	mv	_plus_L_23_,_param_y_2_
	li	x12, 1
# was:	li	_plus_R_24_, 1
	add	x11, x11, x12
# was:	add	_arg_22_, _plus_L_23_, _plus_R_24_
# 	mv	x10,_arg_21_
# 	mv	x11,_arg_22_
	jal	f.mul
# was:	jal	f.mul, x10 x11
# 	mv	_plus_R_18_,x10
	add	x10, x18, x10
# was:	add	_mulres_3_, _plus_L_17_, _plus_R_18_
	j	l.endif_13_
l.else_12_:
	mv	x18, x10
# was:	mv	_plus_L_25_, _param_x_1_
# 	mv	_arg_27_,_param_x_1_
	mv	x12, x11
# was:	mv	_minus_L_29_, _param_y_2_
	li	x11, 1
# was:	li	_minus_R_30_, 1
	sub	x11, x12, x11
# was:	sub	_arg_28_, _minus_L_29_, _minus_R_30_
# 	mv	x10,_arg_27_
# 	mv	x11,_arg_28_
	jal	f.mul
# was:	jal	f.mul, x10 x11
# 	mv	_plus_R_26_,x10
	add	x10, x18, x10
# was:	add	_mulres_3_, _plus_L_25_, _plus_R_26_
l.endif_13_:
l.endif_6_:
# 	mv	x10,_mulres_3_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x23, -28(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -28
	jal	p.getint
# was:	jal	p.getint, 
	mv	x19, x10
# was:	mv	_let_n_32_, x10
# 	mv	_lt_L_37_,_let_n_32_
	li	x10, 1
# was:	li	_lt_R_38_, 1
	slt	x10, x19, x10
# was:	slt	_cond_36_, _lt_L_37_, _lt_R_38_
	bne	x10, x0, l.then_33_
# was:	bne	_cond_36_, x0, l.then_33_
	j	l.else_34_
l.then_33_:
	la	x10, s.Incorre_41_
# was:	la	_tmp_40_, s.Incorre_41_
# s.Incorre_41_: string "Incorrect Input!"
# 	mv	_let_a_39_,_tmp_40_
# 	mv	x10,_tmp_40_
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x11, 0
# was:	li	_mainres_31_, 0
	j	l.endif_35_
l.else_34_:
# 	mv	_size_47_,_let_n_32_
	bge	x19, x0, l.safe_48_
# was:	bge	_size_47_, x0, l.safe_48_
	li	x10, 12
# was:	li	x10, 12
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_48_:
	mv	x10, x3
# was:	mv	_arr_44_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_53_, _size_47_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_53_, _tmp_53_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_53_
	sw	x19, 0(x10)
# was:	sw	_size_47_, 0(_arr_44_)
	addi	x12, x10, 4
# was:	addi	_addr_49_, _arr_44_, 4
	mv	x11, x0
# was:	mv	_i_50_, x0
l.loop_beg_51_:
	bge	x11, x19, l.loop_end_52_
# was:	bge	_i_50_, _size_47_, l.loop_end_52_
	sw	x11, 0(x12)
# was:	sw	_i_50_, 0(_addr_49_)
	addi	x12, x12, 4
# was:	addi	_addr_49_, _addr_49_, 4
	addi	x11, x11, 1
# was:	addi	_i_50_, _i_50_, 1
	j	l.loop_beg_51_
l.loop_end_52_:
	lw	x20, 0(x10)
# was:	lw	_size_43_, 0(_arr_44_)
	mv	x18, x3
# was:	mv	_let_arr_42_, x3
	slli	x11, x20, 2
# was:	slli	_tmp_59_, _size_43_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_59_, _tmp_59_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_59_
	sw	x20, 0(x18)
# was:	sw	_size_43_, 0(_let_arr_42_)
	addi	x22, x18, 4
# was:	addi	_addrg_54_, _let_arr_42_, 4
	mv	x21, x0
# was:	mv	_i_55_, x0
	addi	x23, x10, 4
# was:	addi	_elem_45_, _arr_44_, 4
l.loop_beg_56_:
	bge	x21, x20, l.loop_end_57_
# was:	bge	_i_55_, _size_43_, l.loop_end_57_
	lw	x10, 0(x23)
# was:	lw	_res_46_, 0(_elem_45_)
	addi	x23, x23, 4
# was:	addi	_elem_45_, _elem_45_, 4
	jal	p.getint
# was:	jal	p.getint, 
# 	mv	_fun_arg_res_58_,x10
# 	mv	_res_46_,_fun_arg_res_58_
	sw	x10, 0(x22)
# was:	sw	_res_46_, 0(_addrg_54_)
	addi	x22, x22, 4
# was:	addi	_addrg_54_, _addrg_54_, 4
	addi	x21, x21, 1
# was:	addi	_i_55_, _i_55_, 1
	j	l.loop_beg_56_
l.loop_end_57_:
# 	mv	_size_65_,_let_n_32_
	bge	x19, x0, l.safe_66_
# was:	bge	_size_65_, x0, l.safe_66_
	li	x10, 13
# was:	li	x10, 13
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_66_:
	mv	x13, x3
# was:	mv	_arr_62_, x3
	slli	x10, x19, 2
# was:	slli	_tmp_71_, _size_65_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_71_, _tmp_71_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_71_
	sw	x19, 0(x13)
# was:	sw	_size_65_, 0(_arr_62_)
	addi	x10, x13, 4
# was:	addi	_addr_67_, _arr_62_, 4
	mv	x11, x0
# was:	mv	_i_68_, x0
l.loop_beg_69_:
	bge	x11, x19, l.loop_end_70_
# was:	bge	_i_68_, _size_65_, l.loop_end_70_
	sw	x11, 0(x10)
# was:	sw	_i_68_, 0(_addr_67_)
	addi	x10, x10, 4
# was:	addi	_addr_67_, _addr_67_, 4
	addi	x11, x11, 1
# was:	addi	_i_68_, _i_68_, 1
	j	l.loop_beg_69_
l.loop_end_70_:
	lw	x10, 0(x13)
# was:	lw	_size_61_, 0(_arr_62_)
	mv	x20, x3
# was:	mv	_let_difs_60_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_112_, _size_61_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_112_, _tmp_112_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_112_
	sw	x10, 0(x20)
# was:	sw	_size_61_, 0(_let_difs_60_)
	addi	x11, x20, 4
# was:	addi	_addrg_72_, _let_difs_60_, 4
	mv	x12, x0
# was:	mv	_i_73_, x0
	addi	x13, x13, 4
# was:	addi	_elem_63_, _arr_62_, 4
l.loop_beg_74_:
	bge	x12, x10, l.loop_end_75_
# was:	bge	_i_73_, _size_61_, l.loop_end_75_
	lw	x14, 0(x13)
# was:	lw	_res_64_, 0(_elem_63_)
	addi	x13, x13, 4
# was:	addi	_elem_63_, _elem_63_, 4
# 	mv	_eq_L_81_,_res_64_
	li	x15, 0
# was:	li	_eq_R_82_, 0
	li	x16, 0
# was:	li	_cond_80_, 0
	bne	x14, x15, l.false_83_
# was:	bne	_eq_L_81_, _eq_R_82_, l.false_83_
	li	x16, 1
# was:	li	_cond_80_, 1
l.false_83_:
	bne	x16, x0, l.then_77_
# was:	bne	_cond_80_, x0, l.then_77_
	j	l.else_78_
l.then_77_:
	li	x14, 0
# was:	li	_arr_ind_86_, 0
	addi	x15, x18, 4
# was:	addi	_arr_data_87_, _let_arr_42_, 4
	bge	x14, x0, l.nonneg_90_
# was:	bge	_arr_ind_86_, x0, l.nonneg_90_
l.error_89_:
	li	x10, 13
# was:	li	x10, 13
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_90_:
	lw	x16, 0(x18)
# was:	lw	_size_88_, 0(_let_arr_42_)
	bge	x14, x16, l.error_89_
# was:	bge	_arr_ind_86_, _size_88_, l.error_89_
	slli	x14, x14, 2
# was:	slli	_arr_ind_86_, _arr_ind_86_, 2
	add	x15, x15, x14
# was:	add	_arr_data_87_, _arr_data_87_, _arr_ind_86_
	lw	x14, 0(x15)
# was:	lw	_minus_L_84_, 0(_arr_data_87_)
# 	mv	_minus_L_92_,_let_n_32_
	li	x15, 1
# was:	li	_minus_R_93_, 1
	sub	x16, x19, x15
# was:	sub	_arr_ind_91_, _minus_L_92_, _minus_R_93_
	addi	x15, x18, 4
# was:	addi	_arr_data_94_, _let_arr_42_, 4
	bge	x16, x0, l.nonneg_97_
# was:	bge	_arr_ind_91_, x0, l.nonneg_97_
l.error_96_:
	li	x10, 13
# was:	li	x10, 13
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_97_:
	lw	x17, 0(x18)
# was:	lw	_size_95_, 0(_let_arr_42_)
	bge	x16, x17, l.error_96_
# was:	bge	_arr_ind_91_, _size_95_, l.error_96_
	slli	x16, x16, 2
# was:	slli	_arr_ind_91_, _arr_ind_91_, 2
	add	x15, x15, x16
# was:	add	_arr_data_94_, _arr_data_94_, _arr_ind_91_
	lw	x15, 0(x15)
# was:	lw	_minus_R_85_, 0(_arr_data_94_)
	sub	x14, x14, x15
# was:	sub	_fun_arg_res_76_, _minus_L_84_, _minus_R_85_
	j	l.endif_79_
l.else_78_:
	mv	x15, x14
# was:	mv	_arr_ind_100_, _res_64_
	addi	x17, x18, 4
# was:	addi	_arr_data_101_, _let_arr_42_, 4
	bge	x15, x0, l.nonneg_104_
# was:	bge	_arr_ind_100_, x0, l.nonneg_104_
l.error_103_:
	li	x10, 13
# was:	li	x10, 13
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_104_:
	lw	x16, 0(x18)
# was:	lw	_size_102_, 0(_let_arr_42_)
	bge	x15, x16, l.error_103_
# was:	bge	_arr_ind_100_, _size_102_, l.error_103_
	slli	x15, x15, 2
# was:	slli	_arr_ind_100_, _arr_ind_100_, 2
	add	x17, x17, x15
# was:	add	_arr_data_101_, _arr_data_101_, _arr_ind_100_
	lw	x15, 0(x17)
# was:	lw	_minus_L_98_, 0(_arr_data_101_)
# 	mv	_minus_L_106_,_res_64_
	li	x16, 1
# was:	li	_minus_R_107_, 1
	sub	x16, x14, x16
# was:	sub	_arr_ind_105_, _minus_L_106_, _minus_R_107_
	addi	x17, x18, 4
# was:	addi	_arr_data_108_, _let_arr_42_, 4
	bge	x16, x0, l.nonneg_111_
# was:	bge	_arr_ind_105_, x0, l.nonneg_111_
l.error_110_:
	li	x10, 13
# was:	li	x10, 13
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_111_:
	lw	x14, 0(x18)
# was:	lw	_size_109_, 0(_let_arr_42_)
	bge	x16, x14, l.error_110_
# was:	bge	_arr_ind_105_, _size_109_, l.error_110_
	slli	x16, x16, 2
# was:	slli	_arr_ind_105_, _arr_ind_105_, 2
	add	x17, x17, x16
# was:	add	_arr_data_108_, _arr_data_108_, _arr_ind_105_
	lw	x14, 0(x17)
# was:	lw	_minus_R_99_, 0(_arr_data_108_)
	sub	x14, x15, x14
# was:	sub	_fun_arg_res_76_, _minus_L_98_, _minus_R_99_
l.endif_79_:
# 	mv	_res_64_,_fun_arg_res_76_
	sw	x14, 0(x11)
# was:	sw	_res_64_, 0(_addrg_72_)
	addi	x11, x11, 4
# was:	addi	_addrg_72_, _addrg_72_, 4
	addi	x12, x12, 1
# was:	addi	_i_73_, _i_73_, 1
	j	l.loop_beg_74_
l.loop_end_75_:
# 	mv	_size_118_,_let_n_32_
	bge	x19, x0, l.safe_119_
# was:	bge	_size_118_, x0, l.safe_119_
	li	x10, 14
# was:	li	x10, 14
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_119_:
	mv	x10, x3
# was:	mv	_arr_115_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_124_, _size_118_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_124_, _tmp_124_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_124_
	sw	x19, 0(x10)
# was:	sw	_size_118_, 0(_arr_115_)
	addi	x11, x10, 4
# was:	addi	_addr_120_, _arr_115_, 4
	mv	x12, x0
# was:	mv	_i_121_, x0
l.loop_beg_122_:
	bge	x12, x19, l.loop_end_123_
# was:	bge	_i_121_, _size_118_, l.loop_end_123_
	sw	x12, 0(x11)
# was:	sw	_i_121_, 0(_addr_120_)
	addi	x11, x11, 4
# was:	addi	_addr_120_, _addr_120_, 4
	addi	x12, x12, 1
# was:	addi	_i_121_, _i_121_, 1
	j	l.loop_beg_122_
l.loop_end_123_:
	lw	x19, 0(x10)
# was:	lw	_size_114_, 0(_arr_115_)
	mv	x18, x3
# was:	mv	_let_squares_113_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_142_, _size_114_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_142_, _tmp_142_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_142_
	sw	x19, 0(x18)
# was:	sw	_size_114_, 0(_let_squares_113_)
	addi	x21, x18, 4
# was:	addi	_addrg_125_, _let_squares_113_, 4
	mv	x22, x0
# was:	mv	_i_126_, x0
	addi	x23, x10, 4
# was:	addi	_elem_116_, _arr_115_, 4
l.loop_beg_127_:
	bge	x22, x19, l.loop_end_128_
# was:	bge	_i_126_, _size_114_, l.loop_end_128_
	lw	x13, 0(x23)
# was:	lw	_res_117_, 0(_elem_116_)
	addi	x23, x23, 4
# was:	addi	_elem_116_, _elem_116_, 4
	mv	x12, x13
# was:	mv	_arr_ind_131_, _res_117_
	addi	x10, x20, 4
# was:	addi	_arr_data_132_, _let_difs_60_, 4
	bge	x12, x0, l.nonneg_135_
# was:	bge	_arr_ind_131_, x0, l.nonneg_135_
l.error_134_:
	li	x10, 14
# was:	li	x10, 14
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_135_:
	lw	x11, 0(x20)
# was:	lw	_size_133_, 0(_let_difs_60_)
	bge	x12, x11, l.error_134_
# was:	bge	_arr_ind_131_, _size_133_, l.error_134_
	slli	x12, x12, 2
# was:	slli	_arr_ind_131_, _arr_ind_131_, 2
	add	x10, x10, x12
# was:	add	_arr_data_132_, _arr_data_132_, _arr_ind_131_
	lw	x10, 0(x10)
# was:	lw	_arg_130_, 0(_arr_data_132_)
# 	mv	_arr_ind_137_,_res_117_
	addi	x11, x20, 4
# was:	addi	_arr_data_138_, _let_difs_60_, 4
	bge	x13, x0, l.nonneg_141_
# was:	bge	_arr_ind_137_, x0, l.nonneg_141_
l.error_140_:
	li	x10, 14
# was:	li	x10, 14
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_141_:
	lw	x12, 0(x20)
# was:	lw	_size_139_, 0(_let_difs_60_)
	bge	x13, x12, l.error_140_
# was:	bge	_arr_ind_137_, _size_139_, l.error_140_
	slli	x13, x13, 2
# was:	slli	_arr_ind_137_, _arr_ind_137_, 2
	add	x11, x11, x13
# was:	add	_arr_data_138_, _arr_data_138_, _arr_ind_137_
	lw	x11, 0(x11)
# was:	lw	_arg_136_, 0(_arr_data_138_)
# 	mv	x10,_arg_130_
# 	mv	x11,_arg_136_
	jal	f.mul
# was:	jal	f.mul, x10 x11
# 	mv	_fun_arg_res_129_,x10
	mv	x13, x10
# was:	mv	_res_117_, _fun_arg_res_129_
	sw	x13, 0(x21)
# was:	sw	_res_117_, 0(_addrg_125_)
	addi	x21, x21, 4
# was:	addi	_addrg_125_, _addrg_125_, 4
	addi	x22, x22, 1
# was:	addi	_i_126_, _i_126_, 1
	j	l.loop_beg_127_
l.loop_end_128_:
# 	mv	_arr_143_,_let_squares_113_
	lw	x10, 0(x18)
# was:	lw	_size_144_, 0(_arr_143_)
	li	x11, 0
# was:	li	_mainres_31_, 0
	addi	x18, x18, 4
# was:	addi	_arr_143_, _arr_143_, 4
	mv	x12, x0
# was:	mv	_ind_var_145_, x0
l.loop_beg_147_:
	bge	x12, x10, l.loop_end_148_
# was:	bge	_ind_var_145_, _size_144_, l.loop_end_148_
	lw	x13, 0(x18)
# was:	lw	_tmp_146_, 0(_arr_143_)
	addi	x18, x18, 4
# was:	addi	_arr_143_, _arr_143_, 4
# 	mv	_plus_L_150_,_mainres_31_
# 	mv	_plus_R_151_,_tmp_146_
	add	x11, x11, x13
# was:	add	_fun_arg_res_149_, _plus_L_150_, _plus_R_151_
# 	mv	_mainres_31_,_fun_arg_res_149_
	addi	x12, x12, 1
# was:	addi	_ind_var_145_, _ind_var_145_, 1
	j	l.loop_beg_147_
l.loop_end_148_:
l.endif_35_:
	mv	x10, x11
# was:	mv	x10, _mainres_31_
	addi	x2, x2, 28
	lw	x23, -28(x2)
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
s.Incorre_41_:
	.word	16
	.ascii	"Incorrect Input!"
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