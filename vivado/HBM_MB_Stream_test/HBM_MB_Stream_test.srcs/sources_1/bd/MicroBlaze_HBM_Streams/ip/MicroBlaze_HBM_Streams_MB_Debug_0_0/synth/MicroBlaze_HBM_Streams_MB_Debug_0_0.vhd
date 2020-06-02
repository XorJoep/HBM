-- (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: user.org:user:MB_Debug:1.0
-- IP Revision: 6

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MicroBlaze_HBM_Streams_MB_Debug_0_0 IS
  PORT (
    status_out_0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    status_out_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    status_out_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    status_out_3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_input_aclk : IN STD_LOGIC;
    s00_axi_input_aresetn : IN STD_LOGIC;
    s00_axi_input_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_input_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_input_awvalid : IN STD_LOGIC;
    s00_axi_input_awready : OUT STD_LOGIC;
    s00_axi_input_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_input_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_input_wvalid : IN STD_LOGIC;
    s00_axi_input_wready : OUT STD_LOGIC;
    s00_axi_input_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_input_bvalid : OUT STD_LOGIC;
    s00_axi_input_bready : IN STD_LOGIC;
    s00_axi_input_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s00_axi_input_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s00_axi_input_arvalid : IN STD_LOGIC;
    s00_axi_input_arready : OUT STD_LOGIC;
    s00_axi_input_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s00_axi_input_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s00_axi_input_rvalid : OUT STD_LOGIC;
    s00_axi_input_rready : IN STD_LOGIC
  );
END MicroBlaze_HBM_Streams_MB_Debug_0_0;

ARCHITECTURE MicroBlaze_HBM_Streams_MB_Debug_0_0_arch OF MicroBlaze_HBM_Streams_MB_Debug_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF MicroBlaze_HBM_Streams_MB_Debug_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT MB_Debug_v1_0 IS
    GENERIC (
      C_S00_AXI_input_DATA_WIDTH : INTEGER; -- Width of S_AXI data bus
      C_S00_AXI_input_ADDR_WIDTH : INTEGER -- Width of S_AXI address bus
    );
    PORT (
      status_out_0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      status_out_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      status_out_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      status_out_3 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_input_aclk : IN STD_LOGIC;
      s00_axi_input_aresetn : IN STD_LOGIC;
      s00_axi_input_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_input_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_input_awvalid : IN STD_LOGIC;
      s00_axi_input_awready : OUT STD_LOGIC;
      s00_axi_input_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_input_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_input_wvalid : IN STD_LOGIC;
      s00_axi_input_wready : OUT STD_LOGIC;
      s00_axi_input_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_input_bvalid : OUT STD_LOGIC;
      s00_axi_input_bready : IN STD_LOGIC;
      s00_axi_input_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s00_axi_input_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      s00_axi_input_arvalid : IN STD_LOGIC;
      s00_axi_input_arready : OUT STD_LOGIC;
      s00_axi_input_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s00_axi_input_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s00_axi_input_rvalid : OUT STD_LOGIC;
      s00_axi_input_rready : IN STD_LOGIC
    );
  END COMPONENT MB_Debug_v1_0;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF MicroBlaze_HBM_Streams_MB_Debug_0_0_arch: ARCHITECTURE IS "MB_Debug_v1_0,Vivado 2019.2.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF MicroBlaze_HBM_Streams_MB_Debug_0_0_arch : ARCHITECTURE IS "MicroBlaze_HBM_Streams_MB_Debug_0_0,MB_Debug_v1_0,{}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input AWPROT";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_input_awaddr: SIGNAL IS "XIL_INTERFACENAME S00_AXI_input, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN MicroBlaze_HBM_Stre" & 
"ams_clk_wiz_0_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 S00_AXI_input AWADDR";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_input_aresetn: SIGNAL IS "XIL_INTERFACENAME S00_AXI_input_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_aresetn: SIGNAL IS "xilinx.com:signal:reset:1.0 S00_AXI_input_RST RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF s00_axi_input_aclk: SIGNAL IS "XIL_INTERFACENAME S00_AXI_input_CLK, ASSOCIATED_BUSIF S00_AXI_input, ASSOCIATED_RESET s00_axi_input_aresetn, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN MicroBlaze_HBM_Streams_clk_wiz_0_0_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF s00_axi_input_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 S00_AXI_input_CLK CLK";
BEGIN
  U0 : MB_Debug_v1_0
    GENERIC MAP (
      C_S00_AXI_input_DATA_WIDTH => 32,
      C_S00_AXI_input_ADDR_WIDTH => 4
    )
    PORT MAP (
      status_out_0 => status_out_0,
      status_out_1 => status_out_1,
      status_out_2 => status_out_2,
      status_out_3 => status_out_3,
      s00_axi_input_aclk => s00_axi_input_aclk,
      s00_axi_input_aresetn => s00_axi_input_aresetn,
      s00_axi_input_awaddr => s00_axi_input_awaddr,
      s00_axi_input_awprot => s00_axi_input_awprot,
      s00_axi_input_awvalid => s00_axi_input_awvalid,
      s00_axi_input_awready => s00_axi_input_awready,
      s00_axi_input_wdata => s00_axi_input_wdata,
      s00_axi_input_wstrb => s00_axi_input_wstrb,
      s00_axi_input_wvalid => s00_axi_input_wvalid,
      s00_axi_input_wready => s00_axi_input_wready,
      s00_axi_input_bresp => s00_axi_input_bresp,
      s00_axi_input_bvalid => s00_axi_input_bvalid,
      s00_axi_input_bready => s00_axi_input_bready,
      s00_axi_input_araddr => s00_axi_input_araddr,
      s00_axi_input_arprot => s00_axi_input_arprot,
      s00_axi_input_arvalid => s00_axi_input_arvalid,
      s00_axi_input_arready => s00_axi_input_arready,
      s00_axi_input_rdata => s00_axi_input_rdata,
      s00_axi_input_rresp => s00_axi_input_rresp,
      s00_axi_input_rvalid => s00_axi_input_rvalid,
      s00_axi_input_rready => s00_axi_input_rready
    );
END MicroBlaze_HBM_Streams_MB_Debug_0_0_arch;
