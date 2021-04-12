# RGLoader patches file
# Patches follow same format as XeBuild, but with RGLP at start
# When used with RGLoader patch engine, refer to the ini for patches offset in NAND
# [4byte offset] [4byte patch count] [4byte patch]...

# Devkit 16547 patches

.include "macros.S"

		.globl _start
_start:

# ============================================================================
#	RGLP header
	.long 0x52474C50  #"RGLP" 
# ============================================================================

.ifdef disable_bootanim
	.print "  --- BOOTANIM DISABLED ---"
	.include "RGLoader-17150_disable_bootanim.S"
.endif

.ifdef NOFCRT
	.print "  --- FCRT DISABLED ---"
	.include "RGLoader-17150_nofcrt.S"
.endif

.ifdef NOMU
	.print "  --- MU DISABLED ---"
	.include "RGLoader-17150_noMU.S"
.endif

.ifdef NOSHADOWBOOT
	.print "  --- SHADOWBOOT DISABLED ---"
	.include "RGLoader-17150_noshadowboot.S"
.endif

.ifdef SYSROOTHDD
	.print "  --- SYSTEM ROOT MAPPED TO HDD ---"
	.include "RGLoader-17150_sysroot_hdd.S"
.endif

.ifdef kd_1retry
	.print "  --- KD retries patched to 1 ---"
	.include "RGLoader-17150_kd_1retry.S"
.endif

.ifdef HVPEEKPOKE
	.print "  --- Adding HvxPeekPoke ---"
	.include "RGLoader-17150_HvxPeekPoke.S"
.endif

.ifdef NOMEMPROT
	.print "  --- Disabling Mem Protection ---"
	.include "RGLoader-17150_memprot.S"
.endif

#.ifdef UARTPOST
#	.print "  --- Enabling POST through UART ---"
#	.include "RGLoader-17150-uartPOST.S"
#.endif


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
#	HV jump to flag fixer
# ============================================================================
	MAKEPATCH 0x000018B8 
0:
	ba  0xB188      #(CHANGE THE ADDR TO FLAG FIXING FUNCTIONS ADDR) ^
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
	MAKEPATCH 0x00006D08
0:
	li  %r3, 0
	blr
9:
	MAKEPATCH 0x00006C48
0:
	li  %r3, 0
	blr
9:

# ============================================================================
#  KV check patches - Hvxkeyshmacsha
# ============================================================================
	KMAKEPATCH 0x80004F2C  # First check on
0:
	nop
9:

# ============================================================================
#	HV Patch Console Seq check
# ============================================================================
	KMAKEPATCH 0x80007214
0:
	nop  
9:

#============================================================================
#	HV patch jump
# ============================================================================
	KMAKEPATCH 0x800071B8
0:
	li %r3, 0 
9:

	KMAKEPATCH 0x8000723C
0:
	nop
9:

# ============================================================================
#       Patch XEX flag
# ============================================================================

	KMAKEPATCH 0x800072F0
0:
	li %r3, 0
9:

	KMAKEPATCH 0x800076A0
0:
	li %r4, 0x8
	li %r3, 0
9:

#============================================================================
#	HV Patch blow fuses              
# ============================================================================
	KMAKEPATCH 0x8000A1C8 
0:
	li %r3, 1 
	blr
9:

# ============================================================================
#       DVDAuth2 retail key
# note: should stay constant
# ============================================================================
	MAKEPATCH 0x10d08
0:
	.long 0xD1E3B33A
	.long 0x6C1EF770
	.long 0x5F6DE93B
	.long 0xB6C0DC71
9:

# ============================================================================
#	HvxDvdAuthRecordXControl  Remove signature check
# ============================================================================
	KMAKEPATCH 0x80026C04 
0:
	li  %r3, 1
9:

# ============================================================================
#	Remove fcrt.bin hash check
# ============================================================================
	MAKEPATCH 0x000264F0
0:
	li    %r3, 1
9:

# ============================================================================
#       HV DAE 
# ============================================================================
	KMAKEPATCH 0x80029018
0:
	li    %r3, 0
9:

# ============================================================================
#	HvxSetImagePageTableEntry memory addr check
# ============================================================================
	KMAKEPATCH 0x80029E28
0:
	nop
9:

# ============================================================================
#	HvxCreateImageMapping hash check
# ============================================================================
	KMAKEPATCH 0x8002C804
0:
	b  0x10
9:

# ============================================================================
#	HvxCreateImageMapping HV XEX region check 
# ============================================================================
	KMAKEPATCH 0x8002C8FC
0:
	nop
9:

# ============================================================================
#	HvxExpansionInstall sig check
# ============================================================================
	KMAKEPATCH 0x80030BAC
0:
	nop
9:
	KMAKEPATCH 0x80030BEC
0:
	nop
9:

# ============================================================================
#	HvxExpansionInstall hash? (uses memcmp) check
# ============================================================================
	KMAKEPATCH 0x80030C2C 
0:
	nop
9:


#------------
#=============================================================================
# Kernel patches
#=============================================================================
#------------


# ============================================================================
#       Fix controller unsync bug that still exists in 16537  
# ============================================================================
	KMAKEPATCH 0x80128544
0:
	ori		%r9, %r9, 8
	stb		%r9, 0x6F(%r31)
9:

# ============================================================================
#	Patch XEX Restrictions check
# ============================================================================
	KMAKEPATCH 0x800A2F58
0:
	li     %r3,  1
9:

	KMAKEPATCH 0x800A0FBC
0:
	b   0x18
9:

# ============================================================================
#	XexpVerifyXexHeaders
#       patch out memcmp of sha
# ============================================================================
	KMAKEPATCH 0x800A09F8
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpVerifyXexHeaders  (patch out XeKeysVerifyPIRSSignature)
# ============================================================================
	KMAKEPATCH 0x800A09A4
0:
	li   %r3,  1 
9:

# ============================================================================
#	XexpVerifyMinimumVersion
# ============================================================================
	KMAKEPATCH 0x800A17C0
0:
	li   %r3,  1
9:

# ============================================================================
#	XexpLoadFile
# ============================================================================
	KMAKEPATCH 0x800A30BC
0:
	li   %r3,  1
9:

# ============================================================================
#	XeKeysVerifyRSASignature
# ============================================================================
	KMAKEPATCH 0x80149DD8
0:
	nop
9:
	KMAKEPATCH 0x80149E0C
0:
	li   %r3, 1
9:

# ============================================================================
#	XeKeysVerifyPIRSSignature
# ============================================================================
	KMAKEPATCH 0x80149EAC
0:
	li    %r3, 1
9:

# ============================================================================
#	XeKeysConsoleSignatureVerification
#       patch flag check  & always return 1
# ============================================================================
	KMAKEPATCH 0x8014C01C
0:
	li   %r3, 1
9:
	KMAKEPATCH 0x8014C024
0:
	li   %r3, 1
9:

# ============================================================================
#	XexDeltaDecompressHeaders
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A64A4
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpLoadCompressedImage
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A5BEC
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpLoadDeltaCompressedImage
#       remove hash check
# ============================================================================
	KMAKEPATCH 0x800A629C
0:
	li   %r3, 0x14
9:

# ============================================================================
#	XexpVerifyMedia Type
# ============================================================================
	KMAKEPATCH 0x8009EEEC
0:
	li   %r3,  1
9:

# ============================================================================
#	XexpVerifyDeviceId 
#       always return 0
# ============================================================================
	KMAKEPATCH 0x800A0DC8
0:
	li   %r3, 0
9:

# ============================================================================
#	XexpTranslateAndVerifyBoundPath
#       always return 1
# ============================================================================
	KMAKEPATCH 0x8009EE88
0:
	li   %r3, 1
9:

# ============================================================================
#	SataCdRomActivateHCDFRuntimePatch  
#       patch out blacklisted drives for XGD3 discs (zero ExpUpdateModule)
# ============================================================================
	KMAKEPATCH 0x800C4FA0
0:
	li   %r11, 0
9:
	KMAKEPATCH 0x800C4FC8
0:
	li   %r11, 0
9:

# ============================================================================
#   SataCdRomAuthenticationExSequence
# ============================================================================
	KMAKEPATCH 0x800C55A0
0:
	b   0x38
9:

# ============================================================================
#	SataCdRomVerifyDVDX2AuthoringSignature
# ============================================================================
	KMAKEPATCH 0x800C3540
0:
	li   %r3, 1
9:

# ============================================================================
#	SataDiskAuthenticateDevice
# ============================================================================
	KMAKEPATCH 0x801AB058 
0:
	li   %r3, 1
9:

# ============================================================================
#	StfsMapNewBlock hash mismatch
# ============================================================================
	KMAKEPATCH 0x800E1FF4
0:
	b    0x34  #patch to unconditional branch
9:

# ============================================================================
#	StfsNonCachedRead
#       remove hash check (nop out bne)
# ============================================================================
	KMAKEPATCH 0x800E4308
0:
	nop
9:

# ============================================================================
#	SvodMapNewBlock hash mismatch 
# ============================================================================
	KMAKEPATCH 0x801866F8
0:
	b 0x30  #patch to unconditional branch
9:

# ============================================================================
#	SvodPartiallyCachedRead hash mismatch
# ============================================================================
	KMAKEPATCH 0x80186B0C
0:
	nop
9:

# ============================================================================
#	Load RGLoader.xex after XAM
# ============================================================================

.set ldBranchAddr, 0x80081ACC
.set loaderFuncAddr, 0x801BBB30 #;//empty space
.set XexLoadImage, 0x800A3F18


	KMAKEPATCH loaderFuncAddr
0:
	.set strPath, (loaderFuncAddr + 0x20)
	
	lis   %r11, strPath@h
	ori  %r3, %r11, strPath@l
	li %r4, 8
	li %r5, 0
	li %r6, 0
	KMAKEBRANCHL XexLoadImage 

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


# ============================================================================
	.long 0xffffffff
	.end
# ============================================================================
