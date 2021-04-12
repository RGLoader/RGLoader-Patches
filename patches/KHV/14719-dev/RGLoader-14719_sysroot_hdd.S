
# ============================================================================
#	Set SystemRoot to HDD
# ============================================================================
	KMAKEPATCH 0x80055F40
0:
	.set strLen,  (2f - 1f)
	.set RootPatch, RealAddr
	
	.word strLen-2  #//length
	.word strLen-1  #//maxlength
	
	.long (RealAddr+8) #//ptr to string
	
1:
	.string "\\Device\\Harddisk0\\Partition1\\Filesystems\\14719-dev\0"
2:
	.align 2
9:



	KMAKEPATCH 0x8008102C 
0:
	nop              #  nop out the hardware flags check
	lis   %r11, RootPatch@h
	ori  %r4, %r11, RootPatch@l
9:



# ============================================================================
#	System root panic function 
# ============================================================================

.set  SysRootPanicFunction,  0x801ADF10       #empty space

.set  SysRootRecovery,  0x80081050 


	KMAKEPATCH 0x80081090
0:
	KMAKEBRANCH SysRootRecovery
9:

	KMAKEPATCH 0x800810B0
0:
	KMAKEBRANCH SysRootRecovery
9:

	KMAKEPATCH 0x800810DC
0:
	KMAKEBRANCH SysRootRecovery
9:

	KMAKEPATCH 0x80081158
0:
	KMAKEBRANCH SysRootRecovery
9:



