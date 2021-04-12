
# ============================================================================
#	Disable fcrt.bin
#      (fcrt.bin is neccesary for some slim drives though)
# ============================================================================


	KMAKEPATCH 0x8002DEC4
0:
	li   %r10,  0
9:

	KMAKEPATCH 0x8002DCA8
0:
	li   %r10,  0
9:

	KMAKEPATCH 0x80081668
0:
	nop
9:


	
	
	
	
	
	