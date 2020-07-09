
################################################################
# This is a generated script based on design: Circular_Buffer
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
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source Circular_Buffer_script.tcl

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
set design_name Circular_Buffer

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
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

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

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
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
  create_bd_pin -dir I -type clk Clk
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
  connect_bd_net -net microblaze_0_Clk [get_bd_pins Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

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
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
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
  set core_ext_start_0 [ create_bd_port -dir I core_ext_start_0 ]
  set core_ext_stop_0 [ create_bd_port -dir I core_ext_stop_0 ]
  set resetn [ create_bd_port -dir I -type rst resetn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $resetn

  # Create instance: CLK_Gen, and set properties
  set CLK_Gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 CLK_Gen ]
  set_property -dict [ list \
   CONFIG.AUTO_PRIMITIVE {MMCM} \
   CONFIG.CLKOUT1_DRIVES {BUFGCE} \
   CONFIG.CLKOUT1_JITTER {110.209} \
   CONFIG.CLKOUT1_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {250.000} \
   CONFIG.CLKOUT2_DRIVES {BUFGCE} \
   CONFIG.CLKOUT2_JITTER {130.958} \
   CONFIG.CLKOUT2_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_DRIVES {BUFGCE} \
   CONFIG.CLKOUT3_JITTER {97.082} \
   CONFIG.CLKOUT3_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {450.000} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.CLKOUT4_DRIVES {BUFGCE} \
   CONFIG.CLKOUT5_DRIVES {BUFGCE} \
   CONFIG.CLKOUT6_DRIVES {BUFGCE} \
   CONFIG.CLKOUT7_DRIVES {BUFGCE} \
   CONFIG.CLK_IN1_BOARD_INTERFACE {sysclk0} \
   CONFIG.CLK_OUT1_PORT {main_clk} \
   CONFIG.CLK_OUT2_PORT {APB_clk} \
   CONFIG.CLK_OUT3_PORT {AXI_clk} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.MMCM_BANDWIDTH {OPTIMIZED} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {10.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {4.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {10} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {2} \
   CONFIG.MMCM_COMPENSATION {AUTO} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
   CONFIG.USE_LOCKED {true} \
   CONFIG.USE_RESET {true} \
   CONFIG.USE_SAFE_CLOCK_STARTUP {true} \
 ] $CLK_Gen

  # Create instance: HBM, and set properties
  set HBM [ create_bd_cell -type ip -vlnv xilinx.com:ip:hbm:1.0 HBM ]
  set_property -dict [ list \
   CONFIG.HBM_MMCM1_FBOUT_MULT0 {18} \
   CONFIG.HBM_MMCM_FBOUT_MULT0 {18} \
   CONFIG.USER_APB_EN {false} \
   CONFIG.USER_AXI_CLK1_FREQ {450} \
   CONFIG.USER_AXI_CLK_FREQ {450} \
   CONFIG.USER_CLK_SEL_LIST0 {AXI_00_ACLK} \
   CONFIG.USER_CLK_SEL_LIST1 {AXI_16_ACLK} \
   CONFIG.USER_DFI_CLK0_FREQ {450.000} \
   CONFIG.USER_DFI_CLK1_FREQ {450.000} \
   CONFIG.USER_HBM_CP_0 {6} \
   CONFIG.USER_HBM_CP_1 {6} \
   CONFIG.USER_HBM_DENSITY {8GB} \
   CONFIG.USER_HBM_FBDIV_0 {36} \
   CONFIG.USER_HBM_FBDIV_1 {36} \
   CONFIG.USER_HBM_HEX_CP_RES_0 {0x0000A600} \
   CONFIG.USER_HBM_HEX_CP_RES_1 {0x0000A600} \
   CONFIG.USER_HBM_HEX_FBDIV_CLKOUTDIV_0 {0x00000902} \
   CONFIG.USER_HBM_HEX_FBDIV_CLKOUTDIV_1 {0x00000902} \
   CONFIG.USER_HBM_HEX_LOCK_FB_REF_DLY_0 {0x00001f1f} \
   CONFIG.USER_HBM_HEX_LOCK_FB_REF_DLY_1 {0x00001f1f} \
   CONFIG.USER_HBM_LOCK_FB_DLY_0 {31} \
   CONFIG.USER_HBM_LOCK_FB_DLY_1 {31} \
   CONFIG.USER_HBM_LOCK_REF_DLY_0 {31} \
   CONFIG.USER_HBM_LOCK_REF_DLY_1 {31} \
   CONFIG.USER_HBM_REF_CLK_0 {100} \
   CONFIG.USER_HBM_REF_CLK_1 {100} \
   CONFIG.USER_HBM_REF_CLK_PS_0 {5000.00} \
   CONFIG.USER_HBM_REF_CLK_PS_1 {5000.00} \
   CONFIG.USER_HBM_REF_CLK_XDC_0 {10.00} \
   CONFIG.USER_HBM_REF_CLK_XDC_1 {10.00} \
   CONFIG.USER_HBM_REF_OUT_CLK_0 {1800} \
   CONFIG.USER_HBM_REF_OUT_CLK_1 {1800} \
   CONFIG.USER_HBM_RES_0 {10} \
   CONFIG.USER_HBM_RES_1 {10} \
   CONFIG.USER_HBM_STACK {2} \
   CONFIG.USER_HBM_TCK_0 {900} \
   CONFIG.USER_HBM_TCK_0_PERIOD {1.1111111111111112} \
   CONFIG.USER_HBM_TCK_1 {900} \
   CONFIG.USER_HBM_TCK_1_PERIOD {1.1111111111111112} \
   CONFIG.USER_LINE_RATE_0 {div4} \
   CONFIG.USER_LINE_RATE_1 {div4} \
   CONFIG.USER_LINE_RATE_2 {div4} \
   CONFIG.USER_LINE_RATE_3 {div4} \
   CONFIG.USER_LINE_RATE_4 {div4} \
   CONFIG.USER_LINE_RATE_5 {div4} \
   CONFIG.USER_LINE_RATE_6 {div4} \
   CONFIG.USER_LINE_RATE_7 {div4} \
   CONFIG.USER_LINE_RATE_8 {div4} \
   CONFIG.USER_LINE_RATE_9 {div4} \
   CONFIG.USER_LINE_RATE_10 {div4} \
   CONFIG.USER_LINE_RATE_11 {div4} \
   CONFIG.USER_LINE_RATE_12 {div4} \
   CONFIG.USER_LINE_RATE_13 {div4} \
   CONFIG.USER_LINE_RATE_14 {div4} \
   CONFIG.USER_LINE_RATE_15 {div4} \
   CONFIG.USER_MC0_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC0_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC0_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC0_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC0_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC0_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC0_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC0_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC0_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC0_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC0_REORDER_EN {false} \
   CONFIG.USER_MC0_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC10_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC10_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC10_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC10_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC10_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC10_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC10_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC10_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC10_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC10_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC10_REORDER_EN {false} \
   CONFIG.USER_MC10_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC11_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC11_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC11_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC11_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC11_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC11_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC11_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC11_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC11_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC11_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC11_REORDER_EN {false} \
   CONFIG.USER_MC11_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC12_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC12_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC12_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC12_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC12_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC12_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC12_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC12_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC12_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC12_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC12_REORDER_EN {false} \
   CONFIG.USER_MC12_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC13_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC13_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC13_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC13_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC13_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC13_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC13_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC13_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC13_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC13_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC13_REORDER_EN {false} \
   CONFIG.USER_MC13_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC14_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC14_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC14_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC14_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC14_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC14_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC14_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC14_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC14_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC14_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC14_REORDER_EN {false} \
   CONFIG.USER_MC14_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC15_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC15_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC15_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC15_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC15_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC15_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC15_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC15_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC15_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC15_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC15_REORDER_EN {false} \
   CONFIG.USER_MC15_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC1_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC1_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC1_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC1_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC1_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC1_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC1_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC1_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC1_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC1_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC1_REORDER_EN {false} \
   CONFIG.USER_MC1_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC2_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC2_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC2_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC2_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC2_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC2_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC2_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC2_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC2_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC2_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC2_REORDER_EN {false} \
   CONFIG.USER_MC2_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC3_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC3_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC3_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC3_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC3_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC3_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC3_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC3_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC3_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC3_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC3_REORDER_EN {false} \
   CONFIG.USER_MC3_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC4_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC4_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC4_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC4_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC4_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC4_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC4_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC4_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC4_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC4_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC4_REORDER_EN {false} \
   CONFIG.USER_MC4_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC5_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC5_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC5_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC5_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC5_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC5_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC5_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC5_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC5_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC5_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC5_REORDER_EN {false} \
   CONFIG.USER_MC5_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC6_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC6_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC6_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC6_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC6_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC6_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC6_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC6_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC6_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC6_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC6_REORDER_EN {false} \
   CONFIG.USER_MC6_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC7_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC7_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC7_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC7_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC7_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC7_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC7_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC7_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC7_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC7_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC7_REORDER_EN {false} \
   CONFIG.USER_MC7_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC8_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC8_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC8_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC8_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC8_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC8_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC8_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC8_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC8_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC8_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC8_REORDER_EN {false} \
   CONFIG.USER_MC8_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC9_ADDR_BIT {RA13,RA12,RA11,RA10,RA9,RA8,RA7,RA6,RA5,RA4,RA3,RA2,RA1,RA0,BG1,BA1,BA0,CA5,CA4,CA3,CA2,CA1,BG0} \
   CONFIG.USER_MC9_BG_INTERLEAVE_EN {true} \
   CONFIG.USER_MC9_CA0_CA5_MAP {0x1c61440c0} \
   CONFIG.USER_MC9_LADDR_BA0_BA4_MAP {0x00282248} \
   CONFIG.USER_MC9_LADDR_CA0_CA4_MAP {0xc61440c0} \
   CONFIG.USER_MC9_LOOKAHEAD_ACT {true} \
   CONFIG.USER_MC9_LOOKAHEAD_PCH {true} \
   CONFIG.USER_MC9_MAINTAIN_COHERENCY {true} \
   CONFIG.USER_MC9_MANUAL_ADDR_MAP_SEL {false} \
   CONFIG.USER_MC9_REF_CMD_PERIOD {0x0DB6} \
   CONFIG.USER_MC9_REORDER_EN {false} \
   CONFIG.USER_MC9_REORDER_QUEUE_EN {false} \
   CONFIG.USER_MC_ENABLE_07 {TRUE} \
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
   CONFIG.USER_SAXI_01 {true} \
   CONFIG.USER_SAXI_02 {false} \
   CONFIG.USER_SAXI_03 {false} \
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
   CONFIG.USER_SAXI_16 {true} \
   CONFIG.USER_SAXI_17 {true} \
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
   CONFIG.USER_SWITCH_ENABLE_01 {TRUE} \
   CONFIG.USER_TEMP_POLL_CNT_0 {100000000} \
   CONFIG.USER_TEMP_POLL_CNT_1 {100000000} \
   CONFIG.USER_TEMP_POLL_PERIOD_0 {1000} \
   CONFIG.USER_TEMP_POLL_PERIOD_1 {1000} \
   CONFIG.USER_XSDB_INTF_EN {FALSE} \
   CONFIG.USER_tFAW_0 {0x00F} \
   CONFIG.USER_tFAW_1 {0x00F} \
   CONFIG.USER_tRAS_0 {0x1E} \
   CONFIG.USER_tRAS_1 {0x1E} \
   CONFIG.USER_tRCDRD_0 {0x0D} \
   CONFIG.USER_tRCDRD_1 {0x0D} \
   CONFIG.USER_tRCDWR_0 {0x09} \
   CONFIG.USER_tRCDWR_1 {0x09} \
   CONFIG.USER_tRC_0 {0x2B} \
   CONFIG.USER_tRC_1 {0x2B} \
   CONFIG.USER_tRFCSB_0 {0x90} \
   CONFIG.USER_tRFCSB_1 {0x90} \
   CONFIG.USER_tRFC_0 {0x0EA} \
   CONFIG.USER_tRFC_1 {0x0EA} \
   CONFIG.USER_tRP_0 {0x0D} \
   CONFIG.USER_tRP_1 {0x0D} \
   CONFIG.USER_tRRDL_0 {0x04} \
   CONFIG.USER_tRRDL_1 {0x04} \
   CONFIG.USER_tRRDS_0 {0x04} \
   CONFIG.USER_tRRDS_1 {0x04} \
   CONFIG.USER_tRREFD_0 {0x8} \
   CONFIG.USER_tRREFD_1 {0x8} \
   CONFIG.USER_tWR_0 {0x0F} \
   CONFIG.USER_tWR_1 {0x0F} \
   CONFIG.USER_tWTRL_0 {0x8} \
   CONFIG.USER_tWTRL_1 {0x8} \
   CONFIG.USER_tWTRS_0 {0x4} \
   CONFIG.USER_tWTRS_1 {0x4} \
   CONFIG.USER_tXP_0 {0x07} \
   CONFIG.USER_tXP_1 {0x07} \
 ] $HBM

  # Create instance: MB_Debug, and set properties
  set MB_Debug [ create_bd_cell -type ip -vlnv user.org:user:MB_Debug:1.0 MB_Debug ]

  # Create instance: MB_controller, and set properties
  set MB_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 MB_controller ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {0} \
   CONFIG.C_DCACHE_ADDR_TAG {0} \
   CONFIG.C_DEBUG_ENABLED {0} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_FSL_LINKS {0} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_TRACE {1} \
   CONFIG.C_USE_DCACHE {0} \
   CONFIG.C_USE_ICACHE {0} \
 ] $MB_controller

  # Create instance: MBlaze_Interconnect, and set properties
  set MBlaze_Interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 MBlaze_Interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $MBlaze_Interconnect

  # Create instance: Stream_sink_0, and set properties
  set Stream_sink_0 [ create_bd_cell -type ip -vlnv user.org:user:Stream_sink:1.0 Stream_sink_0 ]
  set_property -dict [ list \
   CONFIG.C_S00_AXIS_TDATA_WIDTH {256} \
 ] $Stream_sink_0

  # Create instance: axi_dma_0, and set properties
  set axi_dma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_0 ]
  set_property -dict [ list \
   CONFIG.c_addr_width {33} \
   CONFIG.c_enable_multi_channel {0} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_s2mm_dre {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {256} \
   CONFIG.c_m_axi_s2mm_data_width {256} \
   CONFIG.c_m_axis_mm2s_tdata_width {256} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_num_s2mm_channels {1} \
   CONFIG.c_s_axis_s2mm_tdata_width {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {24} \
 ] $axi_dma_0

  # Create instance: axi_protocol_convert_0, and set properties
  set axi_protocol_convert_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_0 ]

  # Create instance: axi_protocol_convert_1, and set properties
  set axi_protocol_convert_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_1 ]

  # Create instance: axi_protocol_convert_2, and set properties
  set axi_protocol_convert_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_2 ]

  # Create instance: axi_protocol_convert_3, and set properties
  set axi_protocol_convert_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_convert_3 ]

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]

  # Create instance: main_dma, and set properties
  set main_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 main_dma ]
  set_property -dict [ list \
   CONFIG.c_addr_width {33} \
   CONFIG.c_enable_multi_channel {0} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {1} \
   CONFIG.c_include_s2mm_dre {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {256} \
   CONFIG.c_m_axi_s2mm_data_width {256} \
   CONFIG.c_m_axis_mm2s_tdata_width {256} \
   CONFIG.c_mm2s_burst_size {16} \
   CONFIG.c_num_s2mm_channels {1} \
   CONFIG.c_s_axis_s2mm_tdata_width {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {24} \
 ] $main_dma

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: reset_gen, and set properties
  set reset_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 reset_gen ]
  set_property -dict [ list \
   CONFIG.RESET_BOARD_INTERFACE {resetn} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $reset_gen

  # Create instance: resetn_inv, and set properties
  set resetn_inv [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 resetn_inv ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $resetn_inv

  # Create instance: traffic_gen, and set properties
  set traffic_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_traffic_gen:3.0 traffic_gen ]
  set_property -dict [ list \
   CONFIG.ATG_OPTIONS {Custom} \
   CONFIG.C_ATG_MODE {AXI4-Stream} \
   CONFIG.C_AXIS_MODE {Master Only} \
   CONFIG.C_AXIS_SPARSE_EN {false} \
   CONFIG.C_AXIS_TDATA_WIDTH {256} \
   CONFIG.C_AXIS_TDEST_WIDTH {0} \
   CONFIG.C_AXIS_TID_WIDTH {0} \
   CONFIG.C_AXIS_TUSER_WIDTH {0} \
   CONFIG.DATA_READ_SHARE {0} \
   CONFIG.DATA_SIZE_AVG {16} \
   CONFIG.DATA_TRAFFIC_PATTERN {Fixed} \
   CONFIG.DATA_TRANS_TYPE {Read_Write} \
   CONFIG.DATA_WRITE_SHARE {100} \
   CONFIG.TRAFFIC_PROFILE {Video} \
 ] $traffic_gen

  # Create interface connections
  connect_bd_intf_net -intf_net axi_dma_0_M_AXIS_MM2S [get_bd_intf_pins Stream_sink_0/S00_AXIS] [get_bd_intf_pins main_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_MM2S [get_bd_intf_pins axi_protocol_convert_0/S_AXI] [get_bd_intf_pins main_dma/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_dma_0_M_AXI_S2MM [get_bd_intf_pins axi_protocol_convert_1/S_AXI] [get_bd_intf_pins main_dma/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXIS_MM2S [get_bd_intf_pins axi_dma_0/M_AXIS_MM2S] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_MM2S [get_bd_intf_pins axi_dma_0/M_AXI_MM2S] [get_bd_intf_pins axi_protocol_convert_3/S_AXI]
  connect_bd_intf_net -intf_net axi_dma_1_M_AXI_S2MM [get_bd_intf_pins axi_dma_0/M_AXI_S2MM] [get_bd_intf_pins axi_protocol_convert_2/S_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_0_M_AXI [get_bd_intf_pins HBM/SAXI_16] [get_bd_intf_pins axi_protocol_convert_0/M_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_1_M_AXI [get_bd_intf_pins HBM/SAXI_00] [get_bd_intf_pins axi_protocol_convert_1/M_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_2_M_AXI [get_bd_intf_pins HBM/SAXI_17] [get_bd_intf_pins axi_protocol_convert_2/M_AXI]
  connect_bd_intf_net -intf_net axi_protocol_convert_3_M_AXI [get_bd_intf_pins HBM/SAXI_01] [get_bd_intf_pins axi_protocol_convert_3/M_AXI]
  connect_bd_intf_net -intf_net axi_traffic_gen_0_M_AXIS_MASTER [get_bd_intf_pins main_dma/S_AXIS_S2MM] [get_bd_intf_pins traffic_gen/M_AXIS_MASTER]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axi_dma_0/S_AXIS_S2MM] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins MB_controller/M_AXI_DP] [get_bd_intf_pins MBlaze_Interconnect/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins MBlaze_Interconnect/M00_AXI] [get_bd_intf_pins main_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins MBlaze_Interconnect/M01_AXI] [get_bd_intf_pins traffic_gen/S_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins MB_Debug/S00_AXI_input] [get_bd_intf_pins MBlaze_Interconnect/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins MBlaze_Interconnect/M03_AXI] [get_bd_intf_pins axi_dma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins MB_controller/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins MB_controller/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net sysclk0_1 [get_bd_intf_ports sysclk0] [get_bd_intf_pins CLK_Gen/CLK_IN1_D]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins CLK_Gen/APB_clk] [get_bd_pins HBM/APB_0_PCLK] [get_bd_pins HBM/APB_1_PCLK]
  connect_bd_net -net clk_wiz_0_main_clk [get_bd_pins CLK_Gen/main_clk] [get_bd_pins HBM/AXI_00_ACLK] [get_bd_pins HBM/AXI_01_ACLK] [get_bd_pins HBM/AXI_16_ACLK] [get_bd_pins HBM/AXI_17_ACLK] [get_bd_pins HBM/HBM_REF_CLK_0] [get_bd_pins HBM/HBM_REF_CLK_1] [get_bd_pins MB_Debug/s00_axi_input_aclk] [get_bd_pins MB_controller/Clk] [get_bd_pins MBlaze_Interconnect/ACLK] [get_bd_pins MBlaze_Interconnect/M00_ACLK] [get_bd_pins MBlaze_Interconnect/M01_ACLK] [get_bd_pins MBlaze_Interconnect/M02_ACLK] [get_bd_pins MBlaze_Interconnect/M03_ACLK] [get_bd_pins MBlaze_Interconnect/S00_ACLK] [get_bd_pins Stream_sink_0/s00_axis_aclk] [get_bd_pins axi_dma_0/m_axi_mm2s_aclk] [get_bd_pins axi_dma_0/m_axi_s2mm_aclk] [get_bd_pins axi_dma_0/s_axi_lite_aclk] [get_bd_pins axi_protocol_convert_0/aclk] [get_bd_pins axi_protocol_convert_1/aclk] [get_bd_pins axi_protocol_convert_2/aclk] [get_bd_pins axi_protocol_convert_3/aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins main_dma/m_axi_mm2s_aclk] [get_bd_pins main_dma/m_axi_s2mm_aclk] [get_bd_pins main_dma/s_axi_lite_aclk] [get_bd_pins microblaze_0_local_memory/Clk] [get_bd_pins reset_gen/slowest_sync_clk] [get_bd_pins traffic_gen/s_axi_aclk]
  connect_bd_net -net core_ext_start_0_1 [get_bd_ports core_ext_start_0] [get_bd_pins traffic_gen/core_ext_start]
  connect_bd_net -net core_ext_stop_0_1 [get_bd_ports core_ext_stop_0] [get_bd_pins traffic_gen/core_ext_stop]
  connect_bd_net -net resetn_1 [get_bd_ports resetn] [get_bd_pins reset_gen/ext_reset_in] [get_bd_pins resetn_inv/Op1]
  connect_bd_net -net resetn_inv_0_Res [get_bd_pins CLK_Gen/reset] [get_bd_pins resetn_inv/Res]
  connect_bd_net -net rst_Clk_100M_mb_reset [get_bd_pins MB_controller/Reset] [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins reset_gen/mb_reset]
  connect_bd_net -net rst_Clk_100M_peripheral_aresetn [get_bd_pins HBM/APB_0_PRESET_N] [get_bd_pins HBM/APB_1_PRESET_N] [get_bd_pins HBM/AXI_00_ARESET_N] [get_bd_pins HBM/AXI_01_ARESET_N] [get_bd_pins HBM/AXI_16_ARESET_N] [get_bd_pins HBM/AXI_17_ARESET_N] [get_bd_pins MB_Debug/s00_axi_input_aresetn] [get_bd_pins MBlaze_Interconnect/ARESETN] [get_bd_pins MBlaze_Interconnect/M00_ARESETN] [get_bd_pins MBlaze_Interconnect/M01_ARESETN] [get_bd_pins MBlaze_Interconnect/M02_ARESETN] [get_bd_pins MBlaze_Interconnect/M03_ARESETN] [get_bd_pins MBlaze_Interconnect/S00_ARESETN] [get_bd_pins Stream_sink_0/s00_axis_aresetn] [get_bd_pins axi_dma_0/axi_resetn] [get_bd_pins axi_protocol_convert_0/aresetn] [get_bd_pins axi_protocol_convert_1/aresetn] [get_bd_pins axi_protocol_convert_2/aresetn] [get_bd_pins axi_protocol_convert_3/aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins main_dma/axi_resetn] [get_bd_pins reset_gen/peripheral_aresetn] [get_bd_pins traffic_gen/s_axi_aresetn]

  # Create address segments
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces MB_controller/Data] [get_bd_addr_segs MB_Debug/S00_AXI_input/S00_AXI_input_reg] -force
  assign_bd_address -offset 0x41E00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces MB_controller/Data] [get_bd_addr_segs main_dma/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x41E10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces MB_controller/Data] [get_bd_addr_segs axi_dma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces MB_controller/Data] [get_bd_addr_segs traffic_gen/S_AXI/Reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -target_address_space [get_bd_addr_spaces MB_controller/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -target_address_space [get_bd_addr_spaces MB_controller/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM00] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM07] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM08] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM09] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM10] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM11] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM12] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM13] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM14] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM15] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM15] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM23] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM24] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM24] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM25] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM25] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM26] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM26] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM27] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM27] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM28] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM28] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM29] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM29] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM30] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM30] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_MM2S] [get_bd_addr_segs HBM/SAXI_01/HBM_MEM31] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_dma_0/Data_S2MM] [get_bd_addr_segs HBM/SAXI_17/HBM_MEM31] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM00] -force
  assign_bd_address -offset 0x08000000 -range 0x08000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM00] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM01] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM01] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM02] -force
  assign_bd_address -offset 0x20000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM02] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM03] -force
  assign_bd_address -offset 0x30000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM03] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM04] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM04] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM05] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM05] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM06] -force
  assign_bd_address -offset 0x60000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM06] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM07] -force
  assign_bd_address -offset 0x70000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM07] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM08] -force
  assign_bd_address -offset 0x80000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM08] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM09] -force
  assign_bd_address -offset 0x90000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM09] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM10] -force
  assign_bd_address -offset 0xA0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM10] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM11] -force
  assign_bd_address -offset 0xB0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM11] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM12] -force
  assign_bd_address -offset 0xC0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM12] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM13] -force
  assign_bd_address -offset 0xD0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM13] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM14] -force
  assign_bd_address -offset 0xE0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM14] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM15] -force
  assign_bd_address -offset 0xF0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM15] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM16] -force
  assign_bd_address -offset 0x000100000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM16] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM17] -force
  assign_bd_address -offset 0x000110000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM17] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM18] -force
  assign_bd_address -offset 0x000120000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM18] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM19] -force
  assign_bd_address -offset 0x000130000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM19] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM20] -force
  assign_bd_address -offset 0x000140000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM20] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM21] -force
  assign_bd_address -offset 0x000150000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM21] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM22] -force
  assign_bd_address -offset 0x000160000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM22] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM23] -force
  assign_bd_address -offset 0x000170000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM23] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM24] -force
  assign_bd_address -offset 0x000180000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM24] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM25] -force
  assign_bd_address -offset 0x000190000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM25] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM26] -force
  assign_bd_address -offset 0x0001A0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM26] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM27] -force
  assign_bd_address -offset 0x0001B0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM27] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM28] -force
  assign_bd_address -offset 0x0001C0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM28] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM29] -force
  assign_bd_address -offset 0x0001D0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM29] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM30] -force
  assign_bd_address -offset 0x0001E0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM30] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_MM2S] [get_bd_addr_segs HBM/SAXI_16/HBM_MEM31] -force
  assign_bd_address -offset 0x0001F0000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces main_dma/Data_S2MM] [get_bd_addr_segs HBM/SAXI_00/HBM_MEM31] -force


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


