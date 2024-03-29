# RGLoader patches file
# Patches follow same format as freeBOOT:
# [4byte offset] [4byte patch count] [4byte patch]...

# Devkit 13599 patches

.set	KernelBase,		0x80000000

# use this if offset > 0x8006b200
.set    KernelCodeBase,         0x80004e00  #file offset by 0x44E00

		.globl _start
_start:

# ============================================================================
#	RGLP header
	.long 0x52474C50
# ============================================================================

#----------------------------------------------------------

# ============================================================================
#       HV DAE 
# ============================================================================
	.long 0x80028DAC - KernelBase  
	.long (9f - 0f) / 4
0:
	.long 0x38600000
	nop
9:


# ============================================================================
#       SataCdRomAuthenticationExSequence
# ============================================================================
	.long 0x800B47A0 - KernelBase  
	.long (9f - 0f) / 4
0:
	b 0x38
9:

#----------------------------------------------------------


# ============================================================================
#       KV check patches - Hvxkeyshmacsha
# ============================================================================
	.long 0x80004ae4 - KernelBase  # First check on
	.long (9f - 0f) / 4
0:
	nop
9:

# ============================================================================
#       Patch XEX flag
# ============================================================================

	.long 0x80006DF4 - KernelBase 
	.long (9f - 0f) / 4
0:
	li %r4, 0x8
	li %r3, 0
9:

	.long 0x80006A6C - KernelBase 
	.long (9f - 0f) / 4
0:
	li %r3, 0
9:



#--------------------------------------------------------------
# ============================================================================
#       XEX keys
# ============================================================================
	.long 0x80010B30 - KernelBase  # Retail DEV key
	.long (9f - 0f) / 4
0:
	.long 0xD1E3B33A
	.long 0x6C1EF770
	.long 0x5F6DE93B
	.long 0xB6C0DC71
9:

	.long 0x800000F0 - KernelBase  # Retail XEX key
	.long (9f - 0f) / 4
0:
	.long 0x20B185A5
	.long 0x9D28FDC3
	.long 0x40583FBB
	.long 0x0896BF91
9:

# ============================================================================
# 	Check if XEX decrypted properly, if not swap the key
# ============================================================================
	.long 0x800299B0 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x2B3C0000
	.long 0x419A0030
	.long 0x2F030000
	.long 0x409A0010
	.long 0x388000F0
	.long 0x48000018
	.long 0x60000000
9:

# ============================================================================
#	HvxCreateImageMapping hash check
# ============================================================================
	.long 0x8002C56C - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x48000010
9:

# ============================================================================
#	HvxDvdAuthRecordXControl?!
# ============================================================================
	.long 0x80026A2C - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:


# ============================================================================
#	HvxSetImagePageTableEntry memory addr check
# ============================================================================
	.long 0x80029B68 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x60000000
9:

# ============================================================================
#	HvxExpansionInstall sig check
# ============================================================================
	.long 0x80030BAC - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x60000000
9:

# ============================================================================
#	MachineCheck (mfspr   r3, LPCR)
# ============================================================================
	.long 0x80000218 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x00000000
9:

# ============================================================================
#	HvxExpansionInstall hash? (uses memcmp) check
# ============================================================================
	.long 0x80030C2C - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x60000000
9:



# Kernel patches

# ============================================================================
#	SataCdRomActivateHCDFRuntimePatch TSST signature check
# ============================================================================
	.long 0x800B41B4 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x48000184  # b 0x184
9:

# ============================================================================
#	SataCdRomActivateHCDFRuntimePatch blacklisted drive check
# ============================================================================
	.long 0x800B41D0 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x48000168  # b 0x168
9:




# ============================================================================
#	XexpVerifyMedia Type?
# ============================================================================
	.long 0x8008E94C - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:

# ============================================================================
#	XexpVerifyXexHeaders
#       not really the same thing patched, what was patched got moved to HV
# ============================================================================
	.long 0x80090440 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:

# ============================================================================
#	XexpVerifyXexHeaders?
# ============================================================================
	.long 0x800903E4 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001  
9:

# ============================================================================
#	XexpVerifyMinimumVersion?
# ============================================================================
	.long 0x80091200 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:

# ============================================================================
#	XexpLoadFile?
# ============================================================================
	.long 0x80092ACC - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:


#-----------------------------------------------------------------------



# ============================================================================
#	HV Patch flag check
# ============================================================================
	.long 0x80006780 - KernelBase
	.long (9f - 0f) / 4
0:
	nop 
9:



# ============================================================================
#	HV Flag fixing function
# ============================================================================
	.long 0x8000A474 - KernelBase
	.long (9f - 0f) / 4
0:
	lhz     %r3, 0x6(%r0)  # load flag byte into r3
	li      %r4, 0x20
	andc    %r3, %r3, %r4 # clear bit
	sth     %r3, 0x6(%r0)      # store new flag
	li      %r3, 0x200    # do what we patched
	ba      0x18C4  
9:	


# ============================================================================
#	HV jump to flag fixer
# ============================================================================
	.long 0x800018C0 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x4800A476      #jump to flag clearing function
9:

#============================================================================
#	HV patch jump
# ============================================================================
	.long 0x80006934 - KernelBase
	.long (9f - 0f) / 4
0:
	li %r3, 0 
9:


#             SECURITY               
#[----------------------------------------

#============================================================================
#	HV Patch blow fuses              (protection against bad recovery disks etc)
# ============================================================================
	.long 0x80009304 - KernelBase
	.long (9f - 0f) / 4
0:
	li %r3, 1 
	blr
9:

#=============================================================================
#       nop out Shadowbooting on startup  
#=============================================================================


	.long 0x8007660C - KernelCodeBase
	.long (9f - 0f) / 4
0:
	nop
9:

#=============================================================================
#       disable shadow booting function   
#=============================================================================


	.long 0x80076148 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	li %r3, 0
	blr
9:



#-----------------------------------------------------------------------




#-----------------------------------------------------------------------

#-----------------------------------------------------------------------

# ============================================================================
#	Set SystemRoot to HDD
# ============================================================================

	.long 0x80041E60 - KernelBase
	.long (9f - 0f) / 4
0:
	.word 50  #//length
	.word 51  #//maxlength
	
	.long 0x80041E68 #//ptr to string
	
	
	.string "\\Device\\Harddisk0\\Partition1\\Filesystems\\13599-dev\0"
	.align 2

9:

	.long 0x80075E2C - KernelCodeBase
	.long (9f - 0f) / 4
0:
	nop              #  nop out the hardware flags check
	.long 0x3D608004 #  lis   r11, 
	
	.long 0x388B1E60 #  addi  r4, r11 #custom
9:


# ============================================================================
#	Patch xEX Restrictions check
# ============================================================================
	.long 0x8002C56C - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x48000010
9:

	.long 0x80092968 - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x38600001
9:

	.long 0x800909FC - KernelBase
	.long (9f - 0f) / 4
0:
	.long 0x48000018
9:




#-----------------------------------------------------------------------

# ============================================================================
#	HV XEX region check -dev13599
# ============================================================================
	.long 0x8002C664 - KernelBase
	.long (9f - 0f) / 4
0:
	nop
9:

# ============================================================================
#	HV XEX RSA check -dev13599
# ============================================================================
	.long 0x8002C664 - KernelBase
	.long (9f - 0f) / 4
0:
	li %r3, 1
9:

# use KernelCodeBase if offset > 0x8006b200

# ============================================================================
#	XeKeysVerifyRSASignature -dev13599
# ============================================================================
	.long 0x80134440 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	nop
9:
	.long 0x80134474 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	li %r3, 1
9:

# ============================================================================
#	XeKeysVerifyPIRSSignature -dev13599
# ============================================================================
	.long 0x80134514 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	li %r3, 1
9:

# ============================================================================
#	XeKeysConsoleSignatureVerification -dev13599
# ============================================================================
	.long 0x8013648C - KernelCodeBase
	.long (9f - 0f) / 4
0:
	b 0x128
9:

# ============================================================================
#	SataCdRomVerifyDVDX2AuthoringSignature -dev13599
# ============================================================================
	.long 0x800B75D8 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	li %r3, 1
9:

# ============================================================================
#	StfsMapNewBlock hash mismatch -dev13599
# ============================================================================
	.long 0x800D61A4 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	.long 0x48000034
9:


# ============================================================================
#	UsbdSecVerifyRevertCertificateSignature hash mismatch -dev13599
# ============================================================================
#	.long 0x80103C00 - KernelCodeBase
#	.long (9f - 0f) / 4
#0:
#	li %r3, 1
#9:

#	.long 0x80103C14 - KernelCodeBase
#	.long (9f - 0f) / 4
#0:
#	li %r3, 1
#9:

# ============================================================================
#	SvodMapNewBlock hash mismatch -dev13599
# ============================================================================
	.long 0x8016D308 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	b 0x30
9:

# ============================================================================
#	SvodPartiallyCachedRead hash mismatch -dev13599
# ============================================================================
	.long 0x8016D71C - KernelCodeBase
	.long (9f - 0f) / 4
0:
	nop
9:

# ============================================================================
#	SataDiskAuthenticateDevice -dev13599
# ============================================================================
	.long 0x80188828 - KernelCodeBase
	.long (9f - 0f) / 4
0:
	li %r3, 1
9:


# ============================================================================
	.long 0xffffffff
	.end
# ============================================================================

