       
                                  _________________________________
                              ---/  __ /\   _  \      \\   \    --\\--->
                                      \\ \  .\  \  ____\\   \
                                       \\ \     /  \    \\   \______
                                       \\\ \    \\  \.   \\         \\
                                       \\\\ \_/\_\\_______\\_________\\\
                                   ....\\\\\/_/\_//_______//_________////....
                             --------------------------------------------------------
                                                 RGLoader 0v400                                             
	-----------------------------------------------------------------------------------------------
	\_Release Notes:_\\

	     A lot of people have thought that RGLoader has been dead/abandoned.  Yeah, basically it's 
	  been dead for a while now mostly because Stoker has been gone for over a year so there was
	  only one real developer for RGLoader and real life stuff gets in the way.  I've gotta put out 
	  a big thank you to sk1080 for releasing a usable version of RGLoader for 16202 while I've 
	  been gone.  In either case, saying that RGLoader is dead really does not make a lot of sense
	  when we have tried to make it as open as possible without sharing code that was donated by
	  people who don't want it running out in the wild yet.  RGBuild.exe is not obfuscated in any
	  way and can be completely decompiled to source with .net reflector.  The patches are provided 
	  in plain text and compiled when you run the image which should allow anyone to be able to 
	  update them for a new kernel.  All you would have to do is use the existing file structures 
	  as a guide to add support for a new update.  This said, there is no reason that some random 
	  person would not be able to change RGBuild for their own purpose or for a new kernel.  
	  
	    RGBuild++ was another project started by stoker and abandoned and left to me to finish, and
	  there's still quite a bit of work to be done on it before it's ready for a release.  I felt 
	  bad releasing an update using the RGBuild everyone is familiar with when I have promised 
	  new features like jasper big block support.  It's hard to devote the amount of time and effort
	  needed to finish something like this when the xbox scene is slowing down and interest in 
	  alternative nand builders is low.  This doesn't mean that I haven't been updating RGLoader for
	  my own uses and adding features, it just means I didn't feel like putting in the effort to 
	  make it usable for the general public and releasing.  
	  
	    I've seen a lot more activity in the #RGloader channel on EFNet and on the forum with 
	  people asking for a new update.  I have no problem putting the work in when I know it's not 
	  going to waste, so these past couple weeks I have been porting some of the new features in 
	  RGBuild++ to this older builder just so you guys can enjoy what we have so far and run a much
	  more stable kernel.
	  
	    I'd like to conclude with, don't be fooled and think that just because the builder looks 
	  the same that the xbox side hasn't changed.  Please try out some of the new features added 
	  and PLEASE leave feedback in the shoutbox at rgloader.com with any problems or successes you
	  have had.  This lets us know that there are still people out there that have use for a devkit
	  kernel on a retail xbox.
	  
	  PLEASE READ THE REST OF THE README! THINGS HAVE CHANGED!
	  
	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
	\_Prerequisites:_\\
	  
	  -You will need .NET Framework 4.0 or 4.5 installed. 
           May also work with Mono.

	  -Copy rgloader.ini to the root of the hard drive.  

	  -(OPTIONAL) Copy bootanim.wmv to the root of the hard drive for 
           alternate boot animation.  
	   *** (slows boot times a little bit) ***
		
	  -Extract the hdd filesystems rar to 'Hdd:\Filesystems\' on your xbox hard drive.
	   *** WARNING: Folder name is case-sensitive!! ***
		
	  -(**IMPORTANT**) If you have an xbdm.ini on the root of your hard drive, 
           delete it or back it up somewhere.  If you don't it can cause a stall at bootanimation.
	  
	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
	\_Usage:_\\
	
	  -Extract the builder rar to a folder.

	  -Run the launcher and put in your CPUKey.  
		
	  -Click the NAND button to browse for your source nand image.
	   ***JTAGS MUST SELECT A FREEBOOT IMAGE***
	  
	  -Configure the options in the launcher for your build type ex: RGH1/RGH2/JTAG and build version (16537 is latest).

	  -Click "RGBuilder" button to start the process.

	  -Output will be next to the launcher named: Image._____.bin 

	  -Flash this to your xbox using whichever flash tool you wish.
		
	  -A lot of things get initialized on the first boot so sometimes it stalls at bootanimation or before.  If this happens to you,
	   Just reboot and it should be fine :)
	  
	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
	\_RGLoader NEW Features:_\\
	
	  -- Avatar File Installer --
	  
	     Thanks to cOz and his badass system extended partition installer code, 
	     RGLoader.xex now supports creating and formatting the hard drive partitions 
	     for the avatar update files.  Included in the hdd filesystem files is a $SystemUpdate
	     folder.  If RGLoader detects that this folder exists, it will reinitialize the 
	     partitions and automatically copy the files to it.  It usually requires a reboot 
	     after the installation for the avatars to start showing up in the dashboard.
	  
	  -- HV Peek Poke --
 
	     A peek poking patch has been added to the hypervisor.  It uses the same call format that
             Freeboot uses with syscall0.  
		 
	  -- RGLoader Plugin Loading --
	  
		 Options have been added to RGLoader.ini for loading plugins in the same format that 
		 dashlaunch handles.  They are essentially just system dlls so you can use them for 
		 whatever purpose you wish.
		 
		 Format:
			[Plugins]
			Plugin1 = Hdd:\Plugin1blah.xex
			Plugin2 = 
			Plugin3 = 
			
	  -- RGLP Loading at runtime --
	     
	     Not really a new feature, but not many people knew about this before.  During system 
	     initialization RGLoader.xex will scan the systemroot for any .rglp files and will apply
	     them to the kernel/xam/whatever the address is for.  They are a standard patch format
	     [Addr][numberofpatches][startpatches..].  There is a file named rglXam.rglp in the 
	     hdd filesystems folder which you can open with a hex editor and use an example.  This 
	     feature is useful for testing extra patches without having to completely reflash your 
	     nand image.

	  -- KDNet for Jtags --
		
	     KDNet is kernel debugging over lan.  It is basically like 
	     xbwatson on crack.  It shows post codes and runs even before 
	     xbdm.xex gets launched.  This utility is extremely useful 
	     for debugging problems in the kernel, and also inserting 
	     breakpoints and debugging xex modules running on the system.  
   
             Developers who create trainers and such will find this very useful.  
		
	     In the past, using xbsetcfg to setup KDNet for jtags would 
             corrupt the nand image and brick the xbox because it overwrites 
             important info where the jtag payload is stored.  This issue 
             has been fixed in RGLoader.
		
	     The most exciting thing about the latest RGBuild update is 
             that when you build your nand image it detects the computers 
             local IP address and sets up KDNet for the nand.  This is very useful 
             because if your xbox fails to boot or has problems, you do not need 
             a uart cable or a post sniffer to figure out what the problem is.  
             Simply hook your ethernet cable into your xbox and run KDNet and the 
             problem will be obvious and easy to fix usually.
		
	     Make sure you have the SDK installed (xbox neighborhood) and run one 
             of the provided bat files (KDNet_win7.bat / KDNet_win8.bat) and turn 
             on your xbox.
		
	  -- Memory Protection Options --
		
	     In the past there have been problems when running certain utilities 
             made for retail kernel on RGLoader, such as trainers for games.  
             This was caused by the xex being compiled to use memcpy instead of DmSetMemory.  
             A lot of trainers have already been updated to fix this issue, but there 
             is now an option which will disable the memory protection in this 
             devkit kernel in the same way it is disabled in retail.  
             This fixes most problems with trainers and such.
	     In options.ini set NOMEMPROT = 1

	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
	\_RGLoader Main Features:_\\
	
	  -- Minimal Mode --
		
             If you are missing the filesystem files on your hard drive, it will boot 
             to a nand-only mode with minimal features.  This mainly means that only the 
             devkit launcher will work and not the regular dashboard.  
             This is useful if you want to flash the nand image on first and then run 
             minimal mode to copy the hard drive files over xbox neighborhood.  
             They will take effect after a reboot.
		
	  -- NAND Image Editor (Beta-ish) --
		
             Run the launcher and click the "Image Editor" button (don't worry about 
             browsing for nand or anything first), or run the rgbuild.exe in the rgbuild 
             folder to open the rgbuild UI, which is a NAND image editor similar to 360 
	     flash tool but with more features.  It allows for basic nand image browsing 
	     and also can be used to build a nand by adding each needed element (bootloaders,
	     SMC, keyvault, etc..).  Is also able to inject payloads (binary files) into the 
	     nand at a specified offset and will re-arrange the filesystem if the address 
	     conflicts with a file.

	     The GUI is still beta, but should be functional. 
             Please reports bugs to #rgloader @ EFNet or on the forum shoutbox!
	  
	  -- DUMMY KV Generation --
		
             To protect you from getting your keyvaults banned, we have added an option 
             to options.ini for creating atemporary dummy devkit KV.  
		
	  -- Custom Boot Animations --
		
             Set 'Boot_Animation_Path = \SystemRoot\RGL_bootanim.xex' in rgloader.ini on 
             your hard drive root, and place a bootanimation wmv on the hard drive root
	         named bootanim.wmv and it will play this movie file when the xbox boots.
		
	     NOTICE:
		
                The only way we were able to load wmvs was by waiting for the kernel to 
                fully load before running the boot animation. This doesn't make a lot of sense, 
                and does increase the boot time by a few seconds so we are working on a way 
                of replacing the normal one.  
                If you do not like this delay, feel free to switch back to the regular animation by:
			
                -Set 'Boot_Animation = 0' in rgloader.ini on the hard drive root.
	        -Set 'disable_bootanim = 0' in options.ini, and rebuild/flash your nand image.
			
	  -- Retail XEX / DVD Support --
		
             Unlike a normal devkit, RGLoader supports running retail xex without the 
             need of running it though xextool.  RGLoader also supports retail DVD decryption 
             so you can play your retail discs the same way you would in a retail kernel.
	  
	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
        \_Compatiblity:_\\
	  
          Motherboards
           -Xenon Jtag 16MB
           -Zephyr Jtag/RGH/RGH2 16MB
           -Falcon Jtag/RGH/RGH2 16MB                  
           -Jasper Jtag/RGH/RGH2 16MB
           -Trinity RGH 16MB
           -Corona RGH 16MB

	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
        \_Changelog:_\
	
	  0v500
	    -Added support for 17150
		-Few bug fixes
	
	  0v400
		-Added support for 16537
		-Too many fixes to name for RGBuild.exe (much better corona support in image editing)
		-Fixed JTAG KDNet support
		-RGBuild now sets up KDNet in the nand image (no need for xbsetcfg)
		-Fixed filesystem issues, can now insert payload anywhere in nand and filesystem will 
		 rearrange itself.
		-Overall much more stable kernel patches
		-Options.ini
			-Ability to disable memory protection
		-RGLoader.xex
			-Added plugin loading
			-Will load ini from USB drive before hdd (useful if a plugin is crashing the system)

	  0v311
		-Fixed missing jtag patches

	  0v310
		-Added 16202
		-RGLoader.xex now dynamically targets 14719/15574/or 16202 (16197 may be incomplete)
		-Drag and drop load on rgbuild gui
		-Reserve space for payloads in FS area(fixes bootanim overwrite by patches)
		-RGBuild will now accept any kernel version as valid

	  0v305
		-Fixed bad block issue (may fix e79 errors for many people)
		-Fixed RGH1 on 15574
		-Fixed controller desyncing issues in 15574
		-Fixed ROL animation during bootanim
		-RGLoader.xex
			-Added launch xshell to HUD
			-Fixed xshell hooking
			-Fixed persistent patches
			-Fixed boot animation path in ini
	 
	  0v300
		-Xshell start button redirection
		-Retail profile encryption support  (thanks Dwack!)
		-RGLoader.xex
			-binary patch loader
			-Added system extended partitions to xbox neighborhood
			-Xbox live signin notice toggling
		-Added corona support
		-Updated to 15574 kernel
		-Added minimal mode indicator on screen
		-Fixed slim/rgh minimal mode
		-Added custom boot animations

	  0v295
		-Fixed falcon rgh1 issue in 0v290
		-Added kernel side patch loader
		-Added INI: hdd1:\RGLoader.ini
			-Block live dns option
			-Add USB drives to xbox neighborhood (thanks Natelx!)
			-Assign default dashboard
		-Fixed dummy KV induced sign on lag
		-MUCH Faster boot speeds (by 4-5 seconds! 9.5 second jtag load)

	  0v290
		-Fixed RGH2 
		-Added flexible systemroot patches! (no hdd needed!)
		-Added xell to jtag images
		-Fixed ini problems
		-Slightly faster phat boot times
  
	  0v280
		-Fixed slim CBB pairing data issue
		-Added dynamic patches, check out options.ini [Patches]
		-Prettied up patch code (thanks for macros.S cOz!)
		-New GUI Update via m0j0j0_j0
		-Systemroot patches are now optional (dynamic)
		-Added custom error code e90! (hdd filesystem failure)
		-Fixed HDMI jtags
		-Added RGH2 support! (thanks Team Xecuter)

	  0v260
		-Added better error handling on patch compiling
		-MUCH faster compile times
		-Added GUI launcher :D (thanks m0j0j0_j0!)
		-GUI Launcher settings save to options.ini
		-Xenon jtag 14719 fixed
  
	  0v255
		-Fixed 14719 dash issue
		-Fixed 14719 retail xex issue
		-Fixed KV editing in GUI
		-Added dummy KV generating (thanks cOz!)
		-Added option to generate KV in options.ini
		-Patched xbdm to always be dev, instead of xbdm.ini (thanks Natelx!)

	  0v240
		-Integrated bat files into rgbuild.exe
		-Fixed jasper issue
		-Added options.ini
		-Lots of changes to builder, mostly internal
		-Missing filesystem files will now be ignored (dae, fcrt, etc..)
		-Changed selection menu
		-Auto detects console using smc (thanks cOz!)
		-Fixed CF/CG bug (can now use them in GUI)
		-Support for JTAG images :D
		-Changed selection menu layout
		-Builder now ignores missing filesystem files instead of locking up
		-Added 14719
		-Support for trinity 14719 source images
		-Updated xell binary to v0.991
		-Added icons to builder (thanks m0j0j0_j0!)
		-Fixed xell binary size issue
		-Added option for compiling phat CD to options.ini
		-Fixed issue with KV editing not saving

	  0v170
		-Added KV editing to the GUI
		-Xell dual boot (xell-gggggg.bin)
		-Bad block support
		-Added font files to nand image to fix fsd (thanks cOz)
		-No need to run image through nandpro anymore
		-More error handling, builder doesn't say successful build every time

	  0v100
		-Added 14699 patches
		-Moved files location on hdd
		-Slims show up as dev kit on 14699 without xbdm.ini or modded xbdm.xex
		-Retail disc support on slims
		-Added neededfiles.txt to the folders

	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
        \_Credits - Greetings - Thanks:_\\
	
	  RGLoader was started from the foundations left by others.
	   We hold no claim to researching everything used in rgloader.
	   It's thanks to the work of the amazing people below that we got anywhere:

	  tmbinc, almost every 360 tool owes you for your initial work. although
	   we may be -FAR- away from your intended goals, we'd still like to thank
	   you for your amazing work and the example you set for a good reverse engineerer.

	  The 360 Flash Tool team, thanks for your amazing tool which has
	    helped many people, many times over. My only gripe is that it's 
	    not open, maybe one day.

	  GliGli, Tiros, and co., I'm sure anybody with a glitched console should
	   know the work you all put in. I hope recent releases won't deter you
	   from continuing to contribute to the scene with your work. 

	  Tuxuser, Cancerous, sk1080, and Juvenal for their work on open source, legal homebrew.

	  Big thanks to cOz for tips and hints and for the work he has contributed 
	   to the scene.  RGLoader wouldn't be nearly what it is without him. 

	  jsjar for graphics and dash skin.

	  m0j0j0_j0 for RGLauncher skin and icons.

	  Razkar for the news on Homebrew-Connection.org and the release videos

	  Thanks to team-xecuter & xconsoles for donating a xenon jtag! RGLoader JTAG would 
	   not exist without this.
	
	  Stoker25 for starting up RGLoader despite all the criticism we had to fight through in the 
	   beginning. Hope we see you again one day buddy.  Good luck to you wherever you are!
	 
	  sk1080 for taking over for me while I was gone and updating RGLoader for 16202/16203. 

	  GliGli, Tiros, cOz, and co.
	  IceKiller
	  Team-Xecuter
	  TeamFSD
	  Freeboot/ggbuild/xebuild team
	  Natelx
	  Dwack
	
	\_#RGLoader-dev Group:_\\

	  tydye81
	  sk1080

	  stoker25
	  Juggahax0r
	  XDK
	  iCEQB
	  m0j0j0_j0

	\_Testers/Helpers/Donators/#RGLoader regulars:_\\

	  RF1911
	  dw5304
	  Legend64
	  Mustache
	  Evil0ne
	  spandaman
	  AsAsAn8
	  Deathlok
	  Ameel
	  Grim187
	  Rumblpak
	  iLLNESS
	  Xumpy
	  SquirtnR2
	  Gadorach
	  no1b4me
	  Mycah
	  Alter
	  PizzaG
	  ddxcb
	  SammyTW

	_______________________________________________________________________________________________     
	-----------------------------------------------------------------------------------------------
      	\_RGLoader Team - 2013_\\                                            





