--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Mon Jan  4 13:42:33 2021
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.9.2009 (Core)
--Command     : generate_target HBM_measurements_bd_wrapper.bd
--Design      : HBM_measurements_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity HBM_measurements_bd_wrapper is
  port (
    M_AXIS_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_0_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_0_tlast : out STD_LOGIC;
    M_AXIS_0_tready : in STD_LOGIC;
    M_AXIS_0_tvalid : out STD_LOGIC;
    Op2_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC
  );
end HBM_measurements_bd_wrapper;

architecture STRUCTURE of HBM_measurements_bd_wrapper is
  component HBM_measurements_bd is
  port (
    ap_clk : in STD_LOGIC;
    ap_rst_n : in STD_LOGIC;
    M_AXIS_0_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    M_AXIS_0_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M_AXIS_0_tlast : out STD_LOGIC;
    M_AXIS_0_tready : in STD_LOGIC;
    M_AXIS_0_tvalid : out STD_LOGIC;
    Op2_0 : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component HBM_measurements_bd;
begin
HBM_measurements_bd_i: component HBM_measurements_bd
     port map (
      M_AXIS_0_tdata(63 downto 0) => M_AXIS_0_tdata(63 downto 0),
      M_AXIS_0_tkeep(7 downto 0) => M_AXIS_0_tkeep(7 downto 0),
      M_AXIS_0_tlast => M_AXIS_0_tlast,
      M_AXIS_0_tready => M_AXIS_0_tready,
      M_AXIS_0_tvalid => M_AXIS_0_tvalid,
      Op2_0(31 downto 0) => Op2_0(31 downto 0),
      ap_clk => ap_clk,
      ap_rst_n => ap_rst_n
    );
end STRUCTURE;
