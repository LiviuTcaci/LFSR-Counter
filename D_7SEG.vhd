library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.all;

entity D_7SEG is
    Port (
        digit : in std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end D_7SEG;

architecture Behavioral of D_7SEG is
TYPE D_7SEG_type IS ARRAY (0 TO 9) OF std_logic_vector(6 DOWNTO 0);

    constant lut : D_7SEG_type := (
        "0111111", -- 0
        "0000110", -- 1
        "1011011", -- 2
        "1001111", -- 3
        "1100110", -- 4
        "1101101", -- 5
        "1111101", -- 6
        "0000111", -- 7
        "1111111", -- 8
        "1101111"  -- 9
    );
begin
    seg <= lut(to_integer(unsigned(digit)));
end Behavioral;