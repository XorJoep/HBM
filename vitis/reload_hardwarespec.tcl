 
####################################################
#
# update_platform.tcl
#
# Copyright (C) 2020 UltraZohm Community, All rights reserved.
#
# Created on: 21.02.2020
#     Author: Eyke Liegmann (EL)
#
# execute in XSCT console in Vitis workspace using the following commands
#	cd [getws] 
#	source {../update_platform_slim.tcl}
#
# XSCT Programming Reference
# https://www.xilinx.com/html_docs/xilinx2019_2/vitis_doc/
# ->Xilinx Software Command-Line Tool
####################################################

#Put your platform name here!
set PLATFORM_NAME 	MicroBlaze_HBM_Streams_wrapper3

proc regenerate_all_BSPs {{name *}} {
  set tmplist [domain list]
  set index 0
  foreach element $tmplist {
	if {$index>3} {
		if {[string match $name $element]} {
			if {[catch { 
			  domain active $element
			  } result]} {#puts "skip $element."
			} else {
				bsp regenerate
				puts "Info: regenerated BSP $element "
			}
		} 
		#else {puts "skip $element"}
	} 
	#else {puts "$element"}
	incr index
  }
}
proc app_build {{name *}} {
  set tmplist [app list]
  set index 0
  foreach element $tmplist {
	if {$index>2} {
	  if {[string match $name $element]} {
	  
		if {[catch {
		  app build $element
		} result]} { puts "Error:(TE) build $element failed: $result."}

		puts "build $element "
	  } else {
		puts "skip $element"
	  }
	} else {
	  puts "$element"
	}
	incr index
  }
}


puts "========================================"
puts "Info: Before executing the script update the hardware specification (by right clicking on the platform project) and choosing the new .xsa file"
puts "========================================"
puts "Info: Afterwards restart Vitis"
puts "========================================"
puts "Info: If rdi_xsct.exe crashes, please restart Vitis."
puts "========================================"
puts "Info: Your platform name is $PLATFORM_NAME, if this is incorrect change in script"
puts "========================================"

platform active $PLATFORM_NAME
puts "Info: Regenerate all BSP"
puts "========================================"
regenerate_all_BSPs
puts "========================================"
puts "Info: All BSPs successfully regenerated"
puts "========================================"
puts "Info: generate platform project"
puts "========================================"
platform generate
puts "========================================"
puts "Info: platform project successfully generated"
puts "========================================"
puts "Info: build all application projects"
app_build
puts "========================================"
puts "Info: DONE"




