
# ============================================================================
#	Set KdpRetryCount and KdNetRetryCount to 1
#      (faster boot speed due to smaller kd timeout)
# ============================================================================

.set  KdpRetryCount,    0x801B3BFC
.set  KdNetRetryCount,  0x801B3C0C


	KMAKEPATCH KdpRetryCount
0:
	.long 0x00000001
9:

	KMAKEPATCH KdNetRetryCount
0:
	.long 0x00000001
9:



