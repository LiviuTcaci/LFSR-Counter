library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DECODER_2x4 is
    Port (
        A, B : in std_logic;
        Y : out std_logic_vector(3 downto 0)
    );
end DECODER_2x4;

architecture Behavioral of DECODER_2x4 is
begin
    Y <= "0001" when (A = '0' and B = '0') else
         "0010" when (A = '0' and B = '1') else
         "0100" when (A = '1' and B = '0') else
         "1000" when (A = '1' and B = '1') else
         (others => '0');
end Behavioral;