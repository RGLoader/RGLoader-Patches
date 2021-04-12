
# ============================================================================
#	Set SystemRoot to HDD
# ============================================================================
	KMAKEPATCH 0x80040AC8 
0:
	.set strLen,  (2f - 1f)
	.set RootPatch, RealAddr
	
	.word strLen-2  #//length
	.word strLen-1  #//maxlength
	
	.long (RealAddr+8) #//ptr to string
	
1:
	.string "\\Device\\Harddisk0\\Partition1\\Filesystems\\14699-dev\0"
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
#	Add new error code e90  (failed to setup systemroot)
# ============================================================================

.set  VdDisplayFatalError,   0x800EB748 - KBASE 

.set  SysRootPanicFunction,  0x8019CF00       #empty space

#patch all assertions in InitSystemRoot
	KMAKEHOOKL 0x80081090 SysRootPanicFunction
	KMAKEHOOKL 0x800810B0 SysRootPanicFunction
	KMAKEHOOKL 0x800810DC SysRootPanicFunction
	KMAKEHOOKL 0x80081158 SysRootPanicFunction


# ============================================================================
#	System root panic function
# ============================================================================

	KMAKEPATCH SysRootPanicFunction
0:
	
	lis   %r3,  1
	ori   %r3, %r3, 0x225A
	BLMAKEBRANCH VdDisplayFatalError
9:

