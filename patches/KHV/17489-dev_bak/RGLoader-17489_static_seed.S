
# ============================================================================
#	Set memory encryption seed to static
# ============================================================================
MAKEPATCH 0x00010100
0:
	.quad    0xBB88171559306C25
	.quad    0x16A468AA32766932
	.quad    0x1B90752CA520A89E
	.quad    0x660EA988D4141E76
	.quad    0x2C3EE7061FADCDA7
	.quad    0x5208D1DDDED6AC83
9:


MAKEPATCH 0x00001EB0
0:
	nop
9:


MAKEPATCH 0x00001EA4
0:
	nop
9:

MAKEPATCH 0x00001FF8
0:
	nop
9:


