--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
--Date        : Sun Aug  9 19:27:40 2020
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.8.2003 (Core)
--Command     : generate_target HBM_1024b_bd_wrapper.bd
--Design      : HBM_1024b_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity HBM_1024b_bd_wrapper is
  port (
    resetn : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
end HBM_1024b_bd_wrapper;

architecture STRUCTURE of HBM_1024b_bd_wrapper is
  component HBM_1024b_bd is
  port (
    resetn : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
  end component HBM_1024b_bd;
begin
HBM_1024b_bd_i: component HBM_1024b_bd
     port map (
      resetn => resetn,
      sysclk0_clk_n => sysclk0_clk_n,
      sysclk0_clk_p => sysclk0_clk_p
    );
end STRUCTURE;
