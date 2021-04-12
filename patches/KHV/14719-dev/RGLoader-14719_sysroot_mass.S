
# ============================================================================
#	Remap SystemRoot after initialization  (not working yet)
# ============================================================================

.set UsbDevString, 0x801B4000 #empty space
.set SysRootString, 0x8004056C

.set ResetSysRootFunction, 0x801AA000 #empty space

.set ResetSysRootHook, 0x80081950

.set ObCreateSymbolicLink, 0x800B4930
.set ObDeleteSymbolicLink, 0x800B49A0


	KMAKEHOOK ResetSysRootHook ResetSysRootFunction

	
	KMAKEPATCH ResetSysRootFunction
0:
	mfspr   %r12, lr
	
	#delete old systemroot
	lis     %r11, SysRootString@h
	addi    %r3, %r11, SysRootString@l
	KMAKEBRANCHL ObDeleteSymbolicLink
	
	#remap to new
	lis     %r11, SysRootString@h
	addi    %r3, %r11, SysRootString@l
	lis     %r11, UsbDevString@h
	addi    %r4, %r11, UsbDevString@l
	KMAKEBRANCHL ObCreateSymbolicLink
	
	li      %r3, 0x79  #do what we patched
	KMAKEBRANCH ResetSysRootHook+0x4
	#mtspr   lr, %r12
	#blr
9:


# ============================================================================
#	Set SystemRoot to USB Thumb Drive
# ============================================================================
	KMAKEPATCH UsbDevString
0:
	.set strLen,  (2f - 1f)
	.set RootPatch, RealAddr
	
	.word strLen-2  #//length
	.word strLen-1  #//maxlength
	
	.long (RealAddr+8) #//ptr to string
	
1:
	.string "\\Device\\Mass0\\Filesystems\\14719-dev\0"
2:
	.align 2
9:



#	KMAKEPATCH 0x8008102C 
#0:
#	nop              #  nop out the hardware flags check
#	lis   %r11, RootPatch@h
#	ori  %r4, %r11, RootPatch@l
#9:
