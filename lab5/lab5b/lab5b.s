	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.file	"lab5b.c"
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
	.globl	strcmp_custom                   # -- Begin function strcmp_custom
	.p2align	2
	.type	strcmp_custom,@function
strcmp_custom:                          # @strcmp_custom
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB2_1
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	lw	a1, -24(s0)
	bge	a0, a1, .LBB2_9
	j	.LBB2_2
.LBB2_2:                                #   in Loop: Header=BB2_1 Depth=1
	lw	a0, -16(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -20(s0)
	add	a1, a1, a2
	lbu	a1, 0(a1)
	bge	a0, a1, .LBB2_4
	j	.LBB2_3
.LBB2_3:
	li	a0, -1
	sw	a0, -12(s0)
	j	.LBB2_10
.LBB2_4:                                #   in Loop: Header=BB2_1 Depth=1
	lw	a0, -16(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	lbu	a1, 0(a0)
	lw	a0, -20(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	bge	a0, a1, .LBB2_6
	j	.LBB2_5
.LBB2_5:
	li	a0, 1
	sw	a0, -12(s0)
	j	.LBB2_10
.LBB2_6:                                #   in Loop: Header=BB2_1 Depth=1
	j	.LBB2_7
.LBB2_7:                                #   in Loop: Header=BB2_1 Depth=1
	j	.LBB2_8
.LBB2_8:                                #   in Loop: Header=BB2_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB2_1
.LBB2_9:
	li	a0, 0
	sw	a0, -12(s0)
	j	.LBB2_10
.LBB2_10:
	lw	a0, -12(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	strcmp_custom, .Lfunc_end2-strcmp_custom
                                        # -- End function
	.globl	pack                            # -- Begin function pack
	.p2align	2
	.type	pack,@function
pack:                                   # @pack
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -12(s0)
	li	a0, 0
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 28(a0)
	bnez	a0, .LBB3_2
	j	.LBB3_1
.LBB3_1:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 20(a0)
	slli	a2, a0, 12
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	slli	a2, a0, 15
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 12(a0)
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 24(a0)
	slli	a2, a0, 25
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_15
.LBB3_2:
	lw	a0, -16(s0)
	lw	a0, 28(a0)
	li	a1, 1
	bne	a0, a1, .LBB3_4
	j	.LBB3_3
.LBB3_3:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 20(a0)
	slli	a2, a0, 12
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	slli	a2, a0, 15
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_14
.LBB3_4:
	lw	a0, -16(s0)
	lw	a0, 28(a0)
	li	a1, 2
	bne	a0, a1, .LBB3_6
	j	.LBB3_5
.LBB3_5:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	andi	a0, a0, 31
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 20(a0)
	slli	a2, a0, 12
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	slli	a2, a0, 15
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 12(a0)
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	srli	a0, a0, 5
	slli	a2, a0, 25
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_13
.LBB3_6:
	lw	a0, -16(s0)
	lw	a0, 28(a0)
	li	a1, 3
	bne	a0, a1, .LBB3_8
	j	.LBB3_7
.LBB3_7:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	andi	a0, a0, 30
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	li	a1, 1
	slli	a1, a1, 11
	and	a0, a0, a1
	srli	a2, a0, 4
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 20(a0)
	slli	a2, a0, 12
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 8(a0)
	slli	a2, a0, 15
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 12(a0)
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	andi	a0, a0, 2016
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	srli	a0, a0, 12
	slli	a2, a0, 31
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_12
.LBB3_8:
	lw	a0, -16(s0)
	lw	a0, 28(a0)
	li	a1, 4
	bne	a0, a1, .LBB3_10
	j	.LBB3_9
.LBB3_9:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	slli	a2, a0, 12
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_11
.LBB3_10:
	lw	a0, -16(s0)
	lw	a2, 0(a0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 4(a0)
	slli	a2, a0, 7
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	andi	a0, a0, 2046
	slli	a2, a0, 20
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	li	a1, 1
	slli	a1, a1, 11
	and	a0, a0, a1
	slli	a2, a0, 9
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	lui	a1, 255
	and	a2, a0, a1
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a0, 16(a0)
	srli	a0, a0, 20
	slli	a2, a0, 31
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	j	.LBB3_11
.LBB3_11:
	j	.LBB3_12
.LBB3_12:
	j	.LBB3_13
.LBB3_13:
	j	.LBB3_14
.LBB3_14:
	j	.LBB3_15
.LBB3_15:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	pack, .Lfunc_end3-pack
                                        # -- End function
	.globl	hex_code                        # -- Begin function hex_code
	.p2align	2
	.type	hex_code,@function
hex_code:                               # @hex_code
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	sw	a0, -28(s0)
	li	a0, 48
	sb	a0, -23(s0)
	li	a0, 120
	sb	a0, -22(s0)
	li	a0, 10
	sb	a0, -13(s0)
	li	a0, 9
	sw	a0, -36(s0)
	j	.LBB4_1
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -36(s0)
	li	a1, 2
	blt	a0, a1, .LBB4_7
	j	.LBB4_2
.LBB4_2:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	andi	a0, a0, 15
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	li	a1, 10
	bltu	a0, a1, .LBB4_4
	j	.LBB4_3
.LBB4_3:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 55
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB4_5
.LBB4_4:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 48
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB4_5
.LBB4_5:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	srli	a0, a0, 4
	sw	a0, -28(s0)
	j	.LBB4_6
.LBB4_6:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -36(s0)
	j	.LBB4_1
.LBB4_7:
	li	a0, 1
	addi	a1, s0, -23
	li	a2, 11
	call	write
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end4:
	.size	hex_code, .Lfunc_end4-hex_code
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
	li	a7, 93	# syscall exit (93) 
	ecall
	#NO_APP
.Lfunc_end5:
	.size	exit, .Lfunc_end5-exit
                                        # -- End function
	.globl	dec_to_int                      # -- Begin function dec_to_int
	.p2align	2
	.type	dec_to_int,@function
dec_to_int:                             # @dec_to_int
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 45
	bne	a0, a1, .LBB6_2
	j	.LBB6_1
.LBB6_1:
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB6_2
.LBB6_2:
	lw	a0, -20(s0)
	sw	a0, -28(s0)
	j	.LBB6_3
.LBB6_3:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a2, 0
	li	a1, 48
	sw	a2, -32(s0)                     # 4-byte Folded Spill
	blt	a0, a1, .LBB6_5
	j	.LBB6_4
.LBB6_4:                                #   in Loop: Header=BB6_3 Depth=1
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	slti	a0, a0, 58
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	j	.LBB6_5
.LBB6_5:                                #   in Loop: Header=BB6_3 Depth=1
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB6_7
	j	.LBB6_6
.LBB6_6:                                #   in Loop: Header=BB6_3 Depth=1
	lw	a0, -24(s0)
	li	a1, 10
	mul	a0, a0, a1
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	a1, -12(s0)
	lw	a2, -28(s0)
	add	a1, a1, a2
	lbu	a1, 0(a1)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -24(s0)
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB6_3
.LBB6_7:
	lw	a0, -20(s0)
	li	a1, 1
	bne	a0, a1, .LBB6_9
	j	.LBB6_8
.LBB6_8:
	lw	a1, -24(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -24(s0)
	j	.LBB6_9
.LBB6_9:
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	lw	a2, 0(a1)
	add	a0, a0, a2
	addi	a0, a0, 1
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	dec_to_int, .Lfunc_end6-dec_to_int
                                        # -- End function
	.globl	get_register                    # -- Begin function get_register
	.p2align	2
	.type	get_register,@function
get_register:                           # @get_register
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 120
	beq	a0, a1, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_3:
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	call	dec_to_int
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	get_register, .Lfunc_end7-get_register
                                        # -- End function
	.globl	get_immediate                   # -- Begin function get_immediate
	.p2align	2
	.type	get_immediate,@function
get_immediate:                          # @get_immediate
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB8_1
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	blt	a0, a1, .LBB8_3
	j	.LBB8_2
.LBB8_2:                                #   in Loop: Header=BB8_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a2, 1
	li	a1, 58
	sw	a2, -24(s0)                     # 4-byte Folded Spill
	blt	a0, a1, .LBB8_4
	j	.LBB8_3
.LBB8_3:                                #   in Loop: Header=BB8_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -45
	seqz	a0, a0
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	j	.LBB8_4
.LBB8_4:                                #   in Loop: Header=BB8_1 Depth=1
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	bnez	a0, .LBB8_6
	j	.LBB8_5
.LBB8_5:                                #   in Loop: Header=BB8_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB8_1
.LBB8_6:
	lw	a2, -20(s0)
	lw	a1, -16(s0)
	lw	a0, 0(a1)
	add	a0, a0, a2
	sw	a0, 0(a1)
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lw	a1, -16(s0)
	call	dec_to_int
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	get_immediate, .Lfunc_end8-get_immediate
                                        # -- End function
	.globl	rd_imm                          # -- Begin function rd_imm
	.p2align	2
	.type	rd_imm,@function
rd_imm:                                 # @rd_imm
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	addi	a1, s0, -24
	sw	a1, -28(s0)                     # 4-byte Folded Spill
	call	get_register
	lw	a1, -28(s0)                     # 4-byte Folded Reload
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -24(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	rd_imm, .Lfunc_end9-rd_imm
                                        # -- End function
	.globl	r1_r2_imm                       # -- Begin function r1_r2_imm
	.p2align	2
	.type	r1_r2_imm,@function
r1_r2_imm:                              # @r1_r2_imm
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	call	get_register
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -20(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -24(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	r1_r2_imm, .Lfunc_end10-r1_r2_imm
                                        # -- End function
	.globl	r1_imm_r2                       # -- Begin function r1_imm_r2
	.p2align	2
	.type	r1_imm_r2,@function
r1_imm_r2:                              # @r1_imm_r2
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	call	get_register
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_immediate
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -24(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -20(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end11:
	.size	r1_imm_r2, .Lfunc_end11-r1_imm_r2
                                        # -- End function
	.globl	r1_r2_r3                        # -- Begin function r1_r2_r3
	.p2align	2
	.type	r1_r2_r3,@function
r1_r2_r3:                               # @r1_r2_r3
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	sw	a3, -24(s0)
	sw	a4, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	addi	a1, s0, -28
	sw	a1, -32(s0)                     # 4-byte Folded Spill
	call	get_register
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -16(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -32(s0)                     # 4-byte Folded Reload
	lw	a2, -20(s0)
	sw	a0, 0(a2)
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	call	get_register
	lw	a1, -24(s0)
	sw	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	r1_r2_r3, .Lfunc_end12-r1_r2_r3
                                        # -- End function
	.globl	get_inst_data                   # -- Begin function get_inst_data
	.p2align	2
	.type	get_inst_data,@function
get_inst_data:                          # @get_inst_data
# %bb.0:
	addi	sp, sp, -96
	sw	ra, 92(sp)                      # 4-byte Folded Spill
	sw	s0, 88(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 96
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	sw	a0, -28(s0)
	sw	a0, -32(s0)
	sw	a0, -36(s0)
	sw	a0, -40(s0)
	sw	a0, -44(s0)
	li	a0, 1
	sw	a0, -48(s0)
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str)
	addi	a1, a1, %lo(.L.str)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_2
	j	.LBB13_1
.LBB13_1:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 3
	call	rd_imm
	li	a0, 55
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -48(s0)
	j	.LBB13_110
.LBB13_2:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.1)
	addi	a1, a1, %lo(.L.str.1)
	li	a2, 6
	call	strcmp_custom
	bnez	a0, .LBB13_4
	j	.LBB13_3
.LBB13_3:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 5
	call	rd_imm
	li	a0, 23
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -48(s0)
	j	.LBB13_109
.LBB13_4:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.2)
	addi	a1, a1, %lo(.L.str.2)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_6
	j	.LBB13_5
.LBB13_5:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -36
	li	a3, 3
	call	rd_imm
	li	a0, 111
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -48(s0)
	j	.LBB13_108
.LBB13_6:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.3)
	addi	a1, a1, %lo(.L.str.3)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_8
	j	.LBB13_7
.LBB13_7:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_imm_r2
	li	a0, 103
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -48(s0)
	j	.LBB13_107
.LBB13_8:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.4)
	addi	a1, a1, %lo(.L.str.4)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_10
	j	.LBB13_9
.LBB13_9:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -52(s0)                     # 4-byte Folded Spill
	call	r1_r2_imm
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	li	a1, 99
	sw	a1, -20(s0)
	sw	a0, -48(s0)
	j	.LBB13_106
.LBB13_10:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.5)
	addi	a1, a1, %lo(.L.str.5)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_12
	j	.LBB13_11
.LBB13_11:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -56(s0)                     # 4-byte Folded Spill
	call	r1_r2_imm
	lw	a0, -56(s0)                     # 4-byte Folded Reload
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 1
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB13_105
.LBB13_12:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.6)
	addi	a1, a1, %lo(.L.str.6)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_14
	j	.LBB13_13
.LBB13_13:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -60(s0)                     # 4-byte Folded Spill
	call	r1_r2_imm
	lw	a0, -60(s0)                     # 4-byte Folded Reload
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 4
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB13_104
.LBB13_14:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.7)
	addi	a1, a1, %lo(.L.str.7)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_16
	j	.LBB13_15
.LBB13_15:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -64(s0)                     # 4-byte Folded Spill
	call	r1_r2_imm
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	li	a1, 99
	sw	a1, -20(s0)
	li	a1, 5
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB13_103
.LBB13_16:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.8)
	addi	a1, a1, %lo(.L.str.8)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_18
	j	.LBB13_17
.LBB13_17:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 99
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	li	a0, 3
	sw	a0, -48(s0)
	j	.LBB13_102
.LBB13_18:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.9)
	addi	a1, a1, %lo(.L.str.9)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_20
	j	.LBB13_19
.LBB13_19:
	lw	a0, -12(s0)
	addi	a1, s0, -28
	addi	a2, s0, -32
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 99
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	li	a0, 3
	sw	a0, -48(s0)
	j	.LBB13_101
.LBB13_20:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.10)
	addi	a1, a1, %lo(.L.str.10)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_22
	j	.LBB13_21
.LBB13_21:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	call	r1_imm_r2
	li	a0, 3
	sw	a0, -20(s0)
	j	.LBB13_100
.LBB13_22:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.11)
	addi	a1, a1, %lo(.L.str.11)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_24
	j	.LBB13_23
.LBB13_23:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	call	r1_imm_r2
	li	a0, 3
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB13_99
.LBB13_24:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.12)
	addi	a1, a1, %lo(.L.str.12)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_26
	j	.LBB13_25
.LBB13_25:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -68(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -68(s0)                     # 4-byte Folded Reload
	li	a1, 3
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	j	.LBB13_98
.LBB13_26:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.13)
	addi	a1, a1, %lo(.L.str.13)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_28
	j	.LBB13_27
.LBB13_27:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -72(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -72(s0)                     # 4-byte Folded Reload
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -40(s0)
	j	.LBB13_97
.LBB13_28:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.14)
	addi	a1, a1, %lo(.L.str.14)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_30
	j	.LBB13_29
.LBB13_29:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 3
	sw	a4, -76(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -76(s0)                     # 4-byte Folded Reload
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	j	.LBB13_96
.LBB13_30:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.15)
	addi	a1, a1, %lo(.L.str.15)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_32
	j	.LBB13_31
.LBB13_31:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -80(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -80(s0)                     # 4-byte Folded Reload
	li	a1, 35
	sw	a1, -20(s0)
	sw	a0, -48(s0)
	j	.LBB13_95
.LBB13_32:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.16)
	addi	a1, a1, %lo(.L.str.16)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_34
	j	.LBB13_33
.LBB13_33:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -84(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -84(s0)                     # 4-byte Folded Reload
	li	a1, 35
	sw	a1, -20(s0)
	li	a1, 1
	sw	a1, -40(s0)
	sw	a0, -48(s0)
	j	.LBB13_94
.LBB13_34:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.17)
	addi	a1, a1, %lo(.L.str.17)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_36
	j	.LBB13_35
.LBB13_35:
	lw	a0, -12(s0)
	addi	a1, s0, -32
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 2
	sw	a4, -88(s0)                     # 4-byte Folded Spill
	call	r1_imm_r2
	lw	a0, -88(s0)                     # 4-byte Folded Reload
	li	a1, 35
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	sw	a0, -48(s0)
	j	.LBB13_93
.LBB13_36:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.18)
	addi	a1, a1, %lo(.L.str.18)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_38
	j	.LBB13_37
.LBB13_37:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	j	.LBB13_92
.LBB13_38:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.19)
	addi	a1, a1, %lo(.L.str.19)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_40
	j	.LBB13_39
.LBB13_39:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -40(s0)
	j	.LBB13_91
.LBB13_40:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.20)
	addi	a1, a1, %lo(.L.str.20)
	li	a2, 6
	call	strcmp_custom
	bnez	a0, .LBB13_42
	j	.LBB13_41
.LBB13_41:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 3
	sw	a0, -40(s0)
	j	.LBB13_90
.LBB13_42:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.21)
	addi	a1, a1, %lo(.L.str.21)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_44
	j	.LBB13_43
.LBB13_43:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	sw	a4, -92(s0)                     # 4-byte Folded Spill
	call	r1_r2_imm
	lw	a0, -92(s0)                     # 4-byte Folded Reload
	li	a1, 19
	sw	a1, -20(s0)
	sw	a0, -40(s0)
	j	.LBB13_89
.LBB13_44:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.22)
	addi	a1, a1, %lo(.L.str.22)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_46
	j	.LBB13_45
.LBB13_45:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	j	.LBB13_88
.LBB13_46:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.23)
	addi	a1, a1, %lo(.L.str.23)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_48
	j	.LBB13_47
.LBB13_47:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	j	.LBB13_87
.LBB13_48:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.24)
	addi	a1, a1, %lo(.L.str.24)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_50
	j	.LBB13_49
.LBB13_49:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	sw	a0, -36(s0)
	li	a0, 1
	sw	a0, -40(s0)
	j	.LBB13_86
.LBB13_50:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.25)
	addi	a1, a1, %lo(.L.str.25)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_52
	j	.LBB13_51
.LBB13_51:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	sw	a0, -36(s0)
	li	a0, 5
	sw	a0, -40(s0)
	j	.LBB13_85
.LBB13_52:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.26)
	addi	a1, a1, %lo(.L.str.26)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_54
	j	.LBB13_53
.LBB13_53:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -36
	li	a4, 4
	call	r1_r2_imm
	li	a0, 19
	sw	a0, -20(s0)
	lw	a0, -36(s0)
	srai	a1, a0, 31
	srli	a1, a1, 27
	add	a1, a0, a1
	andi	a1, a1, -32
	sub	a0, a0, a1
	addi	a0, a0, 1024
	sw	a0, -36(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 32
	sw	a0, -44(s0)
	j	.LBB13_84
.LBB13_54:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.27)
	addi	a1, a1, %lo(.L.str.27)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_56
	j	.LBB13_55
.LBB13_55:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_83
.LBB13_56:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.28)
	addi	a1, a1, %lo(.L.str.28)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_58
	j	.LBB13_57
.LBB13_57:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 32
	sw	a0, -44(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_82
.LBB13_58:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.29)
	addi	a1, a1, %lo(.L.str.29)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_60
	j	.LBB13_59
.LBB13_59:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 1
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_81
.LBB13_60:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.30)
	addi	a1, a1, %lo(.L.str.30)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_62
	j	.LBB13_61
.LBB13_61:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_80
.LBB13_62:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.31)
	addi	a1, a1, %lo(.L.str.31)
	li	a2, 5
	call	strcmp_custom
	bnez	a0, .LBB13_64
	j	.LBB13_63
.LBB13_63:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 4
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 3
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_79
.LBB13_64:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.32)
	addi	a1, a1, %lo(.L.str.32)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_66
	j	.LBB13_65
.LBB13_65:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_78
.LBB13_66:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.33)
	addi	a1, a1, %lo(.L.str.33)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_68
	j	.LBB13_67
.LBB13_67:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_77
.LBB13_68:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.34)
	addi	a1, a1, %lo(.L.str.34)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_70
	j	.LBB13_69
.LBB13_69:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 5
	sw	a0, -40(s0)
	li	a0, 32
	sw	a0, -44(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_76
.LBB13_70:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.35)
	addi	a1, a1, %lo(.L.str.35)
	li	a2, 3
	call	strcmp_custom
	bnez	a0, .LBB13_72
	j	.LBB13_71
.LBB13_71:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 2
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 6
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_75
.LBB13_72:
	lw	a0, -12(s0)
	lui	a1, %hi(.L.str.36)
	addi	a1, a1, %lo(.L.str.36)
	li	a2, 4
	call	strcmp_custom
	bnez	a0, .LBB13_74
	j	.LBB13_73
.LBB13_73:
	lw	a0, -12(s0)
	addi	a1, s0, -24
	addi	a2, s0, -28
	addi	a3, s0, -32
	li	a4, 3
	call	r1_r2_r3
	li	a0, 51
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -40(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB13_74
.LBB13_74:
	j	.LBB13_75
.LBB13_75:
	j	.LBB13_76
.LBB13_76:
	j	.LBB13_77
.LBB13_77:
	j	.LBB13_78
.LBB13_78:
	j	.LBB13_79
.LBB13_79:
	j	.LBB13_80
.LBB13_80:
	j	.LBB13_81
.LBB13_81:
	j	.LBB13_82
.LBB13_82:
	j	.LBB13_83
.LBB13_83:
	j	.LBB13_84
.LBB13_84:
	j	.LBB13_85
.LBB13_85:
	j	.LBB13_86
.LBB13_86:
	j	.LBB13_87
.LBB13_87:
	j	.LBB13_88
.LBB13_88:
	j	.LBB13_89
.LBB13_89:
	j	.LBB13_90
.LBB13_90:
	j	.LBB13_91
.LBB13_91:
	j	.LBB13_92
.LBB13_92:
	j	.LBB13_93
.LBB13_93:
	j	.LBB13_94
.LBB13_94:
	j	.LBB13_95
.LBB13_95:
	j	.LBB13_96
.LBB13_96:
	j	.LBB13_97
.LBB13_97:
	j	.LBB13_98
.LBB13_98:
	j	.LBB13_99
.LBB13_99:
	j	.LBB13_100
.LBB13_100:
	j	.LBB13_101
.LBB13_101:
	j	.LBB13_102
.LBB13_102:
	j	.LBB13_103
.LBB13_103:
	j	.LBB13_104
.LBB13_104:
	j	.LBB13_105
.LBB13_105:
	j	.LBB13_106
.LBB13_106:
	j	.LBB13_107
.LBB13_107:
	j	.LBB13_108
.LBB13_108:
	j	.LBB13_109
.LBB13_109:
	j	.LBB13_110
.LBB13_110:
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	sw	a0, 0(a1)
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	sw	a0, 4(a1)
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	sw	a0, 8(a1)
	lw	a0, -32(s0)
	lw	a1, -16(s0)
	sw	a0, 12(a1)
	lw	a0, -36(s0)
	lw	a1, -16(s0)
	sw	a0, 16(a1)
	lw	a0, -40(s0)
	lw	a1, -16(s0)
	sw	a0, 20(a1)
	lw	a0, -44(s0)
	lw	a1, -16(s0)
	sw	a0, 24(a1)
	lw	a0, -48(s0)
	lw	a1, -16(s0)
	sw	a0, 28(a1)
	lw	ra, 92(sp)                      # 4-byte Folded Reload
	lw	s0, 88(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 96
	ret
.Lfunc_end13:
	.size	get_inst_data, .Lfunc_end13-get_inst_data
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	li	a0, 0
	sw	a0, -52(s0)                     # 4-byte Folded Spill
	sw	a0, -12(s0)
	sw	a0, -16(s0)
	lui	a1, %hi(buffer)
	addi	a1, a1, %lo(buffer)
	sw	a1, -60(s0)                     # 4-byte Folded Spill
	li	a2, 40
	call	read
	mv	a1, a0
	lw	a0, -60(s0)                     # 4-byte Folded Reload
	sw	a1, -12(s0)
	addi	a1, s0, -48
	sw	a1, -56(s0)                     # 4-byte Folded Spill
	call	get_inst_data
	lw	a1, -56(s0)                     # 4-byte Folded Reload
	addi	a0, s0, -16
	call	pack
	lw	a0, -16(s0)
	call	hex_code
	lw	a0, -52(s0)                     # 4-byte Folded Reload
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end14:
	.size	main, .Lfunc_end14-main
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
.Lfunc_end15:
	.size	_start, .Lfunc_end15-_start
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"lui"
	.size	.L.str, 4

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"auipc "
	.size	.L.str.1, 7

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"jal "
	.size	.L.str.2, 5

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"jalr "
	.size	.L.str.3, 6

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"beq "
	.size	.L.str.4, 5

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"bne "
	.size	.L.str.5, 5

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"blt "
	.size	.L.str.6, 5

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"bge "
	.size	.L.str.7, 5

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"bltu "
	.size	.L.str.8, 6

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"bgeu "
	.size	.L.str.9, 6

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"lb "
	.size	.L.str.10, 4

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"lh "
	.size	.L.str.11, 4

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"lw "
	.size	.L.str.12, 4

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"lbu "
	.size	.L.str.13, 5

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	"lhu "
	.size	.L.str.14, 5

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"sb "
	.size	.L.str.15, 4

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"sh "
	.size	.L.str.16, 4

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"sw "
	.size	.L.str.17, 4

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"addi "
	.size	.L.str.18, 6

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"slti "
	.size	.L.str.19, 6

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"sltiu "
	.size	.L.str.20, 7

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"xori "
	.size	.L.str.21, 6

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"ori "
	.size	.L.str.22, 5

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"andi "
	.size	.L.str.23, 6

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"slli "
	.size	.L.str.24, 6

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"srli "
	.size	.L.str.25, 6

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"srai "
	.size	.L.str.26, 6

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	"add "
	.size	.L.str.27, 5

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"sub "
	.size	.L.str.28, 5

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"sll "
	.size	.L.str.29, 5

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"slt "
	.size	.L.str.30, 5

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"sltu "
	.size	.L.str.31, 6

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"xor "
	.size	.L.str.32, 5

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"srl "
	.size	.L.str.33, 5

	.type	.L.str.34,@object               # @.str.34
.L.str.34:
	.asciz	"sra "
	.size	.L.str.34, 5

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"or "
	.size	.L.str.35, 4

	.type	.L.str.36,@object               # @.str.36
.L.str.36:
	.asciz	"and "
	.size	.L.str.36, 5

	.type	buffer,@object                  # @buffer
	.bss
	.globl	buffer
buffer:
	.zero	40
	.size	buffer, 40

	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym strcmp_custom
	.addrsig_sym pack
	.addrsig_sym hex_code
	.addrsig_sym exit
	.addrsig_sym dec_to_int
	.addrsig_sym get_register
	.addrsig_sym get_immediate
	.addrsig_sym rd_imm
	.addrsig_sym r1_r2_imm
	.addrsig_sym r1_imm_r2
	.addrsig_sym r1_r2_r3
	.addrsig_sym get_inst_data
	.addrsig_sym main
	.addrsig_sym buffer
