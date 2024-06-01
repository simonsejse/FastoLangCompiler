	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
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
	li	x10, 8
# was:	li	_size_3_, 8
	bge	x10, x0, l.safe_4_
# was:	bge	_size_3_, x0, l.safe_4_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_4_:
	mv	x11, x3
# was:	mv	_let_itsp_2_, x3
	slli	x12, x10, 2
# was:	slli	_tmp_9_, _size_3_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_9_, _tmp_9_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_9_
	sw	x10, 0(x11)
# was:	sw	_size_3_, 0(_let_itsp_2_)
	addi	x12, x11, 4
# was:	addi	_addr_5_, _let_itsp_2_, 4
	mv	x13, x0
# was:	mv	_i_6_, x0
l.loop_beg_7_:
	bge	x13, x10, l.loop_end_8_
# was:	bge	_i_6_, _size_3_, l.loop_end_8_
	sw	x13, 0(x12)
# was:	sw	_i_6_, 0(_addr_5_)
	addi	x12, x12, 4
# was:	addi	_addr_5_, _addr_5_, 4
	addi	x13, x13, 1
# was:	addi	_i_6_, _i_6_, 1
	j	l.loop_beg_7_
l.loop_end_8_:
	mv	x10, x11
# was:	mv	_arr_12_, _let_itsp_2_
	lw	x18, 0(x10)
# was:	lw	_size_11_, 0(_arr_12_)
	mv	x19, x3
# was:	mv	_let_in_arr_10_, x3
	slli	x11, x18, 2
# was:	slli	_tmp_32_, _size_11_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_32_, _tmp_32_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_32_
	sw	x18, 0(x19)
# was:	sw	_size_11_, 0(_let_in_arr_10_)
	addi	x21, x19, 4
# was:	addi	_addrg_15_, _let_in_arr_10_, 4
	mv	x20, x0
# was:	mv	_i_16_, x0
	addi	x22, x10, 4
# was:	addi	_elem_13_, _arr_12_, 4
l.loop_beg_17_:
	bge	x20, x18, l.loop_end_18_
# was:	bge	_i_16_, _size_11_, l.loop_end_18_
	lw	x23, 0(x22)
# was:	lw	_res_14_, 0(_elem_13_)
	addi	x22, x22, 4
# was:	addi	_elem_13_, _elem_13_, 4
	la	x10, s.Introdu_22_
# was:	la	_tmp_21_, s.Introdu_22_
# s.Introdu_22_: string "Introduce number "
# 	mv	_let_t_20_,_tmp_21_
# 	mv	x10,_tmp_21_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x23
# was:	mv	_tmp_24_, _res_14_
# 	mv	_let_t_23_,_tmp_24_
# 	mv	x10,_let_t_23_
	jal	p.putint
# was:	jal	p.putint, x10
	la	x10, s.XX_27_
# was:	la	_tmp_26_, s.XX_27_
# s.XX_27_: string ": "
# 	mv	_let_t_25_,_tmp_26_
# 	mv	x10,_tmp_26_
	jal	p.putstring
# was:	jal	p.putstring, x10
	jal	p.getint
# was:	jal	p.getint, 
	mv	x23, x10
# was:	mv	_let_m_28_, x10
	la	x10, s.X_31_
# was:	la	_tmp_30_, s.X_31_
# s.X_31_: string "\n"
# 	mv	_let_t_29_,_tmp_30_
# 	mv	x10,_tmp_30_
	jal	p.putstring
# was:	jal	p.putstring, x10
# 	mv	_fun_arg_res_19_,_let_m_28_
# 	mv	_res_14_,_fun_arg_res_19_
	sw	x23, 0(x21)
# was:	sw	_res_14_, 0(_addrg_15_)
	addi	x21, x21, 4
# was:	addi	_addrg_15_, _addrg_15_, 4
	addi	x20, x20, 1
# was:	addi	_i_16_, _i_16_, 1
	j	l.loop_beg_17_
l.loop_end_18_:
# 	mv	_arr_35_,_let_in_arr_10_
	lw	x17, 0(x19)
# was:	lw	_size_34_, 0(_arr_35_)
	mv	x14, x3
# was:	mv	_let_map_arr_33_, x3
	slli	x10, x17, 2
# was:	slli	_tmp_55_, _size_34_, 2
	addi	x10, x10, 4
# was:	addi	_tmp_55_, _tmp_55_, 4
	add	x3, x3, x10
# was:	add	x3, x3, _tmp_55_
	sw	x17, 0(x14)
# was:	sw	_size_34_, 0(_let_map_arr_33_)
	addi	x16, x14, 4
# was:	addi	_addrg_38_, _let_map_arr_33_, 4
	mv	x15, x0
# was:	mv	_i_39_, x0
	addi	x18, x19, 4
# was:	addi	_elem_36_, _arr_35_, 4
l.loop_beg_40_:
	bge	x15, x17, l.loop_end_41_
# was:	bge	_i_39_, _size_34_, l.loop_end_41_
	lw	x13, 0(x18)
# was:	lw	_res_37_, 0(_elem_36_)
	addi	x18, x18, 4
# was:	addi	_elem_36_, _elem_36_, 4
# 	mv	_let_x_43_,_res_37_
# 	mv	_lt_L_49_,_let_x_43_
	li	x10, 0
# was:	li	_lt_R_50_, 0
	slt	x10, x13, x10
# was:	slt	_cond_48_, _lt_L_49_, _lt_R_50_
	bne	x10, x0, l.then_45_
# was:	bne	_cond_48_, x0, l.then_45_
	j	l.else_46_
l.then_45_:
	li	x12, 0
# was:	li	_let_xm_44_, 0
	j	l.endif_47_
l.else_46_:
	mv	x12, x13
# was:	mv	_let_xm_44_, _let_x_43_
l.endif_47_:
	li	x10, 4
# was:	li	_size_51_, 4
	mv	x19, x3
# was:	mv	_fun_arg_res_42_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_54_, _size_51_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_54_, _tmp_54_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_54_
	sw	x10, 0(x19)
# was:	sw	_size_51_, 0(_fun_arg_res_42_)
	addi	x10, x19, 4
# was:	addi	_addr_52_, _fun_arg_res_42_, 4
# 	mv	_tmp_53_,_let_xm_44_
	sw	x12, 0(x10)
# was:	sw	_tmp_53_, 0(_addr_52_)
	addi	x10, x10, 4
# was:	addi	_addr_52_, _addr_52_, 4
# 	mv	_tmp_53_,_let_xm_44_
	sw	x12, 0(x10)
# was:	sw	_tmp_53_, 0(_addr_52_)
	addi	x10, x10, 4
# was:	addi	_addr_52_, _addr_52_, 4
# 	mv	_tmp_53_,_let_xm_44_
	sw	x12, 0(x10)
# was:	sw	_tmp_53_, 0(_addr_52_)
	addi	x10, x10, 4
# was:	addi	_addr_52_, _addr_52_, 4
	mv	x12, x13
# was:	mv	_tmp_53_, _let_x_43_
	sw	x12, 0(x10)
# was:	sw	_tmp_53_, 0(_addr_52_)
	addi	x10, x10, 4
# was:	addi	_addr_52_, _addr_52_, 4
	mv	x13, x19
# was:	mv	_res_37_, _fun_arg_res_42_
	sw	x13, 0(x16)
# was:	sw	_res_37_, 0(_addrg_38_)
	addi	x16, x16, 4
# was:	addi	_addrg_38_, _addrg_38_, 4
	addi	x15, x15, 1
# was:	addi	_i_39_, _i_39_, 1
	j	l.loop_beg_40_
l.loop_end_41_:
	li	x10, 4
# was:	li	_size_57_, 4
	mv	x18, x3
# was:	mv	_let_ne_56_, x3
	slli	x11, x10, 2
# was:	slli	_tmp_60_, _size_57_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_60_, _tmp_60_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_60_
	sw	x10, 0(x18)
# was:	sw	_size_57_, 0(_let_ne_56_)
	addi	x10, x18, 4
# was:	addi	_addr_58_, _let_ne_56_, 4
	li	x11, 0
# was:	li	_tmp_59_, 0
	sw	x11, 0(x10)
# was:	sw	_tmp_59_, 0(_addr_58_)
	addi	x10, x10, 4
# was:	addi	_addr_58_, _addr_58_, 4
	li	x11, 0
# was:	li	_tmp_59_, 0
	sw	x11, 0(x10)
# was:	sw	_tmp_59_, 0(_addr_58_)
	addi	x10, x10, 4
# was:	addi	_addr_58_, _addr_58_, 4
	li	x11, 0
# was:	li	_tmp_59_, 0
	sw	x11, 0(x10)
# was:	sw	_tmp_59_, 0(_addr_58_)
	addi	x10, x10, 4
# was:	addi	_addr_58_, _addr_58_, 4
	li	x11, 0
# was:	li	_tmp_59_, 0
	sw	x11, 0(x10)
# was:	sw	_tmp_59_, 0(_addr_58_)
	addi	x10, x10, 4
# was:	addi	_addr_58_, _addr_58_, 4
	mv	x11, x14
# was:	mv	_arr_62_, _let_map_arr_33_
	lw	x10, 0(x11)
# was:	lw	_size_63_, 0(_arr_62_)
# 	mv	_let_arr_61_,_let_ne_56_
	addi	x11, x11, 4
# was:	addi	_arr_62_, _arr_62_, 4
	mv	x12, x0
# was:	mv	_ind_var_64_, x0
l.loop_beg_66_:
	bge	x12, x10, l.loop_end_67_
# was:	bge	_ind_var_64_, _size_63_, l.loop_end_67_
	lw	x14, 0(x11)
# was:	lw	_tmp_65_, 0(_arr_62_)
	addi	x11, x11, 4
# was:	addi	_arr_62_, _arr_62_, 4
	li	x16, 0
# was:	li	_arr_ind_70_, 0
	addi	x13, x18, 4
# was:	addi	_arr_data_71_, _let_arr_61_, 4
	bge	x16, x0, l.nonneg_74_
# was:	bge	_arr_ind_70_, x0, l.nonneg_74_
l.error_73_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_74_:
	lw	x15, 0(x18)
# was:	lw	_size_72_, 0(_let_arr_61_)
	bge	x16, x15, l.error_73_
# was:	bge	_arr_ind_70_, _size_72_, l.error_73_
	slli	x16, x16, 2
# was:	slli	_arr_ind_70_, _arr_ind_70_, 2
	add	x13, x13, x16
# was:	add	_arr_data_71_, _arr_data_71_, _arr_ind_70_
	lw	x13, 0(x13)
# was:	lw	_let_x_I16_69_, 0(_arr_data_71_)
	li	x15, 0
# was:	li	_arr_ind_76_, 0
	addi	x16, x14, 4
# was:	addi	_arr_data_77_, _tmp_65_, 4
	bge	x15, x0, l.nonneg_80_
# was:	bge	_arr_ind_76_, x0, l.nonneg_80_
l.error_79_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_80_:
	lw	x17, 0(x14)
# was:	lw	_size_78_, 0(_tmp_65_)
	bge	x15, x17, l.error_79_
# was:	bge	_arr_ind_76_, _size_78_, l.error_79_
	slli	x15, x15, 2
# was:	slli	_arr_ind_76_, _arr_ind_76_, 2
	add	x16, x16, x15
# was:	add	_arr_data_77_, _arr_data_77_, _arr_ind_76_
	lw	x15, 0(x16)
# was:	lw	_let_y_I16_75_, 0(_arr_data_77_)
# 	mv	_lt_L_86_,_let_x_I16_69_
# 	mv	_lt_R_87_,_let_y_I16_75_
	slt	x16, x13, x15
# was:	slt	_cond_85_, _lt_L_86_, _lt_R_87_
	bne	x16, x0, l.then_82_
# was:	bne	_cond_85_, x0, l.then_82_
	j	l.else_83_
l.then_82_:
	mv	x13, x15
# was:	mv	_let_x_I15_81_, _let_y_I16_75_
	j	l.endif_84_
l.else_83_:
# 	mv	_let_x_I15_81_,_let_x_I16_69_
l.endif_84_:
	li	x15, 2
# was:	li	_arr_ind_91_, 2
	addi	x16, x18, 4
# was:	addi	_arr_data_92_, _let_arr_61_, 4
	bge	x15, x0, l.nonneg_95_
# was:	bge	_arr_ind_91_, x0, l.nonneg_95_
l.error_94_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_95_:
	lw	x17, 0(x18)
# was:	lw	_size_93_, 0(_let_arr_61_)
	bge	x15, x17, l.error_94_
# was:	bge	_arr_ind_91_, _size_93_, l.error_94_
	slli	x15, x15, 2
# was:	slli	_arr_ind_91_, _arr_ind_91_, 2
	add	x16, x16, x15
# was:	add	_arr_data_92_, _arr_data_92_, _arr_ind_91_
	lw	x19, 0(x16)
# was:	lw	_plus_L_89_, 0(_arr_data_92_)
	li	x15, 1
# was:	li	_arr_ind_96_, 1
	addi	x17, x14, 4
# was:	addi	_arr_data_97_, _tmp_65_, 4
	bge	x15, x0, l.nonneg_100_
# was:	bge	_arr_ind_96_, x0, l.nonneg_100_
l.error_99_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_100_:
	lw	x16, 0(x14)
# was:	lw	_size_98_, 0(_tmp_65_)
	bge	x15, x16, l.error_99_
# was:	bge	_arr_ind_96_, _size_98_, l.error_99_
	slli	x15, x15, 2
# was:	slli	_arr_ind_96_, _arr_ind_96_, 2
	add	x17, x17, x15
# was:	add	_arr_data_97_, _arr_data_97_, _arr_ind_96_
	lw	x15, 0(x17)
# was:	lw	_plus_R_90_, 0(_arr_data_97_)
	add	x15, x19, x15
# was:	add	_let_y_I15_88_, _plus_L_89_, _plus_R_90_
# 	mv	_lt_L_106_,_let_x_I15_81_
# 	mv	_lt_R_107_,_let_y_I15_88_
	slt	x16, x13, x15
# was:	slt	_cond_105_, _lt_L_106_, _lt_R_107_
	bne	x16, x0, l.then_102_
# was:	bne	_cond_105_, x0, l.then_102_
	j	l.else_103_
l.then_102_:
	mv	x13, x15
# was:	mv	_let_mss_101_, _let_y_I15_88_
	j	l.endif_104_
l.else_103_:
# 	mv	_let_mss_101_,_let_x_I15_81_
l.endif_104_:
	li	x17, 1
# was:	li	_arr_ind_109_, 1
	addi	x15, x18, 4
# was:	addi	_arr_data_110_, _let_arr_61_, 4
	bge	x17, x0, l.nonneg_113_
# was:	bge	_arr_ind_109_, x0, l.nonneg_113_
l.error_112_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_113_:
	lw	x16, 0(x18)
# was:	lw	_size_111_, 0(_let_arr_61_)
	bge	x17, x16, l.error_112_
# was:	bge	_arr_ind_109_, _size_111_, l.error_112_
	slli	x17, x17, 2
# was:	slli	_arr_ind_109_, _arr_ind_109_, 2
	add	x15, x15, x17
# was:	add	_arr_data_110_, _arr_data_110_, _arr_ind_109_
	lw	x19, 0(x15)
# was:	lw	_let_x_I17_108_, 0(_arr_data_110_)
	li	x17, 3
# was:	li	_arr_ind_117_, 3
	addi	x15, x18, 4
# was:	addi	_arr_data_118_, _let_arr_61_, 4
	bge	x17, x0, l.nonneg_121_
# was:	bge	_arr_ind_117_, x0, l.nonneg_121_
l.error_120_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_121_:
	lw	x16, 0(x18)
# was:	lw	_size_119_, 0(_let_arr_61_)
	bge	x17, x16, l.error_120_
# was:	bge	_arr_ind_117_, _size_119_, l.error_120_
	slli	x17, x17, 2
# was:	slli	_arr_ind_117_, _arr_ind_117_, 2
	add	x15, x15, x17
# was:	add	_arr_data_118_, _arr_data_118_, _arr_ind_117_
	lw	x20, 0(x15)
# was:	lw	_plus_L_115_, 0(_arr_data_118_)
	li	x16, 1
# was:	li	_arr_ind_122_, 1
	addi	x17, x14, 4
# was:	addi	_arr_data_123_, _tmp_65_, 4
	bge	x16, x0, l.nonneg_126_
# was:	bge	_arr_ind_122_, x0, l.nonneg_126_
l.error_125_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_126_:
	lw	x15, 0(x14)
# was:	lw	_size_124_, 0(_tmp_65_)
	bge	x16, x15, l.error_125_
# was:	bge	_arr_ind_122_, _size_124_, l.error_125_
	slli	x16, x16, 2
# was:	slli	_arr_ind_122_, _arr_ind_122_, 2
	add	x17, x17, x16
# was:	add	_arr_data_123_, _arr_data_123_, _arr_ind_122_
	lw	x15, 0(x17)
# was:	lw	_plus_R_116_, 0(_arr_data_123_)
	add	x16, x20, x15
# was:	add	_let_y_I17_114_, _plus_L_115_, _plus_R_116_
# 	mv	_lt_L_132_,_let_x_I17_108_
# 	mv	_lt_R_133_,_let_y_I17_114_
	slt	x15, x19, x16
# was:	slt	_cond_131_, _lt_L_132_, _lt_R_133_
	bne	x15, x0, l.then_128_
# was:	bne	_cond_131_, x0, l.then_128_
	j	l.else_129_
l.then_128_:
	mv	x15, x16
# was:	mv	_let_mis_127_, _let_y_I17_114_
	j	l.endif_130_
l.else_129_:
	mv	x15, x19
# was:	mv	_let_mis_127_, _let_x_I17_108_
l.endif_130_:
	li	x19, 2
# was:	li	_arr_ind_137_, 2
	addi	x16, x18, 4
# was:	addi	_arr_data_138_, _let_arr_61_, 4
	bge	x19, x0, l.nonneg_141_
# was:	bge	_arr_ind_137_, x0, l.nonneg_141_
l.error_140_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_141_:
	lw	x17, 0(x18)
# was:	lw	_size_139_, 0(_let_arr_61_)
	bge	x19, x17, l.error_140_
# was:	bge	_arr_ind_137_, _size_139_, l.error_140_
	slli	x19, x19, 2
# was:	slli	_arr_ind_137_, _arr_ind_137_, 2
	add	x16, x16, x19
# was:	add	_arr_data_138_, _arr_data_138_, _arr_ind_137_
	lw	x20, 0(x16)
# was:	lw	_plus_L_135_, 0(_arr_data_138_)
	li	x17, 3
# was:	li	_arr_ind_142_, 3
	addi	x19, x14, 4
# was:	addi	_arr_data_143_, _tmp_65_, 4
	bge	x17, x0, l.nonneg_146_
# was:	bge	_arr_ind_142_, x0, l.nonneg_146_
l.error_145_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_146_:
	lw	x16, 0(x14)
# was:	lw	_size_144_, 0(_tmp_65_)
	bge	x17, x16, l.error_145_
# was:	bge	_arr_ind_142_, _size_144_, l.error_145_
	slli	x17, x17, 2
# was:	slli	_arr_ind_142_, _arr_ind_142_, 2
	add	x19, x19, x17
# was:	add	_arr_data_143_, _arr_data_143_, _arr_ind_142_
	lw	x16, 0(x19)
# was:	lw	_plus_R_136_, 0(_arr_data_143_)
	add	x17, x20, x16
# was:	add	_let_x_I18_134_, _plus_L_135_, _plus_R_136_
	li	x19, 2
# was:	li	_arr_ind_148_, 2
	addi	x20, x14, 4
# was:	addi	_arr_data_149_, _tmp_65_, 4
	bge	x19, x0, l.nonneg_152_
# was:	bge	_arr_ind_148_, x0, l.nonneg_152_
l.error_151_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_152_:
	lw	x16, 0(x14)
# was:	lw	_size_150_, 0(_tmp_65_)
	bge	x19, x16, l.error_151_
# was:	bge	_arr_ind_148_, _size_150_, l.error_151_
	slli	x19, x19, 2
# was:	slli	_arr_ind_148_, _arr_ind_148_, 2
	add	x20, x20, x19
# was:	add	_arr_data_149_, _arr_data_149_, _arr_ind_148_
	lw	x19, 0(x20)
# was:	lw	_let_y_I18_147_, 0(_arr_data_149_)
# 	mv	_lt_L_158_,_let_x_I18_134_
# 	mv	_lt_R_159_,_let_y_I18_147_
	slt	x16, x17, x19
# was:	slt	_cond_157_, _lt_L_158_, _lt_R_159_
	bne	x16, x0, l.then_154_
# was:	bne	_cond_157_, x0, l.then_154_
	j	l.else_155_
l.then_154_:
	mv	x17, x19
# was:	mv	_let_mcs_153_, _let_y_I18_147_
	j	l.endif_156_
l.else_155_:
# 	mv	_let_mcs_153_,_let_x_I18_134_
l.endif_156_:
	li	x19, 3
# was:	li	_arr_ind_163_, 3
	addi	x16, x18, 4
# was:	addi	_arr_data_164_, _let_arr_61_, 4
	bge	x19, x0, l.nonneg_167_
# was:	bge	_arr_ind_163_, x0, l.nonneg_167_
l.error_166_:
	li	x10, 31
# was:	li	x10, 31
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_167_:
	lw	x18, 0(x18)
# was:	lw	_size_165_, 0(_let_arr_61_)
	bge	x19, x18, l.error_166_
# was:	bge	_arr_ind_163_, _size_165_, l.error_166_
	slli	x19, x19, 2
# was:	slli	_arr_ind_163_, _arr_ind_163_, 2
	add	x16, x16, x19
# was:	add	_arr_data_164_, _arr_data_164_, _arr_ind_163_
	lw	x18, 0(x16)
# was:	lw	_plus_L_161_, 0(_arr_data_164_)
	li	x19, 3
# was:	li	_arr_ind_168_, 3
	addi	x16, x14, 4
# was:	addi	_arr_data_169_, _tmp_65_, 4
	bge	x19, x0, l.nonneg_172_
# was:	bge	_arr_ind_168_, x0, l.nonneg_172_
l.error_171_:
	li	x10, 31
# was:	li	x10, 31
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_172_:
	lw	x14, 0(x14)
# was:	lw	_size_170_, 0(_tmp_65_)
	bge	x19, x14, l.error_171_
# was:	bge	_arr_ind_168_, _size_170_, l.error_171_
	slli	x19, x19, 2
# was:	slli	_arr_ind_168_, _arr_ind_168_, 2
	add	x16, x16, x19
# was:	add	_arr_data_169_, _arr_data_169_, _arr_ind_168_
	lw	x14, 0(x16)
# was:	lw	_plus_R_162_, 0(_arr_data_169_)
	add	x16, x18, x14
# was:	add	_let_ts_160_, _plus_L_161_, _plus_R_162_
	li	x14, 4
# was:	li	_size_173_, 4
	mv	x18, x3
# was:	mv	_fun_arg_res_68_, x3
	slli	x19, x14, 2
# was:	slli	_tmp_176_, _size_173_, 2
	addi	x19, x19, 4
# was:	addi	_tmp_176_, _tmp_176_, 4
	add	x3, x3, x19
# was:	add	x3, x3, _tmp_176_
	sw	x14, 0(x18)
# was:	sw	_size_173_, 0(_fun_arg_res_68_)
	addi	x14, x18, 4
# was:	addi	_addr_174_, _fun_arg_res_68_, 4
# 	mv	_tmp_175_,_let_mss_101_
	sw	x13, 0(x14)
# was:	sw	_tmp_175_, 0(_addr_174_)
	addi	x14, x14, 4
# was:	addi	_addr_174_, _addr_174_, 4
	mv	x13, x15
# was:	mv	_tmp_175_, _let_mis_127_
	sw	x13, 0(x14)
# was:	sw	_tmp_175_, 0(_addr_174_)
	addi	x14, x14, 4
# was:	addi	_addr_174_, _addr_174_, 4
	mv	x13, x17
# was:	mv	_tmp_175_, _let_mcs_153_
	sw	x13, 0(x14)
# was:	sw	_tmp_175_, 0(_addr_174_)
	addi	x14, x14, 4
# was:	addi	_addr_174_, _addr_174_, 4
	mv	x13, x16
# was:	mv	_tmp_175_, _let_ts_160_
	sw	x13, 0(x14)
# was:	sw	_tmp_175_, 0(_addr_174_)
	addi	x14, x14, 4
# was:	addi	_addr_174_, _addr_174_, 4
# 	mv	_let_arr_61_,_fun_arg_res_68_
	addi	x12, x12, 1
# was:	addi	_ind_var_64_, _ind_var_64_, 1
	j	l.loop_beg_66_
l.loop_end_67_:
	la	x10, s.XXMSSPX_179_
# was:	la	_tmp_178_, s.XXMSSPX_179_
# s.XXMSSPX_179_: string "\n\nMSSP result is: "
# 	mv	_let_t_177_,_tmp_178_
# 	mv	x10,_tmp_178_
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x11, 0
# was:	li	_arr_ind_181_, 0
	addi	x10, x18, 4
# was:	addi	_arr_data_182_, _let_arr_61_, 4
	bge	x11, x0, l.nonneg_185_
# was:	bge	_arr_ind_181_, x0, l.nonneg_185_
l.error_184_:
	li	x10, 44
# was:	li	x10, 44
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_185_:
	lw	x12, 0(x18)
# was:	lw	_size_183_, 0(_let_arr_61_)
	bge	x11, x12, l.error_184_
# was:	bge	_arr_ind_181_, _size_183_, l.error_184_
	slli	x11, x11, 2
# was:	slli	_arr_ind_181_, _arr_ind_181_, 2
	add	x10, x10, x11
# was:	add	_arr_data_182_, _arr_data_182_, _arr_ind_181_
	lw	x18, 0(x10)
# was:	lw	_tmp_180_, 0(_arr_data_182_)
# 	mv	_mainres_1_,_tmp_180_
	mv	x10, x18
# was:	mv	x10, _mainres_1_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_1_
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
s.XXMSSPX_179_:
	.word	18
	.ascii	"\n\nMSSP result is: "
	.align	2
s.X_31_:
	.word	1
	.ascii	"\n"
	.align	2
s.XX_27_:
	.word	2
	.ascii	": "
	.align	2
s.Introdu_22_:
	.word	17
	.ascii	"Introduce number "
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