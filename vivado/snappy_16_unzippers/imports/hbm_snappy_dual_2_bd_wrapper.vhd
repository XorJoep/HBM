--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Tue Feb 16 14:48:07 2021
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.9.2009 (Core)
--Command     : generate_target hbm_snappy_dual_2_bd_wrapper.bd
--Design      : hbm_snappy_dual_2_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hbm_snappy_dual_2_bd_wrapper is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    m00_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m00_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_arready : in STD_LOGIC;
    m00_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_arvalid : out STD_LOGIC;
    m00_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m00_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_awready : in STD_LOGIC;
    m00_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_awvalid : out STD_LOGIC;
    m00_axi_bready : out STD_LOGIC;
    m00_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_bvalid : in STD_LOGIC;
    m00_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_rlast : in STD_LOGIC;
    m00_axi_rready : out STD_LOGIC;
    m00_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_rvalid : in STD_LOGIC;
    m00_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_wlast : out STD_LOGIC;
    m00_axi_wready : in STD_LOGIC;
    m00_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_wvalid : out STD_LOGIC;
    m01_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m01_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_arready : in STD_LOGIC;
    m01_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_arvalid : out STD_LOGIC;
    m01_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m01_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_awready : in STD_LOGIC;
    m01_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_awvalid : out STD_LOGIC;
    m01_axi_bready : out STD_LOGIC;
    m01_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_bvalid : in STD_LOGIC;
    m01_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_rlast : in STD_LOGIC;
    m01_axi_rready : out STD_LOGIC;
    m01_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_rvalid : in STD_LOGIC;
    m01_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_wlast : out STD_LOGIC;
    m01_axi_wready : in STD_LOGIC;
    m01_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_wvalid : out STD_LOGIC;
    m02_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m02_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_arready : in STD_LOGIC;
    m02_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_arvalid : out STD_LOGIC;
    m02_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m02_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_awready : in STD_LOGIC;
    m02_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_awvalid : out STD_LOGIC;
    m02_axi_bready : out STD_LOGIC;
    m02_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_bvalid : in STD_LOGIC;
    m02_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_rlast : in STD_LOGIC;
    m02_axi_rready : out STD_LOGIC;
    m02_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_rvalid : in STD_LOGIC;
    m02_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_wlast : out STD_LOGIC;
    m02_axi_wready : in STD_LOGIC;
    m02_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_wvalid : out STD_LOGIC;
    m03_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m03_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_arready : in STD_LOGIC;
    m03_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_arvalid : out STD_LOGIC;
    m03_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m03_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_awready : in STD_LOGIC;
    m03_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_awvalid : out STD_LOGIC;
    m03_axi_bready : out STD_LOGIC;
    m03_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_bvalid : in STD_LOGIC;
    m03_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_rlast : in STD_LOGIC;
    m03_axi_rready : out STD_LOGIC;
    m03_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_rvalid : in STD_LOGIC;
    m03_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_wlast : out STD_LOGIC;
    m03_axi_wready : in STD_LOGIC;
    m03_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_wvalid : out STD_LOGIC;
    m04_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m04_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_arready : in STD_LOGIC;
    m04_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_arvalid : out STD_LOGIC;
    m04_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m04_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_awready : in STD_LOGIC;
    m04_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_awvalid : out STD_LOGIC;
    m04_axi_bready : out STD_LOGIC;
    m04_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_bvalid : in STD_LOGIC;
    m04_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_rlast : in STD_LOGIC;
    m04_axi_rready : out STD_LOGIC;
    m04_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_rvalid : in STD_LOGIC;
    m04_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_wlast : out STD_LOGIC;
    m04_axi_wready : in STD_LOGIC;
    m04_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_wvalid : out STD_LOGIC;
    m05_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m05_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_arready : in STD_LOGIC;
    m05_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_arvalid : out STD_LOGIC;
    m05_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m05_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_awready : in STD_LOGIC;
    m05_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_awvalid : out STD_LOGIC;
    m05_axi_bready : out STD_LOGIC;
    m05_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_bvalid : in STD_LOGIC;
    m05_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_rlast : in STD_LOGIC;
    m05_axi_rready : out STD_LOGIC;
    m05_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_rvalid : in STD_LOGIC;
    m05_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_wlast : out STD_LOGIC;
    m05_axi_wready : in STD_LOGIC;
    m05_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_wvalid : out STD_LOGIC;
    m06_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m06_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_arready : in STD_LOGIC;
    m06_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_arvalid : out STD_LOGIC;
    m06_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m06_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_awready : in STD_LOGIC;
    m06_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_awvalid : out STD_LOGIC;
    m06_axi_bready : out STD_LOGIC;
    m06_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_bvalid : in STD_LOGIC;
    m06_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_rlast : in STD_LOGIC;
    m06_axi_rready : out STD_LOGIC;
    m06_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_rvalid : in STD_LOGIC;
    m06_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_wlast : out STD_LOGIC;
    m06_axi_wready : in STD_LOGIC;
    m06_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_wvalid : out STD_LOGIC;
    m07_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m07_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_arready : in STD_LOGIC;
    m07_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_arvalid : out STD_LOGIC;
    m07_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m07_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_awready : in STD_LOGIC;
    m07_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_awvalid : out STD_LOGIC;
    m07_axi_bready : out STD_LOGIC;
    m07_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_bvalid : in STD_LOGIC;
    m07_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_rlast : in STD_LOGIC;
    m07_axi_rready : out STD_LOGIC;
    m07_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_rvalid : in STD_LOGIC;
    m07_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_wlast : out STD_LOGIC;
    m07_axi_wready : in STD_LOGIC;
    m07_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_wvalid : out STD_LOGIC;
    m08_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m08_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_arready : in STD_LOGIC;
    m08_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_arvalid : out STD_LOGIC;
    m08_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m08_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_awready : in STD_LOGIC;
    m08_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_awvalid : out STD_LOGIC;
    m08_axi_bready : out STD_LOGIC;
    m08_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_bvalid : in STD_LOGIC;
    m08_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_rlast : in STD_LOGIC;
    m08_axi_rready : out STD_LOGIC;
    m08_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_rvalid : in STD_LOGIC;
    m08_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_wlast : out STD_LOGIC;
    m08_axi_wready : in STD_LOGIC;
    m08_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_wvalid : out STD_LOGIC;
    m09_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m09_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_arready : in STD_LOGIC;
    m09_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_arvalid : out STD_LOGIC;
    m09_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m09_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_awready : in STD_LOGIC;
    m09_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_awvalid : out STD_LOGIC;
    m09_axi_bready : out STD_LOGIC;
    m09_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_bvalid : in STD_LOGIC;
    m09_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_rlast : in STD_LOGIC;
    m09_axi_rready : out STD_LOGIC;
    m09_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_rvalid : in STD_LOGIC;
    m09_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_wlast : out STD_LOGIC;
    m09_axi_wready : in STD_LOGIC;
    m09_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_wvalid : out STD_LOGIC;
    m10_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m10_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_arready : in STD_LOGIC;
    m10_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_arvalid : out STD_LOGIC;
    m10_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m10_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_awready : in STD_LOGIC;
    m10_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_awvalid : out STD_LOGIC;
    m10_axi_bready : out STD_LOGIC;
    m10_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_bvalid : in STD_LOGIC;
    m10_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_rlast : in STD_LOGIC;
    m10_axi_rready : out STD_LOGIC;
    m10_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_rvalid : in STD_LOGIC;
    m10_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_wlast : out STD_LOGIC;
    m10_axi_wready : in STD_LOGIC;
    m10_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_wvalid : out STD_LOGIC;
    m11_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m11_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_arready : in STD_LOGIC;
    m11_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_arvalid : out STD_LOGIC;
    m11_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m11_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_awready : in STD_LOGIC;
    m11_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_awvalid : out STD_LOGIC;
    m11_axi_bready : out STD_LOGIC;
    m11_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_bvalid : in STD_LOGIC;
    m11_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_rlast : in STD_LOGIC;
    m11_axi_rready : out STD_LOGIC;
    m11_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_rvalid : in STD_LOGIC;
    m11_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_wlast : out STD_LOGIC;
    m11_axi_wready : in STD_LOGIC;
    m11_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_wvalid : out STD_LOGIC;
    m12_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m12_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_arready : in STD_LOGIC;
    m12_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_arvalid : out STD_LOGIC;
    m12_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m12_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_awready : in STD_LOGIC;
    m12_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_awvalid : out STD_LOGIC;
    m12_axi_bready : out STD_LOGIC;
    m12_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_bvalid : in STD_LOGIC;
    m12_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_rlast : in STD_LOGIC;
    m12_axi_rready : out STD_LOGIC;
    m12_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_rvalid : in STD_LOGIC;
    m12_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_wlast : out STD_LOGIC;
    m12_axi_wready : in STD_LOGIC;
    m12_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_wvalid : out STD_LOGIC;
    m13_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m13_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_arready : in STD_LOGIC;
    m13_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_arvalid : out STD_LOGIC;
    m13_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m13_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_awready : in STD_LOGIC;
    m13_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_awvalid : out STD_LOGIC;
    m13_axi_bready : out STD_LOGIC;
    m13_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_bvalid : in STD_LOGIC;
    m13_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_rlast : in STD_LOGIC;
    m13_axi_rready : out STD_LOGIC;
    m13_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_rvalid : in STD_LOGIC;
    m13_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_wlast : out STD_LOGIC;
    m13_axi_wready : in STD_LOGIC;
    m13_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_wvalid : out STD_LOGIC;
    m14_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m14_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_arready : in STD_LOGIC;
    m14_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_arvalid : out STD_LOGIC;
    m14_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m14_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_awready : in STD_LOGIC;
    m14_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_awvalid : out STD_LOGIC;
    m14_axi_bready : out STD_LOGIC;
    m14_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_bvalid : in STD_LOGIC;
    m14_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_rlast : in STD_LOGIC;
    m14_axi_rready : out STD_LOGIC;
    m14_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_rvalid : in STD_LOGIC;
    m14_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_wlast : out STD_LOGIC;
    m14_axi_wready : in STD_LOGIC;
    m14_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_wvalid : out STD_LOGIC;
    m15_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m15_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_arready : in STD_LOGIC;
    m15_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_arvalid : out STD_LOGIC;
    m15_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m15_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_awready : in STD_LOGIC;
    m15_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_awvalid : out STD_LOGIC;
    m15_axi_bready : out STD_LOGIC;
    m15_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_bvalid : in STD_LOGIC;
    m15_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_rlast : in STD_LOGIC;
    m15_axi_rready : out STD_LOGIC;
    m15_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_rvalid : in STD_LOGIC;
    m15_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_wlast : out STD_LOGIC;
    m15_axi_wready : in STD_LOGIC;
    m15_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_wvalid : out STD_LOGIC;
    s_axi_control_araddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_control_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_control_arready : out STD_LOGIC;
    s_axi_control_arvalid : in STD_LOGIC;
    s_axi_control_awaddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_control_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_control_awready : out STD_LOGIC;
    s_axi_control_awvalid : in STD_LOGIC;
    s_axi_control_bready : in STD_LOGIC;
    s_axi_control_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_bvalid : out STD_LOGIC;
    s_axi_control_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_rready : in STD_LOGIC;
    s_axi_control_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_rvalid : out STD_LOGIC;
    s_axi_control_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_wready : out STD_LOGIC;
    s_axi_control_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_wvalid : in STD_LOGIC
  );
end hbm_snappy_dual_2_bd_wrapper;

architecture STRUCTURE of hbm_snappy_dual_2_bd_wrapper is
  component hbm_snappy_dual_2_bd is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    m03_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m03_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_arready : in STD_LOGIC;
    m03_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_arvalid : out STD_LOGIC;
    m03_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m03_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_awready : in STD_LOGIC;
    m03_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m03_axi_awvalid : out STD_LOGIC;
    m03_axi_bready : out STD_LOGIC;
    m03_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_bvalid : in STD_LOGIC;
    m03_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_rlast : in STD_LOGIC;
    m03_axi_rready : out STD_LOGIC;
    m03_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m03_axi_rvalid : in STD_LOGIC;
    m03_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m03_axi_wlast : out STD_LOGIC;
    m03_axi_wready : in STD_LOGIC;
    m03_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m03_axi_wvalid : out STD_LOGIC;
    m15_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m15_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_arready : in STD_LOGIC;
    m15_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_arvalid : out STD_LOGIC;
    m15_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m15_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_awready : in STD_LOGIC;
    m15_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m15_axi_awvalid : out STD_LOGIC;
    m15_axi_bready : out STD_LOGIC;
    m15_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_bvalid : in STD_LOGIC;
    m15_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_rlast : in STD_LOGIC;
    m15_axi_rready : out STD_LOGIC;
    m15_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m15_axi_rvalid : in STD_LOGIC;
    m15_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m15_axi_wlast : out STD_LOGIC;
    m15_axi_wready : in STD_LOGIC;
    m15_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m15_axi_wvalid : out STD_LOGIC;
    m02_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m02_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_arready : in STD_LOGIC;
    m02_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_arvalid : out STD_LOGIC;
    m02_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m02_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_awready : in STD_LOGIC;
    m02_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m02_axi_awvalid : out STD_LOGIC;
    m02_axi_bready : out STD_LOGIC;
    m02_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_bvalid : in STD_LOGIC;
    m02_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_rlast : in STD_LOGIC;
    m02_axi_rready : out STD_LOGIC;
    m02_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m02_axi_rvalid : in STD_LOGIC;
    m02_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m02_axi_wlast : out STD_LOGIC;
    m02_axi_wready : in STD_LOGIC;
    m02_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m02_axi_wvalid : out STD_LOGIC;
    m04_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m04_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_arready : in STD_LOGIC;
    m04_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_arvalid : out STD_LOGIC;
    m04_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m04_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_awready : in STD_LOGIC;
    m04_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m04_axi_awvalid : out STD_LOGIC;
    m04_axi_bready : out STD_LOGIC;
    m04_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_bvalid : in STD_LOGIC;
    m04_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_rlast : in STD_LOGIC;
    m04_axi_rready : out STD_LOGIC;
    m04_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m04_axi_rvalid : in STD_LOGIC;
    m04_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m04_axi_wlast : out STD_LOGIC;
    m04_axi_wready : in STD_LOGIC;
    m04_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m04_axi_wvalid : out STD_LOGIC;
    m09_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m09_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_arready : in STD_LOGIC;
    m09_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_arvalid : out STD_LOGIC;
    m09_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m09_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_awready : in STD_LOGIC;
    m09_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m09_axi_awvalid : out STD_LOGIC;
    m09_axi_bready : out STD_LOGIC;
    m09_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_bvalid : in STD_LOGIC;
    m09_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_rlast : in STD_LOGIC;
    m09_axi_rready : out STD_LOGIC;
    m09_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m09_axi_rvalid : in STD_LOGIC;
    m09_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m09_axi_wlast : out STD_LOGIC;
    m09_axi_wready : in STD_LOGIC;
    m09_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m09_axi_wvalid : out STD_LOGIC;
    m13_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m13_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_arready : in STD_LOGIC;
    m13_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_arvalid : out STD_LOGIC;
    m13_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m13_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_awready : in STD_LOGIC;
    m13_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m13_axi_awvalid : out STD_LOGIC;
    m13_axi_bready : out STD_LOGIC;
    m13_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_bvalid : in STD_LOGIC;
    m13_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_rlast : in STD_LOGIC;
    m13_axi_rready : out STD_LOGIC;
    m13_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m13_axi_rvalid : in STD_LOGIC;
    m13_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m13_axi_wlast : out STD_LOGIC;
    m13_axi_wready : in STD_LOGIC;
    m13_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m13_axi_wvalid : out STD_LOGIC;
    m08_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m08_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_arready : in STD_LOGIC;
    m08_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_arvalid : out STD_LOGIC;
    m08_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m08_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_awready : in STD_LOGIC;
    m08_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m08_axi_awvalid : out STD_LOGIC;
    m08_axi_bready : out STD_LOGIC;
    m08_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_bvalid : in STD_LOGIC;
    m08_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_rlast : in STD_LOGIC;
    m08_axi_rready : out STD_LOGIC;
    m08_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m08_axi_rvalid : in STD_LOGIC;
    m08_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m08_axi_wlast : out STD_LOGIC;
    m08_axi_wready : in STD_LOGIC;
    m08_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m08_axi_wvalid : out STD_LOGIC;
    m14_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m14_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_arready : in STD_LOGIC;
    m14_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_arvalid : out STD_LOGIC;
    m14_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m14_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_awready : in STD_LOGIC;
    m14_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m14_axi_awvalid : out STD_LOGIC;
    m14_axi_bready : out STD_LOGIC;
    m14_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_bvalid : in STD_LOGIC;
    m14_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_rlast : in STD_LOGIC;
    m14_axi_rready : out STD_LOGIC;
    m14_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m14_axi_rvalid : in STD_LOGIC;
    m14_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m14_axi_wlast : out STD_LOGIC;
    m14_axi_wready : in STD_LOGIC;
    m14_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m14_axi_wvalid : out STD_LOGIC;
    m01_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m01_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_arready : in STD_LOGIC;
    m01_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_arvalid : out STD_LOGIC;
    m01_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m01_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_awready : in STD_LOGIC;
    m01_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m01_axi_awvalid : out STD_LOGIC;
    m01_axi_bready : out STD_LOGIC;
    m01_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_bvalid : in STD_LOGIC;
    m01_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_rlast : in STD_LOGIC;
    m01_axi_rready : out STD_LOGIC;
    m01_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m01_axi_rvalid : in STD_LOGIC;
    m01_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m01_axi_wlast : out STD_LOGIC;
    m01_axi_wready : in STD_LOGIC;
    m01_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m01_axi_wvalid : out STD_LOGIC;
    m00_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m00_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_arready : in STD_LOGIC;
    m00_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_arvalid : out STD_LOGIC;
    m00_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m00_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_awready : in STD_LOGIC;
    m00_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m00_axi_awvalid : out STD_LOGIC;
    m00_axi_bready : out STD_LOGIC;
    m00_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_bvalid : in STD_LOGIC;
    m00_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_rlast : in STD_LOGIC;
    m00_axi_rready : out STD_LOGIC;
    m00_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m00_axi_rvalid : in STD_LOGIC;
    m00_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m00_axi_wlast : out STD_LOGIC;
    m00_axi_wready : in STD_LOGIC;
    m00_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m00_axi_wvalid : out STD_LOGIC;
    m06_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m06_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_arready : in STD_LOGIC;
    m06_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_arvalid : out STD_LOGIC;
    m06_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m06_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_awready : in STD_LOGIC;
    m06_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m06_axi_awvalid : out STD_LOGIC;
    m06_axi_bready : out STD_LOGIC;
    m06_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_bvalid : in STD_LOGIC;
    m06_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_rlast : in STD_LOGIC;
    m06_axi_rready : out STD_LOGIC;
    m06_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m06_axi_rvalid : in STD_LOGIC;
    m06_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m06_axi_wlast : out STD_LOGIC;
    m06_axi_wready : in STD_LOGIC;
    m06_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m06_axi_wvalid : out STD_LOGIC;
    m05_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m05_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_arready : in STD_LOGIC;
    m05_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_arvalid : out STD_LOGIC;
    m05_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m05_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_awready : in STD_LOGIC;
    m05_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m05_axi_awvalid : out STD_LOGIC;
    m05_axi_bready : out STD_LOGIC;
    m05_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_bvalid : in STD_LOGIC;
    m05_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_rlast : in STD_LOGIC;
    m05_axi_rready : out STD_LOGIC;
    m05_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m05_axi_rvalid : in STD_LOGIC;
    m05_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m05_axi_wlast : out STD_LOGIC;
    m05_axi_wready : in STD_LOGIC;
    m05_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m05_axi_wvalid : out STD_LOGIC;
    m07_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m07_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_arready : in STD_LOGIC;
    m07_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_arvalid : out STD_LOGIC;
    m07_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m07_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_awready : in STD_LOGIC;
    m07_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m07_axi_awvalid : out STD_LOGIC;
    m07_axi_bready : out STD_LOGIC;
    m07_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_bvalid : in STD_LOGIC;
    m07_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_rlast : in STD_LOGIC;
    m07_axi_rready : out STD_LOGIC;
    m07_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m07_axi_rvalid : in STD_LOGIC;
    m07_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m07_axi_wlast : out STD_LOGIC;
    m07_axi_wready : in STD_LOGIC;
    m07_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m07_axi_wvalid : out STD_LOGIC;
    m12_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m12_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_arready : in STD_LOGIC;
    m12_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_arvalid : out STD_LOGIC;
    m12_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m12_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_awready : in STD_LOGIC;
    m12_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m12_axi_awvalid : out STD_LOGIC;
    m12_axi_bready : out STD_LOGIC;
    m12_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_bvalid : in STD_LOGIC;
    m12_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_rlast : in STD_LOGIC;
    m12_axi_rready : out STD_LOGIC;
    m12_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m12_axi_rvalid : in STD_LOGIC;
    m12_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m12_axi_wlast : out STD_LOGIC;
    m12_axi_wready : in STD_LOGIC;
    m12_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m12_axi_wvalid : out STD_LOGIC;
    m10_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m10_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_arready : in STD_LOGIC;
    m10_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_arvalid : out STD_LOGIC;
    m10_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m10_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_awready : in STD_LOGIC;
    m10_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m10_axi_awvalid : out STD_LOGIC;
    m10_axi_bready : out STD_LOGIC;
    m10_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_bvalid : in STD_LOGIC;
    m10_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_rlast : in STD_LOGIC;
    m10_axi_rready : out STD_LOGIC;
    m10_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m10_axi_rvalid : in STD_LOGIC;
    m10_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m10_axi_wlast : out STD_LOGIC;
    m10_axi_wready : in STD_LOGIC;
    m10_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m10_axi_wvalid : out STD_LOGIC;
    m11_axi_araddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m11_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_arready : in STD_LOGIC;
    m11_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_arvalid : out STD_LOGIC;
    m11_axi_awaddr : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m11_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_awready : in STD_LOGIC;
    m11_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m11_axi_awvalid : out STD_LOGIC;
    m11_axi_bready : out STD_LOGIC;
    m11_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_bvalid : in STD_LOGIC;
    m11_axi_rdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_rlast : in STD_LOGIC;
    m11_axi_rready : out STD_LOGIC;
    m11_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m11_axi_rvalid : in STD_LOGIC;
    m11_axi_wdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m11_axi_wlast : out STD_LOGIC;
    m11_axi_wready : in STD_LOGIC;
    m11_axi_wstrb : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m11_axi_wvalid : out STD_LOGIC;
    s_axi_control_araddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_control_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_control_arready : out STD_LOGIC;
    s_axi_control_arvalid : in STD_LOGIC;
    s_axi_control_awaddr : in STD_LOGIC_VECTOR ( 11 downto 0 );
    s_axi_control_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_control_awready : out STD_LOGIC;
    s_axi_control_awvalid : in STD_LOGIC;
    s_axi_control_bready : in STD_LOGIC;
    s_axi_control_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_bvalid : out STD_LOGIC;
    s_axi_control_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_rready : in STD_LOGIC;
    s_axi_control_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_control_rvalid : out STD_LOGIC;
    s_axi_control_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_control_wready : out STD_LOGIC;
    s_axi_control_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_control_wvalid : in STD_LOGIC
  );
  end component hbm_snappy_dual_2_bd;
begin
hbm_snappy_dual_2_bd_i: component hbm_snappy_dual_2_bd
     port map (
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n,
      m00_axi_araddr(63 downto 0) => m00_axi_araddr(63 downto 0),
      m00_axi_arburst(1 downto 0) => m00_axi_arburst(1 downto 0),
      m00_axi_arcache(3 downto 0) => m00_axi_arcache(3 downto 0),
      m00_axi_arlen(7 downto 0) => m00_axi_arlen(7 downto 0),
      m00_axi_arprot(2 downto 0) => m00_axi_arprot(2 downto 0),
      m00_axi_arready => m00_axi_arready,
      m00_axi_arsize(2 downto 0) => m00_axi_arsize(2 downto 0),
      m00_axi_arvalid => m00_axi_arvalid,
      m00_axi_awaddr(63 downto 0) => m00_axi_awaddr(63 downto 0),
      m00_axi_awburst(1 downto 0) => m00_axi_awburst(1 downto 0),
      m00_axi_awcache(3 downto 0) => m00_axi_awcache(3 downto 0),
      m00_axi_awlen(7 downto 0) => m00_axi_awlen(7 downto 0),
      m00_axi_awprot(2 downto 0) => m00_axi_awprot(2 downto 0),
      m00_axi_awready => m00_axi_awready,
      m00_axi_awsize(2 downto 0) => m00_axi_awsize(2 downto 0),
      m00_axi_awvalid => m00_axi_awvalid,
      m00_axi_bready => m00_axi_bready,
      m00_axi_bresp(1 downto 0) => m00_axi_bresp(1 downto 0),
      m00_axi_bvalid => m00_axi_bvalid,
      m00_axi_rdata(63 downto 0) => m00_axi_rdata(63 downto 0),
      m00_axi_rlast => m00_axi_rlast,
      m00_axi_rready => m00_axi_rready,
      m00_axi_rresp(1 downto 0) => m00_axi_rresp(1 downto 0),
      m00_axi_rvalid => m00_axi_rvalid,
      m00_axi_wdata(63 downto 0) => m00_axi_wdata(63 downto 0),
      m00_axi_wlast => m00_axi_wlast,
      m00_axi_wready => m00_axi_wready,
      m00_axi_wstrb(7 downto 0) => m00_axi_wstrb(7 downto 0),
      m00_axi_wvalid => m00_axi_wvalid,
      m01_axi_araddr(63 downto 0) => m01_axi_araddr(63 downto 0),
      m01_axi_arburst(1 downto 0) => m01_axi_arburst(1 downto 0),
      m01_axi_arcache(3 downto 0) => m01_axi_arcache(3 downto 0),
      m01_axi_arlen(7 downto 0) => m01_axi_arlen(7 downto 0),
      m01_axi_arprot(2 downto 0) => m01_axi_arprot(2 downto 0),
      m01_axi_arready => m01_axi_arready,
      m01_axi_arsize(2 downto 0) => m01_axi_arsize(2 downto 0),
      m01_axi_arvalid => m01_axi_arvalid,
      m01_axi_awaddr(63 downto 0) => m01_axi_awaddr(63 downto 0),
      m01_axi_awburst(1 downto 0) => m01_axi_awburst(1 downto 0),
      m01_axi_awcache(3 downto 0) => m01_axi_awcache(3 downto 0),
      m01_axi_awlen(7 downto 0) => m01_axi_awlen(7 downto 0),
      m01_axi_awprot(2 downto 0) => m01_axi_awprot(2 downto 0),
      m01_axi_awready => m01_axi_awready,
      m01_axi_awsize(2 downto 0) => m01_axi_awsize(2 downto 0),
      m01_axi_awvalid => m01_axi_awvalid,
      m01_axi_bready => m01_axi_bready,
      m01_axi_bresp(1 downto 0) => m01_axi_bresp(1 downto 0),
      m01_axi_bvalid => m01_axi_bvalid,
      m01_axi_rdata(63 downto 0) => m01_axi_rdata(63 downto 0),
      m01_axi_rlast => m01_axi_rlast,
      m01_axi_rready => m01_axi_rready,
      m01_axi_rresp(1 downto 0) => m01_axi_rresp(1 downto 0),
      m01_axi_rvalid => m01_axi_rvalid,
      m01_axi_wdata(63 downto 0) => m01_axi_wdata(63 downto 0),
      m01_axi_wlast => m01_axi_wlast,
      m01_axi_wready => m01_axi_wready,
      m01_axi_wstrb(7 downto 0) => m01_axi_wstrb(7 downto 0),
      m01_axi_wvalid => m01_axi_wvalid,
      m02_axi_araddr(63 downto 0) => m02_axi_araddr(63 downto 0),
      m02_axi_arburst(1 downto 0) => m02_axi_arburst(1 downto 0),
      m02_axi_arcache(3 downto 0) => m02_axi_arcache(3 downto 0),
      m02_axi_arlen(7 downto 0) => m02_axi_arlen(7 downto 0),
      m02_axi_arprot(2 downto 0) => m02_axi_arprot(2 downto 0),
      m02_axi_arready => m02_axi_arready,
      m02_axi_arsize(2 downto 0) => m02_axi_arsize(2 downto 0),
      m02_axi_arvalid => m02_axi_arvalid,
      m02_axi_awaddr(63 downto 0) => m02_axi_awaddr(63 downto 0),
      m02_axi_awburst(1 downto 0) => m02_axi_awburst(1 downto 0),
      m02_axi_awcache(3 downto 0) => m02_axi_awcache(3 downto 0),
      m02_axi_awlen(7 downto 0) => m02_axi_awlen(7 downto 0),
      m02_axi_awprot(2 downto 0) => m02_axi_awprot(2 downto 0),
      m02_axi_awready => m02_axi_awready,
      m02_axi_awsize(2 downto 0) => m02_axi_awsize(2 downto 0),
      m02_axi_awvalid => m02_axi_awvalid,
      m02_axi_bready => m02_axi_bready,
      m02_axi_bresp(1 downto 0) => m02_axi_bresp(1 downto 0),
      m02_axi_bvalid => m02_axi_bvalid,
      m02_axi_rdata(63 downto 0) => m02_axi_rdata(63 downto 0),
      m02_axi_rlast => m02_axi_rlast,
      m02_axi_rready => m02_axi_rready,
      m02_axi_rresp(1 downto 0) => m02_axi_rresp(1 downto 0),
      m02_axi_rvalid => m02_axi_rvalid,
      m02_axi_wdata(63 downto 0) => m02_axi_wdata(63 downto 0),
      m02_axi_wlast => m02_axi_wlast,
      m02_axi_wready => m02_axi_wready,
      m02_axi_wstrb(7 downto 0) => m02_axi_wstrb(7 downto 0),
      m02_axi_wvalid => m02_axi_wvalid,
      m03_axi_araddr(63 downto 0) => m03_axi_araddr(63 downto 0),
      m03_axi_arburst(1 downto 0) => m03_axi_arburst(1 downto 0),
      m03_axi_arcache(3 downto 0) => m03_axi_arcache(3 downto 0),
      m03_axi_arlen(7 downto 0) => m03_axi_arlen(7 downto 0),
      m03_axi_arprot(2 downto 0) => m03_axi_arprot(2 downto 0),
      m03_axi_arready => m03_axi_arready,
      m03_axi_arsize(2 downto 0) => m03_axi_arsize(2 downto 0),
      m03_axi_arvalid => m03_axi_arvalid,
      m03_axi_awaddr(63 downto 0) => m03_axi_awaddr(63 downto 0),
      m03_axi_awburst(1 downto 0) => m03_axi_awburst(1 downto 0),
      m03_axi_awcache(3 downto 0) => m03_axi_awcache(3 downto 0),
      m03_axi_awlen(7 downto 0) => m03_axi_awlen(7 downto 0),
      m03_axi_awprot(2 downto 0) => m03_axi_awprot(2 downto 0),
      m03_axi_awready => m03_axi_awready,
      m03_axi_awsize(2 downto 0) => m03_axi_awsize(2 downto 0),
      m03_axi_awvalid => m03_axi_awvalid,
      m03_axi_bready => m03_axi_bready,
      m03_axi_bresp(1 downto 0) => m03_axi_bresp(1 downto 0),
      m03_axi_bvalid => m03_axi_bvalid,
      m03_axi_rdata(63 downto 0) => m03_axi_rdata(63 downto 0),
      m03_axi_rlast => m03_axi_rlast,
      m03_axi_rready => m03_axi_rready,
      m03_axi_rresp(1 downto 0) => m03_axi_rresp(1 downto 0),
      m03_axi_rvalid => m03_axi_rvalid,
      m03_axi_wdata(63 downto 0) => m03_axi_wdata(63 downto 0),
      m03_axi_wlast => m03_axi_wlast,
      m03_axi_wready => m03_axi_wready,
      m03_axi_wstrb(7 downto 0) => m03_axi_wstrb(7 downto 0),
      m03_axi_wvalid => m03_axi_wvalid,
      m04_axi_araddr(63 downto 0) => m04_axi_araddr(63 downto 0),
      m04_axi_arburst(1 downto 0) => m04_axi_arburst(1 downto 0),
      m04_axi_arcache(3 downto 0) => m04_axi_arcache(3 downto 0),
      m04_axi_arlen(7 downto 0) => m04_axi_arlen(7 downto 0),
      m04_axi_arprot(2 downto 0) => m04_axi_arprot(2 downto 0),
      m04_axi_arready => m04_axi_arready,
      m04_axi_arsize(2 downto 0) => m04_axi_arsize(2 downto 0),
      m04_axi_arvalid => m04_axi_arvalid,
      m04_axi_awaddr(63 downto 0) => m04_axi_awaddr(63 downto 0),
      m04_axi_awburst(1 downto 0) => m04_axi_awburst(1 downto 0),
      m04_axi_awcache(3 downto 0) => m04_axi_awcache(3 downto 0),
      m04_axi_awlen(7 downto 0) => m04_axi_awlen(7 downto 0),
      m04_axi_awprot(2 downto 0) => m04_axi_awprot(2 downto 0),
      m04_axi_awready => m04_axi_awready,
      m04_axi_awsize(2 downto 0) => m04_axi_awsize(2 downto 0),
      m04_axi_awvalid => m04_axi_awvalid,
      m04_axi_bready => m04_axi_bready,
      m04_axi_bresp(1 downto 0) => m04_axi_bresp(1 downto 0),
      m04_axi_bvalid => m04_axi_bvalid,
      m04_axi_rdata(63 downto 0) => m04_axi_rdata(63 downto 0),
      m04_axi_rlast => m04_axi_rlast,
      m04_axi_rready => m04_axi_rready,
      m04_axi_rresp(1 downto 0) => m04_axi_rresp(1 downto 0),
      m04_axi_rvalid => m04_axi_rvalid,
      m04_axi_wdata(63 downto 0) => m04_axi_wdata(63 downto 0),
      m04_axi_wlast => m04_axi_wlast,
      m04_axi_wready => m04_axi_wready,
      m04_axi_wstrb(7 downto 0) => m04_axi_wstrb(7 downto 0),
      m04_axi_wvalid => m04_axi_wvalid,
      m05_axi_araddr(63 downto 0) => m05_axi_araddr(63 downto 0),
      m05_axi_arburst(1 downto 0) => m05_axi_arburst(1 downto 0),
      m05_axi_arcache(3 downto 0) => m05_axi_arcache(3 downto 0),
      m05_axi_arlen(7 downto 0) => m05_axi_arlen(7 downto 0),
      m05_axi_arprot(2 downto 0) => m05_axi_arprot(2 downto 0),
      m05_axi_arready => m05_axi_arready,
      m05_axi_arsize(2 downto 0) => m05_axi_arsize(2 downto 0),
      m05_axi_arvalid => m05_axi_arvalid,
      m05_axi_awaddr(63 downto 0) => m05_axi_awaddr(63 downto 0),
      m05_axi_awburst(1 downto 0) => m05_axi_awburst(1 downto 0),
      m05_axi_awcache(3 downto 0) => m05_axi_awcache(3 downto 0),
      m05_axi_awlen(7 downto 0) => m05_axi_awlen(7 downto 0),
      m05_axi_awprot(2 downto 0) => m05_axi_awprot(2 downto 0),
      m05_axi_awready => m05_axi_awready,
      m05_axi_awsize(2 downto 0) => m05_axi_awsize(2 downto 0),
      m05_axi_awvalid => m05_axi_awvalid,
      m05_axi_bready => m05_axi_bready,
      m05_axi_bresp(1 downto 0) => m05_axi_bresp(1 downto 0),
      m05_axi_bvalid => m05_axi_bvalid,
      m05_axi_rdata(63 downto 0) => m05_axi_rdata(63 downto 0),
      m05_axi_rlast => m05_axi_rlast,
      m05_axi_rready => m05_axi_rready,
      m05_axi_rresp(1 downto 0) => m05_axi_rresp(1 downto 0),
      m05_axi_rvalid => m05_axi_rvalid,
      m05_axi_wdata(63 downto 0) => m05_axi_wdata(63 downto 0),
      m05_axi_wlast => m05_axi_wlast,
      m05_axi_wready => m05_axi_wready,
      m05_axi_wstrb(7 downto 0) => m05_axi_wstrb(7 downto 0),
      m05_axi_wvalid => m05_axi_wvalid,
      m06_axi_araddr(63 downto 0) => m06_axi_araddr(63 downto 0),
      m06_axi_arburst(1 downto 0) => m06_axi_arburst(1 downto 0),
      m06_axi_arcache(3 downto 0) => m06_axi_arcache(3 downto 0),
      m06_axi_arlen(7 downto 0) => m06_axi_arlen(7 downto 0),
      m06_axi_arprot(2 downto 0) => m06_axi_arprot(2 downto 0),
      m06_axi_arready => m06_axi_arready,
      m06_axi_arsize(2 downto 0) => m06_axi_arsize(2 downto 0),
      m06_axi_arvalid => m06_axi_arvalid,
      m06_axi_awaddr(63 downto 0) => m06_axi_awaddr(63 downto 0),
      m06_axi_awburst(1 downto 0) => m06_axi_awburst(1 downto 0),
      m06_axi_awcache(3 downto 0) => m06_axi_awcache(3 downto 0),
      m06_axi_awlen(7 downto 0) => m06_axi_awlen(7 downto 0),
      m06_axi_awprot(2 downto 0) => m06_axi_awprot(2 downto 0),
      m06_axi_awready => m06_axi_awready,
      m06_axi_awsize(2 downto 0) => m06_axi_awsize(2 downto 0),
      m06_axi_awvalid => m06_axi_awvalid,
      m06_axi_bready => m06_axi_bready,
      m06_axi_bresp(1 downto 0) => m06_axi_bresp(1 downto 0),
      m06_axi_bvalid => m06_axi_bvalid,
      m06_axi_rdata(63 downto 0) => m06_axi_rdata(63 downto 0),
      m06_axi_rlast => m06_axi_rlast,
      m06_axi_rready => m06_axi_rready,
      m06_axi_rresp(1 downto 0) => m06_axi_rresp(1 downto 0),
      m06_axi_rvalid => m06_axi_rvalid,
      m06_axi_wdata(63 downto 0) => m06_axi_wdata(63 downto 0),
      m06_axi_wlast => m06_axi_wlast,
      m06_axi_wready => m06_axi_wready,
      m06_axi_wstrb(7 downto 0) => m06_axi_wstrb(7 downto 0),
      m06_axi_wvalid => m06_axi_wvalid,
      m07_axi_araddr(63 downto 0) => m07_axi_araddr(63 downto 0),
      m07_axi_arburst(1 downto 0) => m07_axi_arburst(1 downto 0),
      m07_axi_arcache(3 downto 0) => m07_axi_arcache(3 downto 0),
      m07_axi_arlen(7 downto 0) => m07_axi_arlen(7 downto 0),
      m07_axi_arprot(2 downto 0) => m07_axi_arprot(2 downto 0),
      m07_axi_arready => m07_axi_arready,
      m07_axi_arsize(2 downto 0) => m07_axi_arsize(2 downto 0),
      m07_axi_arvalid => m07_axi_arvalid,
      m07_axi_awaddr(63 downto 0) => m07_axi_awaddr(63 downto 0),
      m07_axi_awburst(1 downto 0) => m07_axi_awburst(1 downto 0),
      m07_axi_awcache(3 downto 0) => m07_axi_awcache(3 downto 0),
      m07_axi_awlen(7 downto 0) => m07_axi_awlen(7 downto 0),
      m07_axi_awprot(2 downto 0) => m07_axi_awprot(2 downto 0),
      m07_axi_awready => m07_axi_awready,
      m07_axi_awsize(2 downto 0) => m07_axi_awsize(2 downto 0),
      m07_axi_awvalid => m07_axi_awvalid,
      m07_axi_bready => m07_axi_bready,
      m07_axi_bresp(1 downto 0) => m07_axi_bresp(1 downto 0),
      m07_axi_bvalid => m07_axi_bvalid,
      m07_axi_rdata(63 downto 0) => m07_axi_rdata(63 downto 0),
      m07_axi_rlast => m07_axi_rlast,
      m07_axi_rready => m07_axi_rready,
      m07_axi_rresp(1 downto 0) => m07_axi_rresp(1 downto 0),
      m07_axi_rvalid => m07_axi_rvalid,
      m07_axi_wdata(63 downto 0) => m07_axi_wdata(63 downto 0),
      m07_axi_wlast => m07_axi_wlast,
      m07_axi_wready => m07_axi_wready,
      m07_axi_wstrb(7 downto 0) => m07_axi_wstrb(7 downto 0),
      m07_axi_wvalid => m07_axi_wvalid,
      m08_axi_araddr(63 downto 0) => m08_axi_araddr(63 downto 0),
      m08_axi_arburst(1 downto 0) => m08_axi_arburst(1 downto 0),
      m08_axi_arcache(3 downto 0) => m08_axi_arcache(3 downto 0),
      m08_axi_arlen(7 downto 0) => m08_axi_arlen(7 downto 0),
      m08_axi_arprot(2 downto 0) => m08_axi_arprot(2 downto 0),
      m08_axi_arready => m08_axi_arready,
      m08_axi_arsize(2 downto 0) => m08_axi_arsize(2 downto 0),
      m08_axi_arvalid => m08_axi_arvalid,
      m08_axi_awaddr(63 downto 0) => m08_axi_awaddr(63 downto 0),
      m08_axi_awburst(1 downto 0) => m08_axi_awburst(1 downto 0),
      m08_axi_awcache(3 downto 0) => m08_axi_awcache(3 downto 0),
      m08_axi_awlen(7 downto 0) => m08_axi_awlen(7 downto 0),
      m08_axi_awprot(2 downto 0) => m08_axi_awprot(2 downto 0),
      m08_axi_awready => m08_axi_awready,
      m08_axi_awsize(2 downto 0) => m08_axi_awsize(2 downto 0),
      m08_axi_awvalid => m08_axi_awvalid,
      m08_axi_bready => m08_axi_bready,
      m08_axi_bresp(1 downto 0) => m08_axi_bresp(1 downto 0),
      m08_axi_bvalid => m08_axi_bvalid,
      m08_axi_rdata(63 downto 0) => m08_axi_rdata(63 downto 0),
      m08_axi_rlast => m08_axi_rlast,
      m08_axi_rready => m08_axi_rready,
      m08_axi_rresp(1 downto 0) => m08_axi_rresp(1 downto 0),
      m08_axi_rvalid => m08_axi_rvalid,
      m08_axi_wdata(63 downto 0) => m08_axi_wdata(63 downto 0),
      m08_axi_wlast => m08_axi_wlast,
      m08_axi_wready => m08_axi_wready,
      m08_axi_wstrb(7 downto 0) => m08_axi_wstrb(7 downto 0),
      m08_axi_wvalid => m08_axi_wvalid,
      m09_axi_araddr(63 downto 0) => m09_axi_araddr(63 downto 0),
      m09_axi_arburst(1 downto 0) => m09_axi_arburst(1 downto 0),
      m09_axi_arcache(3 downto 0) => m09_axi_arcache(3 downto 0),
      m09_axi_arlen(7 downto 0) => m09_axi_arlen(7 downto 0),
      m09_axi_arprot(2 downto 0) => m09_axi_arprot(2 downto 0),
      m09_axi_arready => m09_axi_arready,
      m09_axi_arsize(2 downto 0) => m09_axi_arsize(2 downto 0),
      m09_axi_arvalid => m09_axi_arvalid,
      m09_axi_awaddr(63 downto 0) => m09_axi_awaddr(63 downto 0),
      m09_axi_awburst(1 downto 0) => m09_axi_awburst(1 downto 0),
      m09_axi_awcache(3 downto 0) => m09_axi_awcache(3 downto 0),
      m09_axi_awlen(7 downto 0) => m09_axi_awlen(7 downto 0),
      m09_axi_awprot(2 downto 0) => m09_axi_awprot(2 downto 0),
      m09_axi_awready => m09_axi_awready,
      m09_axi_awsize(2 downto 0) => m09_axi_awsize(2 downto 0),
      m09_axi_awvalid => m09_axi_awvalid,
      m09_axi_bready => m09_axi_bready,
      m09_axi_bresp(1 downto 0) => m09_axi_bresp(1 downto 0),
      m09_axi_bvalid => m09_axi_bvalid,
      m09_axi_rdata(63 downto 0) => m09_axi_rdata(63 downto 0),
      m09_axi_rlast => m09_axi_rlast,
      m09_axi_rready => m09_axi_rready,
      m09_axi_rresp(1 downto 0) => m09_axi_rresp(1 downto 0),
      m09_axi_rvalid => m09_axi_rvalid,
      m09_axi_wdata(63 downto 0) => m09_axi_wdata(63 downto 0),
      m09_axi_wlast => m09_axi_wlast,
      m09_axi_wready => m09_axi_wready,
      m09_axi_wstrb(7 downto 0) => m09_axi_wstrb(7 downto 0),
      m09_axi_wvalid => m09_axi_wvalid,
      m10_axi_araddr(63 downto 0) => m10_axi_araddr(63 downto 0),
      m10_axi_arburst(1 downto 0) => m10_axi_arburst(1 downto 0),
      m10_axi_arcache(3 downto 0) => m10_axi_arcache(3 downto 0),
      m10_axi_arlen(7 downto 0) => m10_axi_arlen(7 downto 0),
      m10_axi_arprot(2 downto 0) => m10_axi_arprot(2 downto 0),
      m10_axi_arready => m10_axi_arready,
      m10_axi_arsize(2 downto 0) => m10_axi_arsize(2 downto 0),
      m10_axi_arvalid => m10_axi_arvalid,
      m10_axi_awaddr(63 downto 0) => m10_axi_awaddr(63 downto 0),
      m10_axi_awburst(1 downto 0) => m10_axi_awburst(1 downto 0),
      m10_axi_awcache(3 downto 0) => m10_axi_awcache(3 downto 0),
      m10_axi_awlen(7 downto 0) => m10_axi_awlen(7 downto 0),
      m10_axi_awprot(2 downto 0) => m10_axi_awprot(2 downto 0),
      m10_axi_awready => m10_axi_awready,
      m10_axi_awsize(2 downto 0) => m10_axi_awsize(2 downto 0),
      m10_axi_awvalid => m10_axi_awvalid,
      m10_axi_bready => m10_axi_bready,
      m10_axi_bresp(1 downto 0) => m10_axi_bresp(1 downto 0),
      m10_axi_bvalid => m10_axi_bvalid,
      m10_axi_rdata(63 downto 0) => m10_axi_rdata(63 downto 0),
      m10_axi_rlast => m10_axi_rlast,
      m10_axi_rready => m10_axi_rready,
      m10_axi_rresp(1 downto 0) => m10_axi_rresp(1 downto 0),
      m10_axi_rvalid => m10_axi_rvalid,
      m10_axi_wdata(63 downto 0) => m10_axi_wdata(63 downto 0),
      m10_axi_wlast => m10_axi_wlast,
      m10_axi_wready => m10_axi_wready,
      m10_axi_wstrb(7 downto 0) => m10_axi_wstrb(7 downto 0),
      m10_axi_wvalid => m10_axi_wvalid,
      m11_axi_araddr(63 downto 0) => m11_axi_araddr(63 downto 0),
      m11_axi_arburst(1 downto 0) => m11_axi_arburst(1 downto 0),
      m11_axi_arcache(3 downto 0) => m11_axi_arcache(3 downto 0),
      m11_axi_arlen(7 downto 0) => m11_axi_arlen(7 downto 0),
      m11_axi_arprot(2 downto 0) => m11_axi_arprot(2 downto 0),
      m11_axi_arready => m11_axi_arready,
      m11_axi_arsize(2 downto 0) => m11_axi_arsize(2 downto 0),
      m11_axi_arvalid => m11_axi_arvalid,
      m11_axi_awaddr(63 downto 0) => m11_axi_awaddr(63 downto 0),
      m11_axi_awburst(1 downto 0) => m11_axi_awburst(1 downto 0),
      m11_axi_awcache(3 downto 0) => m11_axi_awcache(3 downto 0),
      m11_axi_awlen(7 downto 0) => m11_axi_awlen(7 downto 0),
      m11_axi_awprot(2 downto 0) => m11_axi_awprot(2 downto 0),
      m11_axi_awready => m11_axi_awready,
      m11_axi_awsize(2 downto 0) => m11_axi_awsize(2 downto 0),
      m11_axi_awvalid => m11_axi_awvalid,
      m11_axi_bready => m11_axi_bready,
      m11_axi_bresp(1 downto 0) => m11_axi_bresp(1 downto 0),
      m11_axi_bvalid => m11_axi_bvalid,
      m11_axi_rdata(63 downto 0) => m11_axi_rdata(63 downto 0),
      m11_axi_rlast => m11_axi_rlast,
      m11_axi_rready => m11_axi_rready,
      m11_axi_rresp(1 downto 0) => m11_axi_rresp(1 downto 0),
      m11_axi_rvalid => m11_axi_rvalid,
      m11_axi_wdata(63 downto 0) => m11_axi_wdata(63 downto 0),
      m11_axi_wlast => m11_axi_wlast,
      m11_axi_wready => m11_axi_wready,
      m11_axi_wstrb(7 downto 0) => m11_axi_wstrb(7 downto 0),
      m11_axi_wvalid => m11_axi_wvalid,
      m12_axi_araddr(63 downto 0) => m12_axi_araddr(63 downto 0),
      m12_axi_arburst(1 downto 0) => m12_axi_arburst(1 downto 0),
      m12_axi_arcache(3 downto 0) => m12_axi_arcache(3 downto 0),
      m12_axi_arlen(7 downto 0) => m12_axi_arlen(7 downto 0),
      m12_axi_arprot(2 downto 0) => m12_axi_arprot(2 downto 0),
      m12_axi_arready => m12_axi_arready,
      m12_axi_arsize(2 downto 0) => m12_axi_arsize(2 downto 0),
      m12_axi_arvalid => m12_axi_arvalid,
      m12_axi_awaddr(63 downto 0) => m12_axi_awaddr(63 downto 0),
      m12_axi_awburst(1 downto 0) => m12_axi_awburst(1 downto 0),
      m12_axi_awcache(3 downto 0) => m12_axi_awcache(3 downto 0),
      m12_axi_awlen(7 downto 0) => m12_axi_awlen(7 downto 0),
      m12_axi_awprot(2 downto 0) => m12_axi_awprot(2 downto 0),
      m12_axi_awready => m12_axi_awready,
      m12_axi_awsize(2 downto 0) => m12_axi_awsize(2 downto 0),
      m12_axi_awvalid => m12_axi_awvalid,
      m12_axi_bready => m12_axi_bready,
      m12_axi_bresp(1 downto 0) => m12_axi_bresp(1 downto 0),
      m12_axi_bvalid => m12_axi_bvalid,
      m12_axi_rdata(63 downto 0) => m12_axi_rdata(63 downto 0),
      m12_axi_rlast => m12_axi_rlast,
      m12_axi_rready => m12_axi_rready,
      m12_axi_rresp(1 downto 0) => m12_axi_rresp(1 downto 0),
      m12_axi_rvalid => m12_axi_rvalid,
      m12_axi_wdata(63 downto 0) => m12_axi_wdata(63 downto 0),
      m12_axi_wlast => m12_axi_wlast,
      m12_axi_wready => m12_axi_wready,
      m12_axi_wstrb(7 downto 0) => m12_axi_wstrb(7 downto 0),
      m12_axi_wvalid => m12_axi_wvalid,
      m13_axi_araddr(63 downto 0) => m13_axi_araddr(63 downto 0),
      m13_axi_arburst(1 downto 0) => m13_axi_arburst(1 downto 0),
      m13_axi_arcache(3 downto 0) => m13_axi_arcache(3 downto 0),
      m13_axi_arlen(7 downto 0) => m13_axi_arlen(7 downto 0),
      m13_axi_arprot(2 downto 0) => m13_axi_arprot(2 downto 0),
      m13_axi_arready => m13_axi_arready,
      m13_axi_arsize(2 downto 0) => m13_axi_arsize(2 downto 0),
      m13_axi_arvalid => m13_axi_arvalid,
      m13_axi_awaddr(63 downto 0) => m13_axi_awaddr(63 downto 0),
      m13_axi_awburst(1 downto 0) => m13_axi_awburst(1 downto 0),
      m13_axi_awcache(3 downto 0) => m13_axi_awcache(3 downto 0),
      m13_axi_awlen(7 downto 0) => m13_axi_awlen(7 downto 0),
      m13_axi_awprot(2 downto 0) => m13_axi_awprot(2 downto 0),
      m13_axi_awready => m13_axi_awready,
      m13_axi_awsize(2 downto 0) => m13_axi_awsize(2 downto 0),
      m13_axi_awvalid => m13_axi_awvalid,
      m13_axi_bready => m13_axi_bready,
      m13_axi_bresp(1 downto 0) => m13_axi_bresp(1 downto 0),
      m13_axi_bvalid => m13_axi_bvalid,
      m13_axi_rdata(63 downto 0) => m13_axi_rdata(63 downto 0),
      m13_axi_rlast => m13_axi_rlast,
      m13_axi_rready => m13_axi_rready,
      m13_axi_rresp(1 downto 0) => m13_axi_rresp(1 downto 0),
      m13_axi_rvalid => m13_axi_rvalid,
      m13_axi_wdata(63 downto 0) => m13_axi_wdata(63 downto 0),
      m13_axi_wlast => m13_axi_wlast,
      m13_axi_wready => m13_axi_wready,
      m13_axi_wstrb(7 downto 0) => m13_axi_wstrb(7 downto 0),
      m13_axi_wvalid => m13_axi_wvalid,
      m14_axi_araddr(63 downto 0) => m14_axi_araddr(63 downto 0),
      m14_axi_arburst(1 downto 0) => m14_axi_arburst(1 downto 0),
      m14_axi_arcache(3 downto 0) => m14_axi_arcache(3 downto 0),
      m14_axi_arlen(7 downto 0) => m14_axi_arlen(7 downto 0),
      m14_axi_arprot(2 downto 0) => m14_axi_arprot(2 downto 0),
      m14_axi_arready => m14_axi_arready,
      m14_axi_arsize(2 downto 0) => m14_axi_arsize(2 downto 0),
      m14_axi_arvalid => m14_axi_arvalid,
      m14_axi_awaddr(63 downto 0) => m14_axi_awaddr(63 downto 0),
      m14_axi_awburst(1 downto 0) => m14_axi_awburst(1 downto 0),
      m14_axi_awcache(3 downto 0) => m14_axi_awcache(3 downto 0),
      m14_axi_awlen(7 downto 0) => m14_axi_awlen(7 downto 0),
      m14_axi_awprot(2 downto 0) => m14_axi_awprot(2 downto 0),
      m14_axi_awready => m14_axi_awready,
      m14_axi_awsize(2 downto 0) => m14_axi_awsize(2 downto 0),
      m14_axi_awvalid => m14_axi_awvalid,
      m14_axi_bready => m14_axi_bready,
      m14_axi_bresp(1 downto 0) => m14_axi_bresp(1 downto 0),
      m14_axi_bvalid => m14_axi_bvalid,
      m14_axi_rdata(63 downto 0) => m14_axi_rdata(63 downto 0),
      m14_axi_rlast => m14_axi_rlast,
      m14_axi_rready => m14_axi_rready,
      m14_axi_rresp(1 downto 0) => m14_axi_rresp(1 downto 0),
      m14_axi_rvalid => m14_axi_rvalid,
      m14_axi_wdata(63 downto 0) => m14_axi_wdata(63 downto 0),
      m14_axi_wlast => m14_axi_wlast,
      m14_axi_wready => m14_axi_wready,
      m14_axi_wstrb(7 downto 0) => m14_axi_wstrb(7 downto 0),
      m14_axi_wvalid => m14_axi_wvalid,
      m15_axi_araddr(63 downto 0) => m15_axi_araddr(63 downto 0),
      m15_axi_arburst(1 downto 0) => m15_axi_arburst(1 downto 0),
      m15_axi_arcache(3 downto 0) => m15_axi_arcache(3 downto 0),
      m15_axi_arlen(7 downto 0) => m15_axi_arlen(7 downto 0),
      m15_axi_arprot(2 downto 0) => m15_axi_arprot(2 downto 0),
      m15_axi_arready => m15_axi_arready,
      m15_axi_arsize(2 downto 0) => m15_axi_arsize(2 downto 0),
      m15_axi_arvalid => m15_axi_arvalid,
      m15_axi_awaddr(63 downto 0) => m15_axi_awaddr(63 downto 0),
      m15_axi_awburst(1 downto 0) => m15_axi_awburst(1 downto 0),
      m15_axi_awcache(3 downto 0) => m15_axi_awcache(3 downto 0),
      m15_axi_awlen(7 downto 0) => m15_axi_awlen(7 downto 0),
      m15_axi_awprot(2 downto 0) => m15_axi_awprot(2 downto 0),
      m15_axi_awready => m15_axi_awready,
      m15_axi_awsize(2 downto 0) => m15_axi_awsize(2 downto 0),
      m15_axi_awvalid => m15_axi_awvalid,
      m15_axi_bready => m15_axi_bready,
      m15_axi_bresp(1 downto 0) => m15_axi_bresp(1 downto 0),
      m15_axi_bvalid => m15_axi_bvalid,
      m15_axi_rdata(63 downto 0) => m15_axi_rdata(63 downto 0),
      m15_axi_rlast => m15_axi_rlast,
      m15_axi_rready => m15_axi_rready,
      m15_axi_rresp(1 downto 0) => m15_axi_rresp(1 downto 0),
      m15_axi_rvalid => m15_axi_rvalid,
      m15_axi_wdata(63 downto 0) => m15_axi_wdata(63 downto 0),
      m15_axi_wlast => m15_axi_wlast,
      m15_axi_wready => m15_axi_wready,
      m15_axi_wstrb(7 downto 0) => m15_axi_wstrb(7 downto 0),
      m15_axi_wvalid => m15_axi_wvalid,
      s_axi_control_araddr(11 downto 0) => s_axi_control_araddr(11 downto 0),
      s_axi_control_arprot(2 downto 0) => s_axi_control_arprot(2 downto 0),
      s_axi_control_arready => s_axi_control_arready,
      s_axi_control_arvalid => s_axi_control_arvalid,
      s_axi_control_awaddr(11 downto 0) => s_axi_control_awaddr(11 downto 0),
      s_axi_control_awprot(2 downto 0) => s_axi_control_awprot(2 downto 0),
      s_axi_control_awready => s_axi_control_awready,
      s_axi_control_awvalid => s_axi_control_awvalid,
      s_axi_control_bready => s_axi_control_bready,
      s_axi_control_bresp(1 downto 0) => s_axi_control_bresp(1 downto 0),
      s_axi_control_bvalid => s_axi_control_bvalid,
      s_axi_control_rdata(31 downto 0) => s_axi_control_rdata(31 downto 0),
      s_axi_control_rready => s_axi_control_rready,
      s_axi_control_rresp(1 downto 0) => s_axi_control_rresp(1 downto 0),
      s_axi_control_rvalid => s_axi_control_rvalid,
      s_axi_control_wdata(31 downto 0) => s_axi_control_wdata(31 downto 0),
      s_axi_control_wready => s_axi_control_wready,
      s_axi_control_wstrb(3 downto 0) => s_axi_control_wstrb(3 downto 0),
      s_axi_control_wvalid => s_axi_control_wvalid
    );
end STRUCTURE;
