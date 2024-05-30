	.text	0x00400000
	la	x3, d.heap
	jal	f.main
	jal	p.stop
# User functions
# Function read_int
f.read_int:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	mv	x18, x10
# was:	mv	_param_i_1_, x10
	la	x10, s.Introdu_5_
# was:	la	_tmp_4_, s.Introdu_5_
# s.Introdu_5_: string "Introduce number "
# 	mv	_let_t_3_,_tmp_4_
# 	mv	x10,_tmp_4_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	_tmp_7_, _param_i_1_
# 	mv	_let_t_6_,_tmp_7_
# 	mv	x10,_let_t_6_
	jal	p.putint
# was:	jal	p.putint, x10
	la	x10, s.XX_10_
# was:	la	_tmp_9_, s.XX_10_
# s.XX_10_: string ": "
# 	mv	_let_t_8_,_tmp_9_
# 	mv	x10,_tmp_9_
	jal	p.putstring
# was:	jal	p.putstring, x10
	jal	p.getint
# was:	jal	p.getint, 
	mv	x18, x10
# was:	mv	_let_m_11_, x10
	la	x10, s.X_14_
# was:	la	_tmp_13_, s.X_14_
# s.X_14_: string "\n"
# 	mv	_let_t_12_,_tmp_13_
# 	mv	x10,_tmp_13_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	_read_intres_2_, _let_m_11_
# 	mv	x10,_read_intres_2_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function read_int_arr
f.read_int_arr:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_n_15_,x10
# 	mv	_size_18_,_param_n_15_
	bge	x10, x0, l.safe_19_
# was:	bge	_size_18_, x0, l.safe_19_
	li	x10, 10
# was:	li	x10, 10
	la	x11, m.BadSize
# was:	la	x11, m.BadSize
	j	p.RuntimeError
l.safe_19_:
	mv	x11, x3
# was:	mv	_let_itsp_17_, x3
	slli	x12, x10, 2
# was:	slli	_tmp_24_, _size_18_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_24_, _tmp_24_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_24_
	sw	x10, 0(x11)
# was:	sw	_size_18_, 0(_let_itsp_17_)
	addi	x13, x11, 4
# was:	addi	_addr_20_, _let_itsp_17_, 4
	mv	x12, x0
# was:	mv	_i_21_, x0
l.loop_beg_22_:
	bge	x12, x10, l.loop_end_23_
# was:	bge	_i_21_, _size_18_, l.loop_end_23_
	sw	x12, 0(x13)
# was:	sw	_i_21_, 0(_addr_20_)
	addi	x13, x13, 4
# was:	addi	_addr_20_, _addr_20_, 4
	addi	x12, x12, 1
# was:	addi	_i_21_, _i_21_, 1
	j	l.loop_beg_22_
l.loop_end_23_:
	mv	x10, x11
# was:	mv	_arr_26_, _let_itsp_17_
	lw	x19, 0(x10)
# was:	lw	_size_25_, 0(_arr_26_)
	mv	x18, x3
# was:	mv	_read_int_arrres_16_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_34_, _size_25_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_34_, _tmp_34_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_34_
	sw	x19, 0(x18)
# was:	sw	_size_25_, 0(_read_int_arrres_16_)
	addi	x20, x18, 4
# was:	addi	_addrg_29_, _read_int_arrres_16_, 4
	mv	x21, x0
# was:	mv	_i_30_, x0
	addi	x22, x10, 4
# was:	addi	_elem_27_, _arr_26_, 4
l.loop_beg_31_:
	bge	x21, x19, l.loop_end_32_
# was:	bge	_i_30_, _size_25_, l.loop_end_32_
	lw	x10, 0(x22)
# was:	lw	_res_28_, 0(_elem_27_)
	addi	x22, x22, 4
# was:	addi	_elem_27_, _elem_27_, 4
# 	mv	x10,_res_28_
	jal	f.read_int
# was:	jal	f.read_int, x10
# 	mv	_tmp_33_,x10
# 	mv	_res_28_,_tmp_33_
	sw	x10, 0(x20)
# was:	sw	_res_28_, 0(_addrg_29_)
	addi	x20, x20, 4
# was:	addi	_addrg_29_, _addrg_29_, 4
	addi	x21, x21, 1
# was:	addi	_i_30_, _i_30_, 1
	j	l.loop_beg_31_
l.loop_end_32_:
	mv	x10, x18
# was:	mv	x10, _read_int_arrres_16_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function write_int
f.write_int:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
# 	mv	_param_i_35_,x10
	mv	x18, x10
# was:	mv	_tmp_37_, _param_i_35_
# 	mv	_write_intres_36_,_tmp_37_
	mv	x10, x18
# was:	mv	x10, _write_intres_36_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _write_intres_36_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function write_int_arr
f.write_int_arr:
	sw	x1, -4(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -20
	mv	x18, x10
# was:	mv	_param_arr_38_, x10
	la	x10, s.XXX_42_
# was:	la	_tmp_41_, s.XXX_42_
# s.XXX_42_: string " { "
# 	mv	_let_a_40_,_tmp_41_
# 	mv	x10,_tmp_41_
	jal	p.putstring
# was:	jal	p.putstring, x10
	mv	x10, x18
# was:	mv	_arr_45_, _param_arr_38_
	lw	x18, 0(x10)
# was:	lw	_size_44_, 0(_arr_45_)
	mv	x11, x3
# was:	mv	_let_v_43_, x3
	slli	x12, x18, 2
# was:	slli	_tmp_53_, _size_44_, 2
	addi	x12, x12, 4
# was:	addi	_tmp_53_, _tmp_53_, 4
	add	x3, x3, x12
# was:	add	x3, x3, _tmp_53_
	sw	x18, 0(x11)
# was:	sw	_size_44_, 0(_let_v_43_)
	addi	x19, x11, 4
# was:	addi	_addrg_48_, _let_v_43_, 4
	mv	x20, x0
# was:	mv	_i_49_, x0
	addi	x21, x10, 4
# was:	addi	_elem_46_, _arr_45_, 4
l.loop_beg_50_:
	bge	x20, x18, l.loop_end_51_
# was:	bge	_i_49_, _size_44_, l.loop_end_51_
	lw	x10, 0(x21)
# was:	lw	_res_47_, 0(_elem_46_)
	addi	x21, x21, 4
# was:	addi	_elem_46_, _elem_46_, 4
# 	mv	x10,_res_47_
	jal	f.write_int
# was:	jal	f.write_int, x10
# 	mv	_tmp_52_,x10
# 	mv	_res_47_,_tmp_52_
	sw	x10, 0(x19)
# was:	sw	_res_47_, 0(_addrg_48_)
	addi	x19, x19, 4
# was:	addi	_addrg_48_, _addrg_48_, 4
	addi	x20, x20, 1
# was:	addi	_i_49_, _i_49_, 1
	j	l.loop_beg_50_
l.loop_end_51_:
	la	x10, s.XXX_56_
# was:	la	_tmp_55_, s.XXX_56_
# s.XXX_56_: string " }\n"
# 	mv	_let_a_54_,_tmp_55_
# 	mv	x10,_tmp_55_
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 1
# was:	li	_write_int_arrres_39_, 1
# 	mv	x10,_write_int_arrres_39_
	addi	x2, x2, 20
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function max
f.max:
	sw	x1, -4(x2)
	addi	x2, x2, -4
# 	mv	_param_x_57_,x10
# 	mv	_param_y_58_,x11
# 	mv	_lt_L_64_,_param_x_57_
# 	mv	_lt_R_65_,_param_y_58_
	slt	x12, x10, x11
# was:	slt	_cond_63_, _lt_L_64_, _lt_R_65_
	bne	x12, x0, l.then_60_
# was:	bne	_cond_63_, x0, l.then_60_
	j	l.else_61_
l.then_60_:
	mv	x10, x11
# was:	mv	_maxres_59_, _param_y_58_
	j	l.endif_62_
l.else_61_:
# 	mv	_maxres_59_,_param_x_57_
l.endif_62_:
# 	mv	x10,_maxres_59_
	addi	x2, x2, 4
	lw	x1, -4(x2)
	jr	x1
# Function mapper
f.mapper:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	mv	x18, x10
# was:	mv	_param_x_66_, x10
	mv	x10, x18
# was:	mv	_arg_69_, _param_x_66_
	li	x11, 0
# was:	li	_arg_70_, 0
# 	mv	x10,_arg_69_
# 	mv	x11,_arg_70_
	jal	f.max
# was:	jal	f.max, x10 x11
	mv	x11, x10
# was:	mv	_let_xm_68_, x10
	li	x12, 4
# was:	li	_size_71_, 4
	mv	x10, x3
# was:	mv	_mapperres_67_, x3
	slli	x13, x12, 2
# was:	slli	_tmp_74_, _size_71_, 2
	addi	x13, x13, 4
# was:	addi	_tmp_74_, _tmp_74_, 4
	add	x3, x3, x13
# was:	add	x3, x3, _tmp_74_
	sw	x12, 0(x10)
# was:	sw	_size_71_, 0(_mapperres_67_)
	addi	x12, x10, 4
# was:	addi	_addr_72_, _mapperres_67_, 4
# 	mv	_tmp_73_,_let_xm_68_
	sw	x11, 0(x12)
# was:	sw	_tmp_73_, 0(_addr_72_)
	addi	x12, x12, 4
# was:	addi	_addr_72_, _addr_72_, 4
# 	mv	_tmp_73_,_let_xm_68_
	sw	x11, 0(x12)
# was:	sw	_tmp_73_, 0(_addr_72_)
	addi	x12, x12, 4
# was:	addi	_addr_72_, _addr_72_, 4
# 	mv	_tmp_73_,_let_xm_68_
	sw	x11, 0(x12)
# was:	sw	_tmp_73_, 0(_addr_72_)
	addi	x12, x12, 4
# was:	addi	_addr_72_, _addr_72_, 4
	mv	x11, x18
# was:	mv	_tmp_73_, _param_x_66_
	sw	x11, 0(x12)
# was:	sw	_tmp_73_, 0(_addr_72_)
	addi	x12, x12, 4
# was:	addi	_addr_72_, _addr_72_, 4
# 	mv	x10,_mapperres_67_
	addi	x2, x2, 8
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function reducer
f.reducer:
	sw	x1, -4(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -20
	mv	x20, x10
# was:	mv	_param_a_75_, x10
	mv	x18, x11
# was:	mv	_param_b_76_, x11
	li	x10, 0
# was:	li	_arr_ind_81_, 0
	addi	x12, x20, 4
# was:	addi	_arr_data_82_, _param_a_75_, 4
	bge	x10, x0, l.nonneg_85_
# was:	bge	_arr_ind_81_, x0, l.nonneg_85_
l.error_84_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_85_:
	lw	x11, 0(x20)
# was:	lw	_size_83_, 0(_param_a_75_)
	bge	x10, x11, l.error_84_
# was:	bge	_arr_ind_81_, _size_83_, l.error_84_
	slli	x10, x10, 2
# was:	slli	_arr_ind_81_, _arr_ind_81_, 2
	add	x12, x12, x10
# was:	add	_arr_data_82_, _arr_data_82_, _arr_ind_81_
	lw	x10, 0(x12)
# was:	lw	_arg_80_, 0(_arr_data_82_)
	li	x12, 0
# was:	li	_arr_ind_87_, 0
	addi	x13, x18, 4
# was:	addi	_arr_data_88_, _param_b_76_, 4
	bge	x12, x0, l.nonneg_91_
# was:	bge	_arr_ind_87_, x0, l.nonneg_91_
l.error_90_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_91_:
	lw	x11, 0(x18)
# was:	lw	_size_89_, 0(_param_b_76_)
	bge	x12, x11, l.error_90_
# was:	bge	_arr_ind_87_, _size_89_, l.error_90_
	slli	x12, x12, 2
# was:	slli	_arr_ind_87_, _arr_ind_87_, 2
	add	x13, x13, x12
# was:	add	_arr_data_88_, _arr_data_88_, _arr_ind_87_
	lw	x11, 0(x13)
# was:	lw	_arg_86_, 0(_arr_data_88_)
# 	mv	x10,_arg_80_
# 	mv	x11,_arg_86_
	jal	f.max
# was:	jal	f.max, x10 x11
# 	mv	_arg_79_,x10
	li	x11, 2
# was:	li	_arr_ind_95_, 2
	addi	x13, x20, 4
# was:	addi	_arr_data_96_, _param_a_75_, 4
	bge	x11, x0, l.nonneg_99_
# was:	bge	_arr_ind_95_, x0, l.nonneg_99_
l.error_98_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_99_:
	lw	x12, 0(x20)
# was:	lw	_size_97_, 0(_param_a_75_)
	bge	x11, x12, l.error_98_
# was:	bge	_arr_ind_95_, _size_97_, l.error_98_
	slli	x11, x11, 2
# was:	slli	_arr_ind_95_, _arr_ind_95_, 2
	add	x13, x13, x11
# was:	add	_arr_data_96_, _arr_data_96_, _arr_ind_95_
	lw	x11, 0(x13)
# was:	lw	_plus_L_93_, 0(_arr_data_96_)
	li	x14, 1
# was:	li	_arr_ind_100_, 1
	addi	x12, x18, 4
# was:	addi	_arr_data_101_, _param_b_76_, 4
	bge	x14, x0, l.nonneg_104_
# was:	bge	_arr_ind_100_, x0, l.nonneg_104_
l.error_103_:
	li	x10, 28
# was:	li	x10, 28
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_104_:
	lw	x13, 0(x18)
# was:	lw	_size_102_, 0(_param_b_76_)
	bge	x14, x13, l.error_103_
# was:	bge	_arr_ind_100_, _size_102_, l.error_103_
	slli	x14, x14, 2
# was:	slli	_arr_ind_100_, _arr_ind_100_, 2
	add	x12, x12, x14
# was:	add	_arr_data_101_, _arr_data_101_, _arr_ind_100_
	lw	x12, 0(x12)
# was:	lw	_plus_R_94_, 0(_arr_data_101_)
	add	x11, x11, x12
# was:	add	_arg_92_, _plus_L_93_, _plus_R_94_
# 	mv	x10,_arg_79_
# 	mv	x11,_arg_92_
	jal	f.max
# was:	jal	f.max, x10 x11
	mv	x19, x10
# was:	mv	_let_mss_78_, x10
	li	x10, 1
# was:	li	_arr_ind_107_, 1
	addi	x11, x20, 4
# was:	addi	_arr_data_108_, _param_a_75_, 4
	bge	x10, x0, l.nonneg_111_
# was:	bge	_arr_ind_107_, x0, l.nonneg_111_
l.error_110_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_111_:
	lw	x12, 0(x20)
# was:	lw	_size_109_, 0(_param_a_75_)
	bge	x10, x12, l.error_110_
# was:	bge	_arr_ind_107_, _size_109_, l.error_110_
	slli	x10, x10, 2
# was:	slli	_arr_ind_107_, _arr_ind_107_, 2
	add	x11, x11, x10
# was:	add	_arr_data_108_, _arr_data_108_, _arr_ind_107_
	lw	x12, 0(x11)
# was:	lw	_arg_106_, 0(_arr_data_108_)
	li	x10, 3
# was:	li	_arr_ind_115_, 3
	addi	x11, x20, 4
# was:	addi	_arr_data_116_, _param_a_75_, 4
	bge	x10, x0, l.nonneg_119_
# was:	bge	_arr_ind_115_, x0, l.nonneg_119_
l.error_118_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_119_:
	lw	x13, 0(x20)
# was:	lw	_size_117_, 0(_param_a_75_)
	bge	x10, x13, l.error_118_
# was:	bge	_arr_ind_115_, _size_117_, l.error_118_
	slli	x10, x10, 2
# was:	slli	_arr_ind_115_, _arr_ind_115_, 2
	add	x11, x11, x10
# was:	add	_arr_data_116_, _arr_data_116_, _arr_ind_115_
	lw	x10, 0(x11)
# was:	lw	_plus_L_113_, 0(_arr_data_116_)
	li	x11, 1
# was:	li	_arr_ind_120_, 1
	addi	x13, x18, 4
# was:	addi	_arr_data_121_, _param_b_76_, 4
	bge	x11, x0, l.nonneg_124_
# was:	bge	_arr_ind_120_, x0, l.nonneg_124_
l.error_123_:
	li	x10, 29
# was:	li	x10, 29
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_124_:
	lw	x14, 0(x18)
# was:	lw	_size_122_, 0(_param_b_76_)
	bge	x11, x14, l.error_123_
# was:	bge	_arr_ind_120_, _size_122_, l.error_123_
	slli	x11, x11, 2
# was:	slli	_arr_ind_120_, _arr_ind_120_, 2
	add	x13, x13, x11
# was:	add	_arr_data_121_, _arr_data_121_, _arr_ind_120_
	lw	x11, 0(x13)
# was:	lw	_plus_R_114_, 0(_arr_data_121_)
	add	x11, x10, x11
# was:	add	_arg_112_, _plus_L_113_, _plus_R_114_
	mv	x10, x12
# was:	mv	x10, _arg_106_
# 	mv	x11,_arg_112_
	jal	f.max
# was:	jal	f.max, x10 x11
	mv	x21, x10
# was:	mv	_let_mis_105_, x10
	li	x12, 2
# was:	li	_arr_ind_129_, 2
	addi	x11, x20, 4
# was:	addi	_arr_data_130_, _param_a_75_, 4
	bge	x12, x0, l.nonneg_133_
# was:	bge	_arr_ind_129_, x0, l.nonneg_133_
l.error_132_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_133_:
	lw	x10, 0(x20)
# was:	lw	_size_131_, 0(_param_a_75_)
	bge	x12, x10, l.error_132_
# was:	bge	_arr_ind_129_, _size_131_, l.error_132_
	slli	x12, x12, 2
# was:	slli	_arr_ind_129_, _arr_ind_129_, 2
	add	x11, x11, x12
# was:	add	_arr_data_130_, _arr_data_130_, _arr_ind_129_
	lw	x12, 0(x11)
# was:	lw	_plus_L_127_, 0(_arr_data_130_)
	li	x11, 3
# was:	li	_arr_ind_134_, 3
	addi	x13, x18, 4
# was:	addi	_arr_data_135_, _param_b_76_, 4
	bge	x11, x0, l.nonneg_138_
# was:	bge	_arr_ind_134_, x0, l.nonneg_138_
l.error_137_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_138_:
	lw	x10, 0(x18)
# was:	lw	_size_136_, 0(_param_b_76_)
	bge	x11, x10, l.error_137_
# was:	bge	_arr_ind_134_, _size_136_, l.error_137_
	slli	x11, x11, 2
# was:	slli	_arr_ind_134_, _arr_ind_134_, 2
	add	x13, x13, x11
# was:	add	_arr_data_135_, _arr_data_135_, _arr_ind_134_
	lw	x10, 0(x13)
# was:	lw	_plus_R_128_, 0(_arr_data_135_)
	add	x10, x12, x10
# was:	add	_arg_126_, _plus_L_127_, _plus_R_128_
	li	x12, 2
# was:	li	_arr_ind_140_, 2
	addi	x13, x18, 4
# was:	addi	_arr_data_141_, _param_b_76_, 4
	bge	x12, x0, l.nonneg_144_
# was:	bge	_arr_ind_140_, x0, l.nonneg_144_
l.error_143_:
	li	x10, 30
# was:	li	x10, 30
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_144_:
	lw	x11, 0(x18)
# was:	lw	_size_142_, 0(_param_b_76_)
	bge	x12, x11, l.error_143_
# was:	bge	_arr_ind_140_, _size_142_, l.error_143_
	slli	x12, x12, 2
# was:	slli	_arr_ind_140_, _arr_ind_140_, 2
	add	x13, x13, x12
# was:	add	_arr_data_141_, _arr_data_141_, _arr_ind_140_
	lw	x11, 0(x13)
# was:	lw	_arg_139_, 0(_arr_data_141_)
# 	mv	x10,_arg_126_
# 	mv	x11,_arg_139_
	jal	f.max
# was:	jal	f.max, x10 x11
# 	mv	_let_mcs_125_,x10
	li	x12, 3
# was:	li	_arr_ind_148_, 3
	addi	x11, x20, 4
# was:	addi	_arr_data_149_, _param_a_75_, 4
	bge	x12, x0, l.nonneg_152_
# was:	bge	_arr_ind_148_, x0, l.nonneg_152_
l.error_151_:
	li	x10, 31
# was:	li	x10, 31
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_152_:
	lw	x13, 0(x20)
# was:	lw	_size_150_, 0(_param_a_75_)
	bge	x12, x13, l.error_151_
# was:	bge	_arr_ind_148_, _size_150_, l.error_151_
	slli	x12, x12, 2
# was:	slli	_arr_ind_148_, _arr_ind_148_, 2
	add	x11, x11, x12
# was:	add	_arr_data_149_, _arr_data_149_, _arr_ind_148_
	lw	x13, 0(x11)
# was:	lw	_plus_L_146_, 0(_arr_data_149_)
	li	x11, 3
# was:	li	_arr_ind_153_, 3
	addi	x12, x18, 4
# was:	addi	_arr_data_154_, _param_b_76_, 4
	bge	x11, x0, l.nonneg_157_
# was:	bge	_arr_ind_153_, x0, l.nonneg_157_
l.error_156_:
	li	x10, 31
# was:	li	x10, 31
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_157_:
	lw	x14, 0(x18)
# was:	lw	_size_155_, 0(_param_b_76_)
	bge	x11, x14, l.error_156_
# was:	bge	_arr_ind_153_, _size_155_, l.error_156_
	slli	x11, x11, 2
# was:	slli	_arr_ind_153_, _arr_ind_153_, 2
	add	x12, x12, x11
# was:	add	_arr_data_154_, _arr_data_154_, _arr_ind_153_
	lw	x11, 0(x12)
# was:	lw	_plus_R_147_, 0(_arr_data_154_)
	add	x12, x13, x11
# was:	add	_let_ts_145_, _plus_L_146_, _plus_R_147_
	li	x13, 4
# was:	li	_size_158_, 4
	mv	x11, x3
# was:	mv	_reducerres_77_, x3
	slli	x14, x13, 2
# was:	slli	_tmp_161_, _size_158_, 2
	addi	x14, x14, 4
# was:	addi	_tmp_161_, _tmp_161_, 4
	add	x3, x3, x14
# was:	add	x3, x3, _tmp_161_
	sw	x13, 0(x11)
# was:	sw	_size_158_, 0(_reducerres_77_)
	addi	x13, x11, 4
# was:	addi	_addr_159_, _reducerres_77_, 4
# 	mv	_tmp_160_,_let_mss_78_
	sw	x19, 0(x13)
# was:	sw	_tmp_160_, 0(_addr_159_)
	addi	x13, x13, 4
# was:	addi	_addr_159_, _addr_159_, 4
	mv	x19, x21
# was:	mv	_tmp_160_, _let_mis_105_
	sw	x19, 0(x13)
# was:	sw	_tmp_160_, 0(_addr_159_)
	addi	x13, x13, 4
# was:	addi	_addr_159_, _addr_159_, 4
	mv	x19, x10
# was:	mv	_tmp_160_, _let_mcs_125_
	sw	x19, 0(x13)
# was:	sw	_tmp_160_, 0(_addr_159_)
	addi	x13, x13, 4
# was:	addi	_addr_159_, _addr_159_, 4
	mv	x19, x12
# was:	mv	_tmp_160_, _let_ts_145_
	sw	x19, 0(x13)
# was:	sw	_tmp_160_, 0(_addr_159_)
	addi	x13, x13, 4
# was:	addi	_addr_159_, _addr_159_, 4
	mv	x10, x11
# was:	mv	x10, _reducerres_77_
	addi	x2, x2, 20
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function mssp
f.mssp:
	sw	x1, -4(x2)
	sw	x22, -24(x2)
	sw	x21, -20(x2)
	sw	x20, -16(x2)
	sw	x19, -12(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -24
# 	mv	_param_n_162_,x10
# 	mv	_arg_165_,_param_n_162_
# 	mv	x10,_arg_165_
	jal	f.read_int_arr
# was:	jal	f.read_int_arr, x10
# 	mv	_let_in_arr_164_,x10
# 	mv	_arr_168_,_let_in_arr_164_
	lw	x19, 0(x10)
# was:	lw	_size_167_, 0(_arr_168_)
	mv	x18, x3
# was:	mv	_let_map_arr_166_, x3
	slli	x11, x19, 2
# was:	slli	_tmp_176_, _size_167_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_176_, _tmp_176_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_176_
	sw	x19, 0(x18)
# was:	sw	_size_167_, 0(_let_map_arr_166_)
	addi	x20, x18, 4
# was:	addi	_addrg_171_, _let_map_arr_166_, 4
	mv	x21, x0
# was:	mv	_i_172_, x0
	addi	x22, x10, 4
# was:	addi	_elem_169_, _arr_168_, 4
l.loop_beg_173_:
	bge	x21, x19, l.loop_end_174_
# was:	bge	_i_172_, _size_167_, l.loop_end_174_
	lw	x10, 0(x22)
# was:	lw	_res_170_, 0(_elem_169_)
	addi	x22, x22, 4
# was:	addi	_elem_169_, _elem_169_, 4
# 	mv	x10,_res_170_
	jal	f.mapper
# was:	jal	f.mapper, x10
# 	mv	_tmp_175_,x10
# 	mv	_res_170_,_tmp_175_
	sw	x10, 0(x20)
# was:	sw	_res_170_, 0(_addrg_171_)
	addi	x20, x20, 4
# was:	addi	_addrg_171_, _addrg_171_, 4
	addi	x21, x21, 1
# was:	addi	_i_172_, _i_172_, 1
	j	l.loop_beg_173_
l.loop_end_174_:
	li	x12, 4
# was:	li	_size_178_, 4
	mv	x10, x3
# was:	mv	_let_ne_177_, x3
	slli	x11, x12, 2
# was:	slli	_tmp_181_, _size_178_, 2
	addi	x11, x11, 4
# was:	addi	_tmp_181_, _tmp_181_, 4
	add	x3, x3, x11
# was:	add	x3, x3, _tmp_181_
	sw	x12, 0(x10)
# was:	sw	_size_178_, 0(_let_ne_177_)
	addi	x12, x10, 4
# was:	addi	_addr_179_, _let_ne_177_, 4
	li	x11, 0
# was:	li	_tmp_180_, 0
	sw	x11, 0(x12)
# was:	sw	_tmp_180_, 0(_addr_179_)
	addi	x12, x12, 4
# was:	addi	_addr_179_, _addr_179_, 4
	li	x11, 0
# was:	li	_tmp_180_, 0
	sw	x11, 0(x12)
# was:	sw	_tmp_180_, 0(_addr_179_)
	addi	x12, x12, 4
# was:	addi	_addr_179_, _addr_179_, 4
	li	x11, 0
# was:	li	_tmp_180_, 0
	sw	x11, 0(x12)
# was:	sw	_tmp_180_, 0(_addr_179_)
	addi	x12, x12, 4
# was:	addi	_addr_179_, _addr_179_, 4
	li	x11, 0
# was:	li	_tmp_180_, 0
	sw	x11, 0(x12)
# was:	sw	_tmp_180_, 0(_addr_179_)
	addi	x12, x12, 4
# was:	addi	_addr_179_, _addr_179_, 4
	mv	x19, x18
# was:	mv	_arr_182_, _let_map_arr_166_
	lw	x18, 0(x19)
# was:	lw	_size_183_, 0(_arr_182_)
# 	mv	_msspres_163_,_let_ne_177_
	addi	x19, x19, 4
# was:	addi	_arr_182_, _arr_182_, 4
	mv	x20, x0
# was:	mv	_ind_var_184_, x0
l.loop_beg_186_:
	bge	x20, x18, l.loop_end_187_
# was:	bge	_ind_var_184_, _size_183_, l.loop_end_187_
	lw	x11, 0(x19)
# was:	lw	_tmp_185_, 0(_arr_182_)
	addi	x19, x19, 4
# was:	addi	_arr_182_, _arr_182_, 4
# 	mv	x10,_msspres_163_
# 	mv	x11,_tmp_185_
	jal	f.reducer
# was:	jal	f.reducer, x10 x11
# 	mv	_tmp_188_,x10
# 	mv	_msspres_163_,_tmp_188_
	addi	x20, x20, 1
# was:	addi	_ind_var_184_, _ind_var_184_, 1
	j	l.loop_beg_186_
l.loop_end_187_:
# 	mv	x10,_msspres_163_
	addi	x2, x2, 24
	lw	x22, -24(x2)
	lw	x21, -20(x2)
	lw	x20, -16(x2)
	lw	x19, -12(x2)
	lw	x18, -8(x2)
	lw	x1, -4(x2)
	jr	x1
# Function main
f.main:
	sw	x1, -4(x2)
	sw	x18, -8(x2)
	addi	x2, x2, -8
	li	x10, 8
# was:	li	_arg_191_, 8
# 	mv	x10,_arg_191_
	jal	f.mssp
# was:	jal	f.mssp, x10
	mv	x18, x10
# was:	mv	_let_arr_190_, x10
	la	x10, s.XXMSSPX_194_
# was:	la	_tmp_193_, s.XXMSSPX_194_
# s.XXMSSPX_194_: string "\n\nMSSP result is: "
# 	mv	_let_t_192_,_tmp_193_
# 	mv	x10,_tmp_193_
	jal	p.putstring
# was:	jal	p.putstring, x10
	li	x10, 0
# was:	li	_arr_ind_196_, 0
	addi	x11, x18, 4
# was:	addi	_arr_data_197_, _let_arr_190_, 4
	bge	x10, x0, l.nonneg_200_
# was:	bge	_arr_ind_196_, x0, l.nonneg_200_
l.error_199_:
	li	x10, 44
# was:	li	x10, 44
	la	x11, m.BadIndex
# was:	la	x11, m.BadIndex
	j	p.RuntimeError
l.nonneg_200_:
	lw	x12, 0(x18)
# was:	lw	_size_198_, 0(_let_arr_190_)
	bge	x10, x12, l.error_199_
# was:	bge	_arr_ind_196_, _size_198_, l.error_199_
	slli	x10, x10, 2
# was:	slli	_arr_ind_196_, _arr_ind_196_, 2
	add	x11, x11, x10
# was:	add	_arr_data_197_, _arr_data_197_, _arr_ind_196_
	lw	x18, 0(x11)
# was:	lw	_tmp_195_, 0(_arr_data_197_)
# 	mv	_mainres_189_,_tmp_195_
	mv	x10, x18
# was:	mv	x10, _mainres_189_
	jal	p.putint
# was:	jal	p.putint, x10
	mv	x10, x18
# was:	mv	x10, _mainres_189_
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
s.XXMSSPX_194_:
	.word	18
	.ascii	"\n\nMSSP result is: "
	.align	2
s.XXX_56_:
	.word	3
	.ascii	" }\n"
	.align	2
s.XXX_42_:
	.word	3
	.ascii	" { "
	.align	2
s.X_14_:
	.word	1
	.ascii	"\n"
	.align	2
s.XX_10_:
	.word	2
	.ascii	": "
	.align	2
s.Introdu_5_:
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