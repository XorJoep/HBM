----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2020 04:15:00 PM
-- Design Name: 
-- Module Name: cnt_to_keep - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cnt_to_keep is
    Port ( cnt : in std_logic_vector (3 downto 0);
            dvalid : in std_logic;
            valid : in std_logic;
            tlast : in std_logic;
            ready : in std_logic;
           keep : out std_logic_vector (7 downto 0);
           sparse_pkt : out std_logic);
end cnt_to_keep;

architecture Behavioral of cnt_to_keep is
begin
    process (cnt)
    begin
        label1 : case cnt is
            when "0000" => keep <= "00000000";
            when "0001" => keep <= "00000001";
            when "0010" => keep <= "00000011";
            when "0011" => keep <= "00000111";
            when "0100" => keep <= "00001111";
            when "0101" => keep <= "00011111";
            when "0110" => keep <= "00111111";
            when "0111" => keep <= "01111111";
            when "1000" => keep <= "11111111";
            when others => keep <= "00000000";
        end case;
    end process;
    
    process (tlast, cnt, dvalid, valid, ready) 
    begin
    if cnt = "0000" and dvalid = '0' and tlast = '1' and valid = '1' and ready = '1' then
        sparse_pkt <= '1';
    else
        sparse_pkt <= '0';
    end if;
    end process;
end Behavioral;
