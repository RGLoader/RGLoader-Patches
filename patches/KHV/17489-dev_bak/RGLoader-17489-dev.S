# RGLoader patches file
# Patches follow same format as XeBuild, but with RGLP at start
# When used with RGLoader patch engine, refer to the ini for patches offset in NAND
# [4byte offset] [4byte patch count] [4byte patch]...

# Devkit 17489 patches

.include "..\\..\\macros.S"

		.globl _start
_start:

# ============================================================================
#	RGLP header
	.long 0x52474C50  #"RGLP" 
# ============================================================================

.print "  --- COMPILING PATCHES FOR 17489-DEVKIT ---"

.ifdef SYSROOTHDD
	.print "  --- SYSTEM ROOT MAPPED TO HDD ---"
	.include "RGLoader-17489_sysroot_hdd.S"
.endif

.ifdef NOFCRT
	.print "  --- DISABLING FCRT ---"
	.include "RGLoader-17489_nofcrt.S"
.endif

.ifdef kd_1retry
	.print "  --- KD retries patched to 1 ---"
	.include "RGLoader-17489_kd_1retry.S"
.endif

.ifdef HVPEEKPOKE
	.print "  --- Adding HvxPeekPoke ---"
	.include "RGLoader-17489_HvxPeekPoke.S"
.endif

.ifdef NOMEMPROT
	.print "  --- Disabling Mem Protection ---"
	.include "RGLoader-17489_memprot.S"
.endif

.ifdef STATICSEED
	.print "  --- Using static seed ---"
	.include "RGLoader-17489_static_seed.S"
.endif

#.ifdef HEAP
	.print "  --- Ignoring heap errors ---"
	.include "RGLoader-17489_ignoreHeapErr.S"
#.endif



# ============================================================================
#       Test patch to fix wifi
# ============================================================================
#	KMAKEPATCH 0x801049A8  //17349
#0:
#	nop
#9:


# ============================================================================
#       Retail XEX2 AES key   
# note: should be static
# ============================================================================
	MAKEPATCH 0x000000F0
0:
	.long 0x20B185A5
	.long 0x9D28FDC3
	.long 0x40583FBB
	.long 0x0896BF91
9:

# ============================================================================
# 	Enable retail xex decryption
# ============================================================================
	MAKEPATCH 0x00029C4C
0:
	b       0x10   #;//skip signature check for retail consoles. (allow patched xex)
9:
	MAKEPATCH 0x00029C70
0:
	li      %r4,  0xF0   #;//patch XexAes key to retail one at 0xF0
9:

# ============================================================================
#	HV jump to flag fixer
# ============================================================================
	MAKEPATCH 0x000018B8 
0:
	ba  0xB188      #(CHANGE THE ADDR TO FLAG FIXING FUNCTIONS ADDR) ^
9:

# ============================================================================
#	HV Flag fixing function
# note: store at empty space
# ============================================================================
	MAKEPATCH 0x0000B188 
0:
	lhz     %r3, 0x6(%r0)  # load flag byte into r3
	li      %r4, 0x21
	andc    %r3, %r3, %r4 # clear bit
	sth     %r3, 0x6(%r0)      # store new flag
	cmpldi   %r21,  0    # do what we patched
	ba      0x18BC  #CHANGE THIS ADDR TO JUMP BACK
9:

# ============================================================================
#       HvxSecuity Functions  (sets machine acct flags)
# ============================================================================
	MAKEPATCH 0x00006C58 #;//HvxSecurityGetActivated
0:
	li     %r3, 0
	blr
9:
	MAKEPATCH 0x00006B98 #;//HvxSecurityGetDetected
0:
	li     %r3, 0
	blr
9:
	MAKEPATCH 0x00006BE8 #;//HvxSecuritySetActivated
0:
	li     %r3, 0
	blr
9:
	MAKEPATCH 0x00006B00 #;//HvxSecuritySetDetected
0:
	li     %r3, 0
	blr
9:
	MAKEPATCH 0x00006CA8 #;//HvxSecuritySetStat
0:
	li     %r3, 0
	blr
9:
#	MAKEPATCH 0x00006D18 #;//HvxGetProtectedFlags (might not be needed)
#0:
#	li  %r3, 0
#	blr
#9:
#	MAKEPATCH 0x00006D28 #;//HvxSetProtectedFlag (might not be needed)
#0:
#	li  %r3, 0
#	blr
#9:

# ============================================================================
#  KV check patches - Hvxkeyshmacsha
# ============================================================================
	MAKEPATCH 0x00004F2C  # First check on
0:
	nop
9:

# ============================================================================
#  HvpKeysVerifyKeyvault
# ============================================================================
	MAKEPATCH 0x000035B0  # First check on
0:
	li  %r3, 0
	blr
9:


# ============================================================================
#	HV Patch Console Seq check
# ============================================================================
	MAKEPATCH 0x00007214
0:
	nop  
9:
# ============================================================================
#	HV Flash Bldr Check
# ============================================================================
	MAKEPATCH 0x000074D8
0:
	nop  
9:
# ============================================================================
#	HV Flash Bldr Check
# ============================================================================
	MAKEPATCH 0x00007328
0:
	b  0x88
9:

	MAKEPATCH 0x00007504
0:
	nop
9:


#============================================================================
#	HV patch jump
# ============================================================================
	MAKEPATCH 0x000071B8
0:
	li %r3, 0 
9:

	MAKEPATCH 0x0000700C
0:
	li %r3, 1
9:

	MAKEPATCH 0x0000723C
0:
	nop
9:


# ============================================================================
#       Patch XEX flag
# ============================================================================

#	MAKEPATCH 0x000072F0
#0:
#	li %r3, 0
#9:

#	MAKEPATCH 0x000076A0
#0:
#	li %r4, 0x8
#	li %r3, 0
#9:

#============================================================================
#	HV Patch blow fuses              
# ============================================================================
	MAKEPATCH 0x0000A1C8 
0:
	li %r3, 1 
	blr
9:


#=============================================================================
#	Retail XEX Loading            
# ============================================================================
	MAKEPATCH 0x0000A1F4
0:
	nop
9:


# ============================================================================
#	Remove fcrt.bin hash check
# ============================================================================
	MAKEPATCH 0x000264F0
0:
	li    %r3, 1
9:
	MAKEPATCH 0x000265C8
0:
	nop
9:



# ============================================================================
#       DVDAuth2 retail key
# note: should stay constant
# ============================================================================
	MAKEPATCH 0x00010d08
0:
	.long 0xD1E3B33A
	.long 0x6C1EF770
	.long 0x5F6DE93B
	.long 0xB6C0DC71
9:

# ============================================================================
#	HvxDvdAuthRecordXControl  Remove signature check
# ============================================================================
#	MAKEPATCH 0x00026C04 
#0:
#	li  %r3, 1
#9:

# ============================================================================
#       HV DAE 
# ============================================================================
	MAKEPATCH 0x00029018
0:
	li    %r3, 0
9:
	MAKEPATCH 0x00028D58
0:
	li    %r3, 0
9:
	MAKEPATCH 0x00029018
0:
	li    %r3, 0
9:




# ============================================================================
#	HvxSetImagePageTableEntry memory addr check
# ============================================================================
	MAKEPATCH 0x00029E28
0:
	nop
9:


# ============================================================================
#	HvxCreateImageMapping hash check
# ============================================================================
	MAKEPATCH 0x0002C82C
0:
	b  0x10
9:

# ============================================================================
#	HvxCreateImageMapping HV XEX region check 
# ============================================================================
	MAKEPATCH 0x0002C924
0:
	nop
9:

# ============================================================================
#	HvxExpansionInstall sig check
# ============================================================================
	MAKEPATCH 0x00030BAC
0:
	nop
9:
	MAKEPATCH 0x00030BB8
0:
	nop
9:

	MAKEPATCH 0x00020680
0:
	li       %r3,  1
	blr
9:
	MAKEPATCH 0x00030C24
0:
	li       %r3,  0
9:
	MAKEPATCH 0x00030BEC
0:
	nop
9:

# ============================================================================
#	HvxExpansionInstall hash check
# ============================================================================
	MAKEPATCH 0x00030C2C 
0:
	nop
9:


#------------
#=============================================================================
# Kernel patches
#=============================================================================
#------------

# ============================================================================
#       Fix controller unsync bug that still exists..  
# ============================================================================
#	KMAKEPATCH 0x801279BC
#0:
#	li      %r11, 9
#9:

# ============================================================================
#	Patch XEX Restrictions check
# ============================================================================
	KMAKEPATCH 0x800A2F48
0:
	li     %r3,  1
9:

	KMAKEPATCH 0x800A0FAC
0:
	b   0x18
9:

# ============================================================================
#	XexpVerifyXexHeaders
# ============================================================================
	KMAKEPATCH 0x800A0994
0:
	li   %r3,  1 
9:
	KMAKEPATCH 0x800A09F0
0:
	nop
9:


# ============================================================================
#	XexpVerifyMinimumVersion
# ============================================================================
	KMAKEPATCH 0x800A17B0
0:
	li   %r3,  0
9:

# ============================================================================
#	XexpLoadFile
# ============================================================================
	KMAKEPATCH 0x8009EE78
0:
	li   %r3,  1
9:

# ============================================================================
#	SataCdRomActivateHCDFRuntimePatch  
#       patch out blacklisted drives for XGD3 discs (zero ExpUpdateModule)
# ============================================================================
#	KMAKEPATCH 0x800C51A0
#0:
#	li   %r3, 1
#	blr
#9:


# ============================================================================
#   SataCdRomAuthenticationExSequence
# ============================================================================
#	KMAKEPATCH 0x800C57E0
#0:
#	b   0x30
#9:

#	KMAKEPATCH 0x800C581C
#0:
#	nop
#9:



# ============================================================================
#	SataCdRomVerifyDVDX2AuthoringSignature
# ============================================================================
#	KMAKEPATCH 0x800C3788
#0:
#	li   %r3, 1
#9:

# ============================================================================
#	SataDiskAuthenticateDevice
# ============================================================================
	KMAKEPATCH 0x801B0C98
0:
	li   %r3, 1
9:

# ============================================================================
#	XeKeysVerifyRSASignature
# ============================================================================
	KMAKEPATCH 0x8014A128
0:
	nop
9:

	KMAKEPATCH 0x8014A028
0:
	li    %r3, 1
	blr
9:

	KMAKEPATCH 0x8014A15C
0:
	li   %r3, 1
9:

# ============================================================================
#	XeKeysVerifyPIRSSignature
# ============================================================================
	KMAKEPATCH 0x8014A1FC
0:
	li    %r3, 1
9:

# ============================================================================
#	XeKeysConsoleSignatureVerification
#       patch flag check  & always return 1
# ============================================================================
	KMAKEPATCH 0x8014C35C
0:
	li   %r3, 1
9:
	KMAKEPATCH 0x8014C364
0:
	li   %r3, 1
9:

# ============================================================================
#	XexDeltaDecompressHeaders
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A6494
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpLoadCompressedImage
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A5BDC
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpLoadDeltaCompressedImage
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A628C
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpVerifyMedia Type
# ============================================================================
	KMAKEPATCH 0x8009EEDC
0:
	li   %r3,  1
9:

# ============================================================================
#	VdpDelayExecution
# ============================================================================
	KMAKEPATCH 0x800F4B2C
0:
	nop
9:
	KMAKEPATCH 0x800F4B38
0:
	nop
9:

# ============================================================================
#	XexpVerifyDeviceId 
#       always return 0
# ============================================================================
	KMAKEPATCH 0x800A0DB8
0:
	li   %r3, 0
9:
	KMAKEPATCH 0x800A0FC4
0:
	li   %r3, 0
9:

# ============================================================================
#	XexpTranslateAndVerifyBoundPath
#       always return 1
# ============================================================================
	KMAKEPATCH 0x8009EE78
0:
	li   %r3, 1
9:


# ============================================================================
#	StfsMapNewBlock hash mismatch
# ============================================================================
	KMAKEPATCH 0x800E22CC
0:
	b    0x34  #patch to unconditional branch
9:

# ============================================================================
#	StfsNonCachedRead
#       remove hash check (nop out bne)
# ============================================================================
	KMAKEPATCH 0x800E45E0
0:
	nop
9:

# ============================================================================
#	SvodMapNewBlock hash mismatch 
# ============================================================================
	KMAKEPATCH 0x80193BE8
0:
	b 0x30  #patch to unconditional branch
9:

# ============================================================================
#	SvodPartiallyCachedRead hash mismatch
# ============================================================================
	KMAKEPATCH 0x80193FFC
0:
	nop
9:

# ============================================================================
#	XeKeysSecurityLoadSettings - ignore
# ============================================================================
	KMAKEPATCH 0x800816C0
0:
	nop
9:

# ============================================================================
#	Load RGLoader.xex after XAM
# ============================================================================

.set ldBranchAddr, 0x80081AC8
.set loaderFuncAddr, 0x801BBF94 #;//empty space
.set XexLoadImage, 0x800A3F08


	KMAKEPATCH loaderFuncAddr
0:
	.set strPath, (loaderFuncAddr + 0x20)
	
	lis   %r11, strPath@h
	ori  %r3, %r11, strPath@l
	li %r4, 8
	li %r5, 0
	li %r6, 0
	#KMAKEBRANCHL XexLoadImage 
	KMAKEBRANCH XexLoadImage

	li  %r3, 0
	KMAKEBRANCH (ldBranchAddr+4) 
	
1:
	.string "\\SystemRoot\\RGLoader.xex\0"
2:
	.align 2
9:


	KMAKEPATCH ldBranchAddr
0:
	KMAKEBRANCHL loaderFuncAddr
9:

#.set xexLoadBranchAddr, 0x800A3E24
#.set monitorFuncAddr, 0x801CDC00 #;//empty space
#.set xamStrPath, 0x801CDD00 #;//empty space
#.set rglStrPath, 0x801CDD30 #;//empty space
#.set RtlCompareMemory, 0x800B1BF0 
#.set fIsBlocking, 0x801CDD70 #;//Boolean to block xex loading

#	KMAKEPATCH fIsBlocking
#0:
#	.long   0
#9:

#	KMAKEPATCH xexLoadBranchAddr
#0:
#	KMAKEBRANCHL monitorFuncAddr
#9:

#	KMAKEPATCH monitorFuncAddr
#0:
	##mr       %r31, %r3  #;//Save our ptr to the string
	##li       %r5, 7  #;//Length
	##lis      %r4, xamStrPath@h
	##ori      %r4, %r4, xamStrPath@l
	##KMAKEBRANCHL RtlCompareMemory 
	##cmpwi    %r3, 7
	
	#li       %r5, 24  #;//Length
	#lis      %r4, rglStrPath@h
	#ori      %r4, %r4, rglStrPath@l
	##mr       %r3, %r31
	#KMAKEBRANCHL RtlCompareMemory 
	#cmpwi    %r3, 24
	#li       %r3, 1
	#bne      checkBlock
	#lis      %r6, fIsBlocking@h
	#ori      %r6, %r6, fIsBlocking@l
	#stw      %r3, 0(%r6)
	#b        bailOut
	
#checkBlock:
	#lis      %r6, fIsBlocking@h
	#ori      %r6, %r6, fIsBlocking@l
	#lwz      %r3, 0(%r6)
	#cmpwi    %r3, 0
	#bne      checkBlock
	
#bailOut:
	#cmplwi    cr6, %r29, 0
	#KMAKEBRANCH (xexLoadBranchAddr+4) 
#9:


	#KMAKEPATCH xamStrPath
#0:
	#.string "xam.xex\0"
	#.align 2
#9:

#	KMAKEPATCH rglStrPath
#0:
#	.string "\\SystemRoot\\RGLoader.xex\0"
#	.align 2
#9:

# ============================================================================
	.long 0xffffffff
	.end
# ============================================================================
