
# ============================================================================
#	Disable stock bootanimation
#      (used for custom boot animations)
# ============================================================================

	KMAKEPATCH 0x800817DC
0:
	nop  # nop out AniStartBootAnimation
9:




