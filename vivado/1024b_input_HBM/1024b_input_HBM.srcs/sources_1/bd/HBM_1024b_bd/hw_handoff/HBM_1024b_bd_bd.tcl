
################################################################
# This is a generated script based on design: HBM_1024b_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source HBM_1024b_bd_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu280-fsvh2892-2L-e
   set_property BOARD_PART xilinx.com:au280:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name HBM_1024b_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set sysclk0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk0 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $sysclk0


  # Create ports
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $resetn

  # Create instance: Stream_sink_0, and set properties
  set Stream_sink_0 [ create_bd_cell -type ip -vlnv user.org:user:Stream_sink:1.0 Stream_sink_0 ]

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_addr_width {33} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {256} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {23} \
 ] $axi_dma_0

  # Create instance: axi_dma_1, and set properties
  set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_1 ]
  set_property -dict [ list \
   CONFIG.c_addr_width {33} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {256} \
   CONFIG.c_m_axis_mm2s_tdata_width {32} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {23} \
 ] $axi_dma_1

  # Create instance: axi_protocol_convert_0, and set properties
  set axi_protocol_convert_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_0 ]
  set_property -dict [ list \
   CONFIG.TRANSLATION_MODE {2} \
 ] $axi_protocol_convert_0

  # Create instance: axi_protocol_convert_1, and set properties
  set axi_protocol_convert_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_1 ]
  set_property -dict [ list \
   CONFIG.TRANSLATION_MODE {2} \
 ] $axi_protocol_convert_1

  # Create instance: axi_protocol_convert_2, and set properties
  set axi_protocol_convert_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_2 ]
  set_property -dict [ list \
   CONFIG.TRANSLATION_MODE {2} \
 ] $axi_protocol_convert_2

  # Create instance: axi_protocol_convert_3, and set properties
  set axi_protocol_convert_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_3 ]
  set_property -dict [ list \
   CONFIG.TRANSLATION_MODE {2} \
 ] $axi_protocol_convert_3

  # Create instance: axi_traffic_gen_0, and set properties
  set axi_traffic_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen:3.0 axi_traffic_gen_0 ]
  set_property -dict [ list \
   CONFIG.C_ATG_MODE {AXI4-Stream} \
   CONFIG.C_AXIS_TDATA_WIDTH {512} \
   CONFIG.C_AXIS_TDEST_WIDTH {0} \
   CONFIG.C_AXIS_TID_WIDTH {0} \
   CONFIG.C_AXIS_TUSER_WIDTH {0} \
 ] $axi_traffic_gen_0

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]
  set_property -dict [ list \
   CONFIG.M00_TDATA_REMAP {tdata[255:0]} \
   CONFIG.M01_TDATA_REMAP {tdata[255:0]} \
   CONFIG.M02_TDATA_REMAP {tdata[255:0]} \
   CONFIG.M03_TDATA_REMAP {tdata[255:0]} \
   CONFIG.M_TDATA_NUM_BYTES {32} \
   CONFIG.NUM_MI {2} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
 ] $axis_broadcaster_0

  # Create instance: axis_combiner_0, and set properties
  set axis_combiner_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_combiner:1.1 axis_combiner_0 ]

  # Create instance: axis_dwidth_converter_0, and set properties
  set axis_dwidth_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_0 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {32} \
 ] $axis_dwidth_converter_0

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sysclk0} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $clk_wiz_1

  # Create instance: hbm_0, and set properties
  set hbm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 hbm_0 ]
  set_property -dict [ list \
   CONFIG.USER_APB_EN {false} \
   CONFIG.USER_CLK_SEL_LIST0 {AXI_01_ACLK} \
   CONFIG.USER_CLK_SEL_LIST1 {AXI_16_ACLK} \
   CONFIG.USER_HBM_CP_1 {6} \
   CONFIG.USER_HBM_DENSITY {8GB} \
   CONFIG.USER_HBM_FBDIV_1 {36} \
   CONFIG.USER_HBM_HEX_CP_RES_1 {0x0000A600} \
   CONFIG.USER_HBM_HEX_FBDIV_CLKOUTDIV_1 {0x00000902} \
   CONFIG.USER_HBM_HEX_LOCK_FB_REF_DLY_1 {0x00001f1f} \
   CONFIG.USER_HBM_LOCK_FB_DLY_1 {31} \
   CONFIG.USER_HBM_LOCK_REF_DLY_1 {31} \
   CONFIG.USER_HBM_RES_1 {10} \
   CONFIG.USER_HBM_STACK {2} \
   CONFIG.USER_MC_ENABLE_08 {TRUE} \
   CONFIG.USER_MC_ENABLE_09 {TRUE} \
   CONFIG.USER_MC_ENABLE_10 {TRUE} \
   CONFIG.USER_MC_ENABLE_11 {TRUE} \
   CONFIG.USER_MC_ENABLE_12 {TRUE} \
   CONFIG.USER_MC_ENABLE_13 {TRUE} \
   CONFIG.USER_MC_ENABLE_14 {TRUE} \
   CONFIG.USER_MC_ENABLE_15 {TRUE} \
   CONFIG.USER_MC_ENABLE_APB_01 {TRUE} \
   CONFIG.USER_MEMORY_DISPLAY {8192} \
   CONFIG.USER_PHY_ENABLE_08 {TRUE} \
   CONFIG.USER_PHY_ENABLE_09 {TRUE} \
   CONFIG.USER_PHY_ENABLE_10 {TRUE} \
   CONFIG.USER_PHY_ENABLE_11 {TRUE} \
   CONFIG.USER_PHY_ENABLE_12 {TRUE} \
   CONFIG.USER_PHY_ENABLE_13 {TRUE} \
   CONFIG.USER_PHY_ENABLE_14 {TRUE} \
   CONFIG.USER_PHY_ENABLE_15 {TRUE} \
   CONFIG.USER_SAXI_00 {true} \
   CONFIG.USER_SAXI_01 {true} \
   CONFIG.USER_SAXI_02 {true} \
   CONFIG.USER_SAXI_03 {true} \
   CONFIG.USER_SAXI_04 {false} \
   CONFIG.USER_SAXI_05 {false} \
   CONFIG.USER_SAXI_06 {false} \
   CONFIG.USER_SAXI_07 {false} \
   CONFIG.USER_SAXI_08 {false} \
   CONFIG.USER_SAXI_09 {false} \
   CONFIG.USER_SAXI_10 {false} \
   CONFIG.USER_SAXI_11 {false} \
   CONFIG.USER_SAXI_12 {false} \
   CONFIG.USER_SAXI_13 {false} \
   CONFIG.USER_SAXI_14 {false} \
   CONFIG.USER_SAXI_15 {false} \
   CONFIG.USER_SAXI_16 {false} \
   CONFIG.USER_SAXI_17 {false} \
   CONFIG.USER_SAXI_18 {false} \
   CONFIG.USER_SAXI_19 {false} \
   CONFIG.USER_SAXI_20 {false} \
   CONFIG.USER_SAXI_21 {false} \
   CONFIG.USER_SAXI_22 {false} \
   CONFIG.USER_SAXI_23 {false} \
   CONFIG.USER_SAXI_24 {false} \
   CONFIG.USER_SAXI_25 {false} \
   CONFIG.USER_SAXI_26 {false} \
   CONFIG.USER_SAXI_27 {false} \
   CONFIG.USER_SAXI_28 {false} \
   CONFIG.USER_SAXI_29 {false} \
   CONFIG.USER_SAXI_30 {false} \
   CONFIG.USER_SAXI_31 {false} \
   CONFIG.USER_SWITCH_ENABLE_00 {TRUE} \
   CONFIG.USER_SWITCH_ENABLE_01 {TRUE} \
 ] $hbm_0

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {0} \
   CONFIG.C_DATA_SIZE {64} \
   CONFIG.C_DCACHE_ADDR_TAG {0} \
   CONFIG.C_DEBUG_ENABLED {0} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_TRACE {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: resetn_inv_0, and set properties
  set resetn_inv_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 resetn_inv_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $resetn_inv_0

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $rst_clk_wiz_1_100M

  # Create interface connections
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_combiner_0/S00_AXIS]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_protocol_convert_1/S_AXI]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_protocol_convert_0/S_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S [get_bd_intf_pins axi_dma_1/M_AXIS_MM2S] [get_bd_intf_pins axis_combiner_0/S01_AXIS]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_dma_1/M_AXI_MM2S] [get_bd_intf_pins axi_protocol_convert_3/S_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_S2MM [get_bd_intf_pins axi_dma_1/M_AXI_S2MM] [get_bd_intf_pins axi_protocol_convert_2/S_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_0_M_AXI [get_bd_intf_pins axi_protocol_convert_0/M_AXI] [get_bd_intf_pins hbm_0/SAXI_00]
  connect_bd_intf_net -intf_net axi_protocol_convert_1_M_AXI [get_bd_intf_pins axi_protocol_convert_1/M_AXI] [get_bd_intf_pins hbm_0/SAXI_01]
  connect_bd_intf_net -intf_net axi_protocol_convert_2_M_AXI [get_bd_intf_pins axi_protocol_convert_2/M_AXI] [get_bd_intf_pins hbm_0/SAXI_02]
  connect_bd_intf_net -intf_net axi_protocol_convert_3_M_AXI [get_bd_intf_pins axi_protocol_convert_3/M_AXI] [get_bd_intf_pins hbm_0/SAXI_03]
  connect_bd_intf_net -intf_net axi_traffic_gen_0_M_AXIS_MASTER [get_bd_intf_pins axi_traffic_gen_0/M_AXIS_MASTER] [get_bd_intf_pins axis_broadcaster_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_broadcaster_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM] [get_bd_intf_pins axis_broadcaster_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_combiner_0_M_AXIS [get_bd_intf_pins axis_combiner_0/M_AXIS] [get_bd_intf_pins axis_dwidth_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_0_M_AXIS [get_bd_intf_pins Stream_sink_0/S00_AXIS] [get_bd_intf_pins axis_dwidth_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_DLMB [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins axi_traffic_gen_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins axi_dma_0/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_dma_1/S_AXI_LITE] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net sysclk0_1 [get_bd_intf_ports sysclk0] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]

  # Create port connections
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins rst_clk_wiz_1_100M/dcm_locked]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins Stream_sink_0/s00_axis_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_dma_1/m_axi_mm2s_aclk] [get_bd_pins axi_dma_1/m_axi_s2mm_aclk] [get_bd_pins axi_dma_1/s_axi_lite_aclk] [get_bd_pins axi_protocol_convert_0/aclk] [get_bd_pins axi_protocol_convert_1/aclk] [get_bd_pins axi_protocol_convert_2/aclk] [get_bd_pins axi_protocol_convert_3/aclk] [get_bd_pins axi_traffic_gen_0/s_axi_aclk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_combiner_0/aclk] [get_bd_pins axis_dwidth_converter_0/aclk] [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins hbm_0/APB_0_PCLK] [get_bd_pins hbm_0/APB_1_PCLK] [get_bd_pins hbm_0/AXI_00_ACLK] [get_bd_pins hbm_0/AXI_01_ACLK] [get_bd_pins hbm_0/AXI_02_ACLK] [get_bd_pins hbm_0/AXI_03_ACLK] [get_bd_pins hbm_0/HBM_REF_CLK_0] [get_bd_pins hbm_0/HBM_REF_CLK_1] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net resetn_1 [get_bd_ports resetn] [get_bd_pins resetn_inv_0/Op1] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net resetn_inv_0_Res [get_bd_pins clk_wiz_1/reset] [get_bd_pins resetn_inv_0/Res]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_clk_wiz_1_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins Stream_sink_0/s00_axis_aresetn] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_dma_1/axi_resetn] [get_bd_pins axi_protocol_convert_0/aresetn] [get_bd_pins axi_protocol_convert_1/aresetn] [get_bd_pins axi_protocol_convert_2/aresetn] [get_bd_pins axi_protocol_convert_3/aresetn] [get_bd_pins axi_traffic_gen_0/s_axi_aresetn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_combiner_0/aresetn] [get_bd_pins axis_dwidth_converter_0/aresetn] [get_bd_pins hbm_0/APB_0_PRESET_N] [get_bd_pins hbm_0/APB_1_PRESET_N] [get_bd_pins hbm_0/AXI_00_ARESET_N] [get_bd_pins hbm_0/AXI_01_ARESET_N] [get_bd_pins hbm_0/AXI_02_ARESET_N] [get_bd_pins hbm_0/AXI_03_ARESET_N] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]

  # Create address segments
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM00] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM07] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM08] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM09] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM10] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM11] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM12] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM13] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM14] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM15] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM15] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM23] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM24] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM24] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM25] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM25] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM26] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM26] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM27] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM27] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM28] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM28] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM29] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM29] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM30] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM30] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_01/HBM_MEM31] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_00/HBM_MEM31] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM00] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM07] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM08] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM09] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM10] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM11] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM12] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM13] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM14] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM15] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM15] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM23] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM24] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM24] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM25] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM25] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM26] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM26] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM27] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM27] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM28] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM28] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM29] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM29] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM30] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM30] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_MM2S] [get_bd_addr_segs hbm_0/SAXI_03/HBM_MEM31] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs hbm_0/SAXI_02/HBM_MEM31] -force
  assign_bd_address -offset 0x41E00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41E10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_traffic_gen_0/S_AXI/Reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


