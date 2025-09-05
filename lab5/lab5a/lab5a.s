	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.file	"lab5a.c"
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
	.globl	conv_char_to_int                # -- Begin function conv_char_to_int
	.p2align	2
	.type	conv_char_to_int,@function
conv_char_to_int:                       # @conv_char_to_int
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	li	a1, 1
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	lbu	a0, 0(a0)
	li	a1, 43
	bne	a0, a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:
	li	a0, 1
	sw	a0, -24(s0)
	j	.LBB2_3
.LBB2_2:
	li	a0, 1
	sw	a0, -24(s0)
	li	a0, -1
	sw	a0, -20(s0)
	j	.LBB2_3
.LBB2_3:
	lw	a0, -24(s0)
	sw	a0, -28(s0)
	j	.LBB2_4
.LBB2_4:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -28(s0)
	li	a0, 4
	blt	a0, a1, .LBB2_7
	j	.LBB2_5
.LBB2_5:                                #   in Loop: Header=BB2_4 Depth=1
	lw	a0, -12(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	sw	a0, -32(s0)
	lw	a0, -16(s0)
	li	a1, 10
	mul	a0, a0, a1
	lw	a1, -32(s0)
	add	a0, a0, a1
	sw	a0, -16(s0)
	j	.LBB2_6
.LBB2_6:                                #   in Loop: Header=BB2_4 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB2_4
.LBB2_7:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	mul	a0, a0, a1
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end2:
	.size	conv_char_to_int, .Lfunc_end2-conv_char_to_int
                                        # -- End function
	.globl	mask_fifth                      # -- Begin function mask_fifth
	.p2align	2
	.type	mask_fifth,@function
mask_fifth:                             # @mask_fifth
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 2047
	sw	a0, -24(s0)
	lw	a1, -12(s0)
	srai	a0, a1, 31
	lw	a2, -24(s0)
	lw	a3, -20(s0)
	and	a0, a0, a3
	and	a1, a1, a2
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	srli	a2, a1, 11
	slli	a0, a0, 21
	or	a0, a0, a2
	slli	a1, a1, 21
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -32(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	mask_fifth, .Lfunc_end3-mask_fifth
                                        # -- End function
	.globl	mask_fourth                     # -- Begin function mask_fourth
	.p2align	2
	.type	mask_fourth,@function
mask_fourth:                            # @mask_fourth
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 31
	sw	a0, -24(s0)
	lw	a1, -12(s0)
	srai	a0, a1, 31
	lw	a2, -24(s0)
	lw	a3, -20(s0)
	and	a0, a0, a3
	and	a1, a1, a2
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	srli	a2, a1, 16
	slli	a0, a0, 16
	or	a0, a0, a2
	slli	a1, a1, 16
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -32(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	mask_fourth, .Lfunc_end4-mask_fourth
                                        # -- End function
	.globl	mask_third                      # -- Begin function mask_third
	.p2align	2
	.type	mask_third,@function
mask_third:                             # @mask_third
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 31
	sw	a0, -24(s0)
	lw	a1, -12(s0)
	srai	a0, a1, 31
	lw	a2, -24(s0)
	lw	a3, -20(s0)
	and	a0, a0, a3
	and	a1, a1, a2
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	srli	a2, a1, 21
	slli	a0, a0, 11
	or	a0, a0, a2
	slli	a1, a1, 11
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -32(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end5:
	.size	mask_third, .Lfunc_end5-mask_third
                                        # -- End function
	.globl	mask_second                     # -- Begin function mask_second
	.p2align	2
	.type	mask_second,@function
mask_second:                            # @mask_second
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 255
	sw	a0, -24(s0)
	lw	a1, -12(s0)
	srai	a0, a1, 31
	lw	a2, -24(s0)
	lw	a3, -20(s0)
	and	a0, a0, a3
	and	a1, a1, a2
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	lw	a1, -32(s0)
	srli	a2, a1, 29
	slli	a0, a0, 3
	or	a0, a0, a2
	slli	a1, a1, 3
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -32(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	mask_second, .Lfunc_end6-mask_second
                                        # -- End function
	.globl	mask_first                      # -- Begin function mask_first
	.p2align	2
	.type	mask_first,@function
mask_first:                             # @mask_first
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 7
	sw	a0, -24(s0)
	lw	a1, -12(s0)
	srai	a0, a1, 31
	lw	a2, -24(s0)
	lw	a3, -20(s0)
	and	a0, a0, a3
	and	a1, a1, a2
	sw	a1, -32(s0)
	sw	a0, -28(s0)
	lw	a0, -32(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	mask_first, .Lfunc_end7-mask_first
                                        # -- End function
	.globl	pack                            # -- Begin function pack
	.p2align	2
	.type	pack,@function
pack:                                   # @pack
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
	sw	a5, -32(s0)
	lw	a2, -16(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a2, -20(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a2, -24(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a2, -28(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	a2, -32(s0)
	lw	a1, -12(s0)
	lw	a0, 0(a1)
	or	a0, a0, a2
	sw	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	pack, .Lfunc_end8-pack
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
	j	.LBB9_1
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -36(s0)
	li	a1, 2
	blt	a0, a1, .LBB9_7
	j	.LBB9_2
.LBB9_2:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -28(s0)
	andi	a0, a0, 15
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	li	a1, 10
	bltu	a0, a1, .LBB9_4
	j	.LBB9_3
.LBB9_3:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 55
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB9_5
.LBB9_4:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -32(s0)
	addi	a0, a0, 48
	lw	a2, -36(s0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB9_5
.LBB9_5:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -28(s0)
	srli	a0, a0, 4
	sw	a0, -28(s0)
	j	.LBB9_6
.LBB9_6:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -36(s0)
	addi	a0, a0, -1
	sw	a0, -36(s0)
	j	.LBB9_1
.LBB9_7:
	li	a0, 1
	addi	a1, s0, -23
	li	a2, 11
	call	write
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end9:
	.size	hex_code, .Lfunc_end9-hex_code
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
.Lfunc_end10:
	.size	exit, .Lfunc_end10-exit
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
.Lfunc_end11:
	.size	_start, .Lfunc_end11-_start
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
	lui	a0, %hi(buffer)
	addi	a1, a0, %lo(buffer)
	sw	a1, -64(s0)                     # 4-byte Folded Spill
	li	a0, 0
	sw	a0, -60(s0)                     # 4-byte Folded Spill
	li	a2, 30
	call	read
	lw	a1, -60(s0)                     # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	sw	a2, -12(s0)
	sw	a1, -16(s0)
	call	conv_char_to_int
	sw	a0, -20(s0)
	lw	a0, -20(s0)
	call	mask_first
	mv	a1, a0
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	sw	a1, -24(s0)
	addi	a0, a0, 6
	call	conv_char_to_int
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	call	mask_second
	mv	a1, a0
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	sw	a1, -32(s0)
	addi	a0, a0, 12
	call	conv_char_to_int
	sw	a0, -36(s0)
	lw	a0, -36(s0)
	call	mask_third
	mv	a1, a0
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	sw	a1, -40(s0)
	addi	a0, a0, 18
	call	conv_char_to_int
	sw	a0, -44(s0)
	lw	a0, -44(s0)
	call	mask_fourth
	mv	a1, a0
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	sw	a1, -48(s0)
	addi	a0, a0, 24
	call	conv_char_to_int
	sw	a0, -52(s0)
	lw	a0, -52(s0)
	call	mask_fifth
	sw	a0, -56(s0)
	lw	a1, -24(s0)
	lw	a2, -32(s0)
	lw	a3, -40(s0)
	lw	a4, -48(s0)
	lw	a5, -56(s0)
	addi	a0, s0, -16
	call	pack
	lw	a0, -16(s0)
	call	hex_code
	lw	a0, -60(s0)                     # 4-byte Folded Reload
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end12:
	.size	main, .Lfunc_end12-main
                                        # -- End function
	.type	buffer,@object                  # @buffer
	.bss
	.globl	buffer
buffer:
	.zero	30
	.size	buffer, 30

	.ident	"Ubuntu clang version 18.1.3 (1ubuntu1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym conv_char_to_int
	.addrsig_sym mask_fifth
	.addrsig_sym mask_fourth
	.addrsig_sym mask_third
	.addrsig_sym mask_second
	.addrsig_sym mask_first
	.addrsig_sym pack
	.addrsig_sym hex_code
	.addrsig_sym exit
	.addrsig_sym main
	.addrsig_sym buffer
