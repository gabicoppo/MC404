	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.file	"start.c"
	.globl	read                            # -- Begin function read
	.p2align	2
	.type	read,@function
read:                                   # @read
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 63	# syscall read code (63) 
	ecall	# invoke syscall 
	mv	a3, a0	# move return value to ret_val

	#NO_APP
	sw	a3, -28(s0)                     # 4-byte Folded Spill
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	read, .Lfunc_end0-read
                                        # -- End function
	.globl	write                           # -- Begin function write
	.p2align	2
	.type	write,@function
write:                                  # @write
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 64	# syscall write (64) 
	ecall
	#NO_APP
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	write, .Lfunc_end1-write
                                        # -- End function
	.globl	exit                            # -- Begin function exit
	.p2align	2
	.type	exit,@function
exit:                                   # @exit
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	#APP
	mv	a0, a1	# return code
	li	a7, 93	# syscall exit (64) 
	ecall
	#NO_APP
.Lfunc_end2:
	.size	exit, .Lfunc_end2-exit
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	li	a0, 0
	sw	a0, -12(s0)
	lui	a1, %hi(buffer)
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	addi	a1, a1, %lo(buffer)
	li	a2, 6
	call	read
	mv	a1, a0
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	sw	a1, -16(s0)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 48
	bne	a0, a1, .LBB3_2
	j	.LBB3_1
.LBB3_1:
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB3_29
.LBB3_2:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 49
	bne	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB3_28
.LBB3_4:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 50
	bne	a0, a1, .LBB3_6
	j	.LBB3_5
.LBB3_5:
	li	a0, 2
	sw	a0, -20(s0)
	j	.LBB3_27
.LBB3_6:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 51
	bne	a0, a1, .LBB3_8
	j	.LBB3_7
.LBB3_7:
	li	a0, 3
	sw	a0, -20(s0)
	j	.LBB3_26
.LBB3_8:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 52
	bne	a0, a1, .LBB3_10
	j	.LBB3_9
.LBB3_9:
	li	a0, 4
	sw	a0, -20(s0)
	j	.LBB3_25
.LBB3_10:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 53
	bne	a0, a1, .LBB3_12
	j	.LBB3_11
.LBB3_11:
	li	a0, 5
	sw	a0, -20(s0)
	j	.LBB3_24
.LBB3_12:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 54
	bne	a0, a1, .LBB3_14
	j	.LBB3_13
.LBB3_13:
	li	a0, 6
	sw	a0, -20(s0)
	j	.LBB3_23
.LBB3_14:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 55
	bne	a0, a1, .LBB3_16
	j	.LBB3_15
.LBB3_15:
	li	a0, 7
	sw	a0, -20(s0)
	j	.LBB3_22
.LBB3_16:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 56
	bne	a0, a1, .LBB3_18
	j	.LBB3_17
.LBB3_17:
	li	a0, 8
	sw	a0, -20(s0)
	j	.LBB3_21
.LBB3_18:
	lui	a0, %hi(buffer)
	lbu	a0, %lo(buffer)(a0)
	li	a1, 57
	bne	a0, a1, .LBB3_20
	j	.LBB3_19
.LBB3_19:
	li	a0, 9
	sw	a0, -20(s0)
	j	.LBB3_20
.LBB3_20:
	j	.LBB3_21
.LBB3_21:
	j	.LBB3_22
.LBB3_22:
	j	.LBB3_23
.LBB3_23:
	j	.LBB3_24
.LBB3_24:
	j	.LBB3_25
.LBB3_25:
	j	.LBB3_26
.LBB3_26:
	j	.LBB3_27
.LBB3_27:
	j	.LBB3_28
.LBB3_28:
	j	.LBB3_29
.LBB3_29:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 48
	bne	a0, a1, .LBB3_31
	j	.LBB3_30
.LBB3_30:
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB3_58
.LBB3_31:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 49
	bne	a0, a1, .LBB3_33
	j	.LBB3_32
.LBB3_32:
	li	a0, 1
	sw	a0, -24(s0)
	j	.LBB3_57
.LBB3_33:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 50
	bne	a0, a1, .LBB3_35
	j	.LBB3_34
.LBB3_34:
	li	a0, 2
	sw	a0, -24(s0)
	j	.LBB3_56
.LBB3_35:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 51
	bne	a0, a1, .LBB3_37
	j	.LBB3_36
.LBB3_36:
	li	a0, 3
	sw	a0, -24(s0)
	j	.LBB3_55
.LBB3_37:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 52
	bne	a0, a1, .LBB3_39
	j	.LBB3_38
.LBB3_38:
	li	a0, 4
	sw	a0, -24(s0)
	j	.LBB3_54
.LBB3_39:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 53
	bne	a0, a1, .LBB3_41
	j	.LBB3_40
.LBB3_40:
	li	a0, 5
	sw	a0, -24(s0)
	j	.LBB3_53
.LBB3_41:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 54
	bne	a0, a1, .LBB3_43
	j	.LBB3_42
.LBB3_42:
	li	a0, 6
	sw	a0, -24(s0)
	j	.LBB3_52
.LBB3_43:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 55
	bne	a0, a1, .LBB3_45
	j	.LBB3_44
.LBB3_44:
	li	a0, 7
	sw	a0, -24(s0)
	j	.LBB3_51
.LBB3_45:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 56
	bne	a0, a1, .LBB3_47
	j	.LBB3_46
.LBB3_46:
	li	a0, 8
	sw	a0, -24(s0)
	j	.LBB3_50
.LBB3_47:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 4(a0)
	li	a1, 57
	bne	a0, a1, .LBB3_49
	j	.LBB3_48
.LBB3_48:
	li	a0, 9
	sw	a0, -24(s0)
	j	.LBB3_49
.LBB3_49:
	j	.LBB3_50
.LBB3_50:
	j	.LBB3_51
.LBB3_51:
	j	.LBB3_52
.LBB3_52:
	j	.LBB3_53
.LBB3_53:
	j	.LBB3_54
.LBB3_54:
	j	.LBB3_55
.LBB3_55:
	j	.LBB3_56
.LBB3_56:
	j	.LBB3_57
.LBB3_57:
	j	.LBB3_58
.LBB3_58:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 2(a0)
	li	a1, 43
	bne	a0, a1, .LBB3_60
	j	.LBB3_59
.LBB3_59:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	sb	a0, -25(s0)
	j	.LBB3_66
.LBB3_60:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 2(a0)
	li	a1, 45
	bne	a0, a1, .LBB3_62
	j	.LBB3_61
.LBB3_61:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	sub	a0, a0, a1
	sb	a0, -25(s0)
	j	.LBB3_65
.LBB3_62:
	lui	a0, %hi(buffer)
	addi	a0, a0, %lo(buffer)
	lbu	a0, 2(a0)
	li	a1, 42
	bne	a0, a1, .LBB3_64
	j	.LBB3_63
.LBB3_63:
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	mul	a0, a0, a1
	sb	a0, -25(s0)
	j	.LBB3_64
.LBB3_64:
	j	.LBB3_65
.LBB3_65:
	j	.LBB3_66
.LBB3_66:
	lbu	a0, -25(s0)
	bnez	a0, .LBB3_68
	j	.LBB3_67
.LBB3_67:
	li	a0, 48
	sb	a0, -25(s0)
	j	.LBB3_95
.LBB3_68:
	lbu	a0, -25(s0)
	li	a1, 1
	bne	a0, a1, .LBB3_70
	j	.LBB3_69
.LBB3_69:
	li	a0, 49
	sb	a0, -25(s0)
	j	.LBB3_94
.LBB3_70:
	lbu	a0, -25(s0)
	li	a1, 2
	bne	a0, a1, .LBB3_72
	j	.LBB3_71
.LBB3_71:
	li	a0, 50
	sb	a0, -25(s0)
	j	.LBB3_93
.LBB3_72:
	lbu	a0, -25(s0)
	li	a1, 3
	bne	a0, a1, .LBB3_74
	j	.LBB3_73
.LBB3_73:
	li	a0, 51
	sb	a0, -25(s0)
	j	.LBB3_92
.LBB3_74:
	lbu	a0, -25(s0)
	li	a1, 4
	bne	a0, a1, .LBB3_76
	j	.LBB3_75
.LBB3_75:
	li	a0, 52
	sb	a0, -25(s0)
	j	.LBB3_91
.LBB3_76:
	lbu	a0, -25(s0)
	li	a1, 5
	bne	a0, a1, .LBB3_78
	j	.LBB3_77
.LBB3_77:
	li	a0, 53
	sb	a0, -25(s0)
	j	.LBB3_90
.LBB3_78:
	lbu	a0, -25(s0)
	li	a1, 6
	bne	a0, a1, .LBB3_80
	j	.LBB3_79
.LBB3_79:
	li	a0, 54
	sb	a0, -25(s0)
	j	.LBB3_89
.LBB3_80:
	lbu	a0, -25(s0)
	li	a1, 7
	bne	a0, a1, .LBB3_82
	j	.LBB3_81
.LBB3_81:
	li	a0, 55
	sb	a0, -25(s0)
	j	.LBB3_88
.LBB3_82:
	lbu	a0, -25(s0)
	li	a1, 8
	bne	a0, a1, .LBB3_84
	j	.LBB3_83
.LBB3_83:
	li	a0, 56
	sb	a0, -25(s0)
	j	.LBB3_87
.LBB3_84:
	lbu	a0, -25(s0)
	li	a1, 9
	bne	a0, a1, .LBB3_86
	j	.LBB3_85
.LBB3_85:
	li	a0, 57
	sb	a0, -25(s0)
	j	.LBB3_86
.LBB3_86:
	j	.LBB3_87
.LBB3_87:
	j	.LBB3_88
.LBB3_88:
	j	.LBB3_89
.LBB3_89:
	j	.LBB3_90
.LBB3_90:
	j	.LBB3_91
.LBB3_91:
	j	.LBB3_92
.LBB3_92:
	j	.LBB3_93
.LBB3_93:
	j	.LBB3_94
.LBB3_94:
	j	.LBB3_95
.LBB3_95:
	addi	a1, s0, -25
	li	a2, 1
	sw	a2, -36(s0)                     # 4-byte Folded Spill
	mv	a0, a2
	call	write
	lw	a2, -36(s0)                     # 4-byte Folded Reload
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	mv	a0, a2
	call	write
	li	a0, 0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.globl	_start                          # -- Begin function _start
	.p2align	2
	.type	_start,@function
_start:                                 # @_start
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	main
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	exit
.Lfunc_end4:
	.size	_start, .Lfunc_end4-_start
                                        # -- End function
	.type	buffer,@object                  # @buffer
	.section	.sbss,"aw",@nobits
	.globl	buffer
buffer:
	.zero	6
	.size	buffer, 6

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\n"
	.size	.L.str, 2

	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym main
	.addrsig_sym buffer
