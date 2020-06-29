--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2.1 (lin64) Build 2729669 Thu Dec  5 04:48:12 MST 2019
--Date        : Sun Jun 28 16:49:51 2020
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.8.2003 (Core)
--Command     : generate_target Circular_Buffer_wrapper.bd
--Design      : Circular_Buffer_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Circular_Buffer_wrapper is
  port (
    core_ext_start_0 : in STD_LOGIC;
    core_ext_stop_0 : in STD_LOGIC;
    resetn : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
end Circular_Buffer_wrapper;

architecture STRUCTURE of Circular_Buffer_wrapper is
  component Circular_Buffer is
  port (
    resetn : in STD_LOGIC;
    core_ext_start_0 : in STD_LOGIC;
    core_ext_stop_0 : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
  end component Circular_Buffer;
begin
Circular_Buffer_i: component Circular_Buffer
     port map (
      core_ext_start_0 => core_ext_start_0,
      core_ext_stop_0 => core_ext_stop_0,
      resetn => resetn,
      sysclk0_clk_n => sysclk0_clk_n,
      sysclk0_clk_p => sysclk0_clk_p
    );
end STRUCTURE;
