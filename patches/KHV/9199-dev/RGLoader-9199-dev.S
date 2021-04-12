# RGLoader patches file
# Patches follow same format as freeBOOT:
# [4byte offset] [4byte patch count] [4byte patch]...

# Devkit 9199 patches

.set	KernelBase,		0x80000000

# use this if offset > 0x8006b200
.set    KernelCodeBase,         0x8000b400

		.globl _start
_start:

# ============================================================================
#	RGLP header
	.long 0x52474C50
# ============================================================================

# ============================================================================
#	Store the new path to xam in some space
# ============================================================================
	.long 0x800409F8 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x2F446576 # /Dev
	.long 0x6963652F # ice/
	.long 0x48617264 # Hard
	.long 0x6469736B # disk
	.long 0x302F5061 # 0/Pa
	.long 0x72746974 # rtit
	.long 0x696F6E31 # ion1
	.long 0x2F78616D # /xam
	.long 0x2E786578 # .xex
        .long 0x00000000 # /0/0/0/0
9:

# ============================================================================
#	Replace low part of new xam.xex path
# ============================================================================
	.long 0x8007CB30 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	addi %r3, %r11, 0x9F8
9:

# ============================================================================
#	Replace xam xex module load flags
# ============================================================================
	.long 0x8007CB2C - KernelCodeBase
	.long (9f - 0f) / 4
0:
	lis       %r4, 0x0
9:

# ============================================================================
#	Replace low part of new xam.xex path 
# ============================================================================
	.long 0x8007C9D8 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	addi %r4, %r11, 0x9F8
9:


#            >>>>>>>>>>GONNA HAVE TO FIND<<<<<<<<<<<
#     >>>>>>>>>>ALL THE PATCHES WE HAVE FOR RETAIL<<<<<<<<<<
#           >>>>>>>>>>IN THE DEVKIT KERNEL<<<<<<<<<<<<<
# >>>>>>>>>>AND SADLY, NOT THE KERNEL FROM INSIDE SDK<<<<<<<<<
#          >>>>>>>>>>BUT ONE FROM DEV NAND<<<<<<<<<<<<
# ============================================================================
	.long 0xffffffff
	.end
# ============================================================================
