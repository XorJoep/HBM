----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2020 12:15:25 PM
-- Design Name: 
-- Module Name: keep_to_cnt - Behavioral
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

entity keep_to_cnt is
    Port ( cnt : out std_logic_vector (2 downto 0);
           keep : in std_logic_vector (7 downto 0));
end keep_to_cnt;

architecture Behavioral of keep_to_cnt is
begin
    process (keep)
    begin
        label1 : case keep is
            when "00000001" => cnt <= "001";
            when "00000011" => cnt <= "010";
            when "00000111" => cnt <= "011";
            when "00001111" => cnt <= "100";
            when "00011111" => cnt <= "101";
            when "00111111" => cnt <= "110";
            when "01111111" => cnt <= "111";
            when "11111111" => cnt <= "000";
            when others     => cnt <= "000";
        end case;
    end process;
end Behavioral;

