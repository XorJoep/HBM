# This is a generated file. Use and modify at your own risk.
################################################################################

set kernel_name    "snappy_16_unzippers"
set kernel_vendor  "Joep"
set kernel_library "kernel"

##############################################################################

proc edit_core {core} {
  set bif      [::ipx::get_bus_interfaces -of $core  "m00_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m01_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m02_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m03_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m04_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m05_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m06_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m07_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m08_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m09_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m10_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m11_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m12_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m13_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m14_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  set bif      [::ipx::get_bus_interfaces -of $core  "m15_axi"] 
  set bifparam [::ipx::add_bus_parameter -quiet "MAX_BURST_LENGTH" $bif]
  set_property value        256          $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_READ_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam
  set bifparam [::ipx::add_bus_parameter -quiet "NUM_WRITE_OUTSTANDING" $bif]
  set_property value        32           $bifparam
  set_property value_source constant     $bifparam

  ::ipx::associate_bus_interfaces -busif "m00_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m01_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m02_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m03_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m04_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m05_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m06_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m07_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m08_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m09_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m10_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m11_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m12_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m13_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m14_axi" -clock "ap_clk" $core
  ::ipx::associate_bus_interfaces -busif "m15_axi" -clock "ap_clk" $core

  ::ipx::associate_bus_interfaces -busif "s_axi_control" -clock "ap_clk" $core


  # Specify the freq_hz parameter 
  set clkbif      [::ipx::get_bus_interfaces -of $core "ap_clk"]
  set clkbifparam [::ipx::add_bus_parameter -quiet "FREQ_HZ" $clkbif]
  # Set desired frequency                   
  set_property value 250000000 $clkbifparam
  # set value_resolve_type 'user' if the frequency can vary. 
  set_property value_resolve_type user $clkbifparam
  # set value_resolve_type 'immediate' if the frequency cannot change. 
  # set_property value_resolve_type immediate $clkbifparam
  set mem_map    [::ipx::add_memory_map -quiet "s_axi_control" $core]
  set addr_block [::ipx::add_address_block -quiet "reg0" $mem_map]

  set reg      [::ipx::add_register "CTRL" $addr_block]
  set_property description    "Control signals"    $reg
  set_property address_offset 0x000 $reg
  set_property size           32    $reg
  set field [ipx::add_field AP_START $reg]
    set_property ACCESS {read-write} $field
    set_property BIT_OFFSET {0} $field
    set_property BIT_WIDTH {1} $field
    set_property DESCRIPTION {Control signal Register for 'ap_start'.} $field
    set_property MODIFIED_WRITE_VALUE {modify} $field
  set field [ipx::add_field AP_DONE $reg]
    set_property ACCESS {read-only} $field
    set_property BIT_OFFSET {1} $field
    set_property BIT_WIDTH {1} $field
    set_property DESCRIPTION {Control signal Register for 'ap_done'.} $field
    set_property READ_ACTION {modify} $field
  set field [ipx::add_field AP_IDLE $reg]
    set_property ACCESS {read-only} $field
    set_property BIT_OFFSET {2} $field
    set_property BIT_WIDTH {1} $field
    set_property DESCRIPTION {Control signal Register for 'ap_idle'.} $field
    set_property READ_ACTION {modify} $field
  set field [ipx::add_field AP_READY $reg]
    set_property ACCESS {read-only} $field
    set_property BIT_OFFSET {3} $field
    set_property BIT_WIDTH {1} $field
    set_property DESCRIPTION {Control signal Register for 'ap_ready'.} $field
    set_property READ_ACTION {modify} $field
  set field [ipx::add_field RESERVED_1 $reg]
    set_property ACCESS {read-only} $field
    set_property BIT_OFFSET {4} $field
    set_property BIT_WIDTH {2} $field
    set_property DESCRIPTION {Reserved.  0s on read.} $field
    set_property READ_ACTION {modify} $field
  set field [ipx::add_field AUTO_RESTART $reg]
    set_property ACCESS {read-write} $field
    set_property BIT_OFFSET {7} $field
    set_property BIT_WIDTH {1} $field
    set_property DESCRIPTION {Control signal Register for 'auto_restart'.} $field
    set_property MODIFIED_WRITE_VALUE {modify} $field
  set field [ipx::add_field RESERVED_2 $reg]
    set_property ACCESS {read-only} $field
    set_property BIT_OFFSET {8} $field
    set_property BIT_WIDTH {24} $field
    set_property DESCRIPTION {Reserved.  0s on read.} $field
    set_property READ_ACTION {modify} $field

  set reg      [::ipx::add_register -quiet "scalar00" $addr_block]
  set_property address_offset 0x010 $reg
  set_property size           [expr {4*8}]   $reg

  set reg      [::ipx::add_register -quiet "scalar01" $addr_block]
  set_property address_offset 0x018 $reg
  set_property size           [expr {4*8}]   $reg

  set reg      [::ipx::add_register -quiet "scalar02" $addr_block]
  set_property address_offset 0x020 $reg
  set_property size           [expr {4*8}]   $reg

  set reg      [::ipx::add_register -quiet "scalar03" $addr_block]
  set_property address_offset 0x028 $reg
  set_property size           [expr {4*8}]   $reg

  set reg      [::ipx::add_register -quiet "axi00_ptr0" $addr_block]
  set_property address_offset 0x030 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m00_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi00_ptr1" $addr_block]
  set_property address_offset 0x03c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m00_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi01_ptr0" $addr_block]
  set_property address_offset 0x048 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m01_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi01_ptr1" $addr_block]
  set_property address_offset 0x054 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m01_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi02_ptr0" $addr_block]
  set_property address_offset 0x060 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m02_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi02_ptr1" $addr_block]
  set_property address_offset 0x06c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m02_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi03_ptr0" $addr_block]
  set_property address_offset 0x078 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m03_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi03_ptr1" $addr_block]
  set_property address_offset 0x084 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m03_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi04_ptr0" $addr_block]
  set_property address_offset 0x090 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m04_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi04_ptr1" $addr_block]
  set_property address_offset 0x09c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m04_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi05_ptr0" $addr_block]
  set_property address_offset 0x0a8 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m05_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi05_ptr1" $addr_block]
  set_property address_offset 0x0b4 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m05_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi06_ptr0" $addr_block]
  set_property address_offset 0x0c0 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m06_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi06_ptr1" $addr_block]
  set_property address_offset 0x0cc $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m06_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi07_ptr0" $addr_block]
  set_property address_offset 0x0d8 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m07_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi07_ptr1" $addr_block]
  set_property address_offset 0x0e4 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m07_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi08_ptr0" $addr_block]
  set_property address_offset 0x0f0 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m08_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi08_ptr1" $addr_block]
  set_property address_offset 0x0fc $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m08_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi09_ptr0" $addr_block]
  set_property address_offset 0x108 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m09_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi09_ptr1" $addr_block]
  set_property address_offset 0x114 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m09_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi10_ptr0" $addr_block]
  set_property address_offset 0x120 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m10_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi10_ptr1" $addr_block]
  set_property address_offset 0x12c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m10_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi11_ptr0" $addr_block]
  set_property address_offset 0x138 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m11_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi11_ptr1" $addr_block]
  set_property address_offset 0x144 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m11_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi12_ptr0" $addr_block]
  set_property address_offset 0x150 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m12_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi12_ptr1" $addr_block]
  set_property address_offset 0x15c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m12_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi13_ptr0" $addr_block]
  set_property address_offset 0x168 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m13_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi13_ptr1" $addr_block]
  set_property address_offset 0x174 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m13_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi14_ptr0" $addr_block]
  set_property address_offset 0x180 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m14_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi14_ptr1" $addr_block]
  set_property address_offset 0x18c $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m14_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi15_ptr0" $addr_block]
  set_property address_offset 0x198 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m15_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi15_ptr1" $addr_block]
  set_property address_offset 0x1a4 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m15_axi $regparam 

  set reg      [::ipx::add_register -quiet "axi00_sts" $addr_block]
  set_property address_offset 0x1b0 $reg
  set_property size           [expr {8*8}]   $reg
  set regparam [::ipx::add_register_parameter -quiet {ASSOCIATED_BUSIF} $reg] 
  set_property value m00_axi $regparam 

  
  set_property slave_memory_map_ref "s_axi_control" [::ipx::get_bus_interfaces -of $core "s_axi_control"]

  set_property xpm_libraries {XPM_CDC XPM_MEMORY XPM_FIFO} $core
  set_property sdx_kernel true $core
  set_property sdx_kernel_type rtl $core
}

##############################################################################

proc package_project {path_to_packaged kernel_vendor kernel_library kernel_name} {
  set core [::ipx::package_project -root_dir $path_to_packaged -vendor $kernel_vendor -library $kernel_library -taxonomy "/KernelIP" -import_files -set_current false ]
  foreach user_parameter [list C_S_AXI_CONTROL_ADDR_WIDTH C_S_AXI_CONTROL_DATA_WIDTH C_M00_AXI_ADDR_WIDTH C_M00_AXI_DATA_WIDTH C_M01_AXI_ADDR_WIDTH C_M01_AXI_DATA_WIDTH] {
    ::ipx::remove_user_parameter $user_parameter $core
  }
  ::ipx::create_xgui_files $core
  set_property supported_families { } $core
  set_property auto_family_support_level level_2 $core
  set_property used_in {out_of_context implementation synthesis} [::ipx::get_files -type xdc -of_objects [::ipx::get_file_groups "xilinx_anylanguagesynthesis" -of_objects $core] *_ooc.xdc]
  edit_core $core
  ::ipx::update_checksums $core
  ::ipx::check_integrity -kernel $core
  ::ipx::save_core $core
  ::ipx::unload_core $core
  unset core
}

##############################################################################

proc package_project_dcp {path_to_dcp path_to_packaged kernel_vendor kernel_library kernel_name} {
  set core [::ipx::package_checkpoint -dcp_file $path_to_dcp -root_dir $path_to_packaged -vendor $kernel_vendor -library $kernel_library -name $kernel_name -taxonomy "/KernelIP" -force]
  edit_core $core
  ::ipx::update_checksums $core
  ::ipx::check_integrity -kernel $core
  ::ipx::save_core $core
  ::ipx::unload_core $core
  unset core
}

##############################################################################

proc package_project_dcp_and_xdc {path_to_dcp path_to_xdc path_to_packaged kernel_vendor kernel_library kernel_name} {
  set core [::ipx::package_checkpoint -dcp_file $path_to_dcp -root_dir $path_to_packaged -vendor $kernel_vendor -library $kernel_library -name $kernel_name -taxonomy "/KernelIP" -force]
  edit_core $core
  set rel_path_to_xdc [file join "impl" [file tail $path_to_xdc]]
  set abs_path_to_xdc [file join $path_to_packaged $rel_path_to_xdc]
  file mkdir [file dirname $abs_path_to_xdc]
  file copy $path_to_xdc $abs_path_to_xdc
  set xdcfile [::ipx::add_file $rel_path_to_xdc [::ipx::add_file_group "xilinx_implementation" $core]]
  set_property type "xdc" $xdcfile
  set_property used_in [list "implementation"] $xdcfile
  ::ipx::update_checksums $core
  ::ipx::check_integrity -kernel $core
  ::ipx::save_core $core
  ::ipx::unload_core $core
  unset core
}

##############################################################################
