library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_gen is 
end tb_gen;


architecture TB of tb_gen is

component MicroBlaze_HBM_Streams is
port (
  core_ext_start_0 : in STD_LOGIC;
  core_ext_stop_0 : in STD_LOGIC;
  resetn : in STD_LOGIC;
  sysclk0_clk_n : in STD_LOGIC;
  sysclk0_clk_p : in STD_LOGIC
);
end component MicroBlaze_HBM_Streams;

signal core_ext_start_0 : STD_LOGIC;
signal core_ext_stop_0 : STD_LOGIC;
signal resetn : STD_LOGIC;
signal sysclk0_clk_n : STD_LOGIC;
signal sysclk0_clk_p : STD_LOGIC;
begin

DUT: component MicroBlaze_HBM_Streams port map (
  core_ext_start_0 => core_ext_start_0,
  core_ext_stop_0 => core_ext_stop_0,
  resetn => resetn,
  sysclk0_clk_n => sysclk0_clk_n,
  sysclk0_clk_p => sysclk0_clk_p
);

process
begin
  sysclk0_clk_n <= '0';
  wait for 5.0 ns;
  sysclk0_clk_n <= '1';
  wait for 5.0 ns;
end process;

sysclk0_clk_p <= NOT sysclk0_clk_n;
process
begin
  resetn <= '0';
  wait for 100 ns;
  resetn <= '1';
  wait;
end process;

end TB;

