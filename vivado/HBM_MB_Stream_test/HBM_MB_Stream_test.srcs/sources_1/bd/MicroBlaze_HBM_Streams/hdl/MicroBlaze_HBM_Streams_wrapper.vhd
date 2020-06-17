--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.2.1 (lin64) Build 2729669 Thu Dec  5 04:48:12 MST 2019
--Date        : Mon Jun 15 11:30:17 2020
--Host        : qce-alveo01.ewi.tudelft.nl running 64-bit CentOS Linux release 7.8.2003 (Core)
--Command     : generate_target MicroBlaze_HBM_Streams_wrapper.bd
--Design      : MicroBlaze_HBM_Streams_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity MicroBlaze_HBM_Streams_wrapper is
  port (
    core_ext_start_0 : in STD_LOGIC;
    core_ext_stop_0 : in STD_LOGIC;
    resetn : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
end MicroBlaze_HBM_Streams_wrapper;

architecture STRUCTURE of MicroBlaze_HBM_Streams_wrapper is
  component MicroBlaze_HBM_Streams is
  port (
    resetn : in STD_LOGIC;
    core_ext_start_0 : in STD_LOGIC;
    core_ext_stop_0 : in STD_LOGIC;
    sysclk0_clk_n : in STD_LOGIC;
    sysclk0_clk_p : in STD_LOGIC
  );
  end component MicroBlaze_HBM_Streams;
begin
MicroBlaze_HBM_Streams_i: component MicroBlaze_HBM_Streams
     port map (
      core_ext_start_0 => core_ext_start_0,
      core_ext_stop_0 => core_ext_stop_0,
      resetn => resetn,
      sysclk0_clk_n => sysclk0_clk_n,
      sysclk0_clk_p => sysclk0_clk_p
    );
end STRUCTURE;
