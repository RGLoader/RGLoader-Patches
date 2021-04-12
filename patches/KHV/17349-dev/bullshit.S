	MAKEPATCH 0x00025788
0:
	nop
9:

	MAKEPATCH 0x00025A0C
0:
	b   -0x64
9:

	MAKEPATCH 0x00027388
0:
	nop
9:

	MAKEPATCH 0x000273A0
0:
	nop
9:

	MAKEPATCH 0x000275B8
0:
	b   0xD0
9:

	MAKEPATCH 0x00027478
0:
	nop
9:

	MAKEPATCH 0x00027420
0:
	nop
9:


	MAKEPATCH 0x00027458
0:
	nop
9:

	MAKEPATCH 0x000273D8
0:
	b   0x18
9:





	MAKEPATCH 0x000262A8
0:
	b   0x18
9:


	MAKEPATCH 0x000264F0
0:
	li  %r3, 1
9:
	
	MAKEPATCH 0x000265C0
0:
	li  %r3, 0
9:


	MAKEPATCH 0x000268A4
0:
	b   0x18
9:
	
	

	MAKEPATCH 0x0002697C
0:
	nop
9:
	
	MAKEPATCH 0x00026998
0:
	nop
9:

#;//0xC8000086
#	MAKEPATCH 0x00027ADC
#0:
#	b    0x10
#9:	

#;//0xC8000085
	MAKEPATCH 0x00027B08
0:
	nop
9:	

#;//0xC8000085
	MAKEPATCH 0x00027B44
0:
	nop
9:	

#;//0xC8000085
	MAKEPATCH 0x00026B30
0:
	b  0x18
9:	
	
#;//0xC8000085
	MAKEPATCH 0x00026CC4
0:
	b  -0xB0
9:	

#;//0xC8000085
	MAKEPATCH 0x00026FD8
0:
	b  0x44
9:	

#;//0xC8000085
	MAKEPATCH 0x00027158
0:
	b  0x40
9:

#;//0xC8000085
	MAKEPATCH 0x000270EC
0:
	b  0x44
9:



#;//0xC8000086
#	MAKEPATCH 0x00026A28
#0:
#	b  0x18
#9:	


#;//HvxDvdAuthGetMediaId
	MAKEPATCH 0x00025AAC
0:
	nop
9:	
#;//HvxDvdAuthGetMediaId
	MAKEPATCH 0x00025AB4
0:
	nop
9:	

#;//0xC8000088
	MAKEPATCH 0x00025ADC
0:
	nop
9:

	MAKEPATCH 0x0002C7EC
0:
	li  %r3, 0
9:

	MAKEPATCH 0x00024DA0
0:
	li  %r3, 0
9:

#;/Patch branch to bullshit secrets error

	MAKEPATCH 0x0002C840
0:
	nop
9:
	MAKEPATCH 0x0002C85C
0:
	nop
9:
	MAKEPATCH 0x0002C86C
0:
	nop
9:


#;//0xC8000086

#	MAKEPATCH 0x00027D60
#0:
#	b  0x18
#9:

#	MAKEPATCH 0x00027ADC
#0:
#	b  0x10
#9:

#	MAKEPATCH 0x00027990
#0:
#	b  0x10
#9:

#	MAKEPATCH 0x00027314
#0:
#	b  0x18
#9:

#	MAKEPATCH 0x00026B30
#0:
#	b  0x18
#9:

#	MAKEPATCH 0x00026A28
#0:
#	b  0x18
#9:

#;// Avoid 156 error in kernel
	KMAKEPATCH 0x800C66C8
0:
	b  0x34
9:

	KMAKEPATCH 0x800CC894
0:
	b  0x10
9:

	KMAKEPATCH 0x800CC834
0:
	b  0x10
9:

	KMAKEPATCH 0x800CC848
0:
	b  0x10
9:

	KMAKEPATCH 0x800CC494
0:
	li  %r31, 0
9:

	KMAKEPATCH 0x800C86C4
0:
	b  0x10
9:


#;//SataCdRomDoXGD2LBAHashVerification
	KMAKEPATCH 0x800C43B8
0:
	li  %r3, 0
	blr
9:

#;//SataCdRomDriveAuthentication
	KMAKEPATCH 0x800C7D30
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomAuthenticationSequence
	KMAKEPATCH 0x800C8178
0:
	li  %r3, 0
	blr
9:

#;//SataCdRomXGD2AuthenticationSequence
	KMAKEPATCH 0x800C7F38
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomAuthenticationExSequence
	KMAKEPATCH 0x800C55E8
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomAP21Initialize
	KMAKEPATCH 0x800C5340
0:
	li  %r3, 0
	blr
9:




#;//SataCdRomDeauthDrive
	KMAKEPATCH 0x800C8518
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomFwcr
	KMAKEPATCH 0x800C4150
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomHvFirmwareAuthentication
	KMAKEPATCH 0x800C4220
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomDVDAP20AuthenticateDrive
	KMAKEPATCH 0x800C57A8
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomDoAntiPiracy20Authentication
	KMAKEPATCH 0x800C7D80
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomCalibrateDrive
	KMAKEPATCH 0x800C3DA8
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomGetDriveMeasure
	KMAKEPATCH 0x800C3E48
0:
	li  %r3, 0
	blr
9:

#;//SataCdRomHvRecordXControl
	KMAKEPATCH 0x800CC618
0:
	li  %r3, 0
	blr
9:

#;//SataCdRomAP21StartRead
	KMAKEPATCH 0x800C8838
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomAuthenticationExInitialize
	KMAKEPATCH 0x800C5500
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomAuthenticationChallenge
	KMAKEPATCH 0x800C3660
0:
	li  %r3, 0
	blr
9:




#;//SataCdRomDoAntiPiracy15Authentication
	KMAKEPATCH 0x800C3A30
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomDoAntiPiracy10Authentication
	KMAKEPATCH 0x800C3890
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomDoExtendedVerification
	KMAKEPATCH 0x800C4820
0:
	li  %r3, 0
	blr
9:




#;//SataCdRomDoInitialVerification
	KMAKEPATCH 0x800C46A8
0:
	li  %r3, 0
	blr
9:




#;//SataCdRomFwcrExecute
	KMAKEPATCH 0x800C3F18
0:
	li  %r3, 0
	blr
9:




#;//SataCdRomHvAuthExInitialize
	KMAKEPATCH 0x800CC788
0:
	li  %r3, 0
	blr
9:



#;//SataCdRomHvAuthExMarshal
	KMAKEPATCH 0x800CC4E8
0:
	li  %r3, 0
	blr
9:


#;//SataCdRomHvAuthExNext
	KMAKEPATCH 0x800CC808
0:
	li  %r3, 0
	blr
9:

 
#;//SataCdRomHvAuthExVerify
	KMAKEPATCH 0x800CC870
0:
	li  %r3, 0
	blr
9:

#;//SataCdRomHvFwcr
	KMAKEPATCH 0x800CC990
0:
	li  %r3, 0
	blr
9:



