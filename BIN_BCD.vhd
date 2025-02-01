library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BIN_BCD is
    Port (
        bin_number : in std_logic_vector(4 downto 0);
        bcd_number : out std_logic_vector(7 downto 0)
    );
end BIN_BCD;

architecture Behavioral of BIN_BCD is
begin
    process (bin_number)
        variable temp : integer;
        variable ones_digit : std_logic_vector(3 downto 0);
        variable tens_digit : std_logic_vector(3 downto 0);
    begin
        temp := to_integer(unsigned(bin_number));

        ones_digit := std_logic_vector(to_unsigned(temp mod 10, 4));
        tens_digit := std_logic_vector(to_unsigned(temp / 10, 4));

        bcd_number <= tens_digit & ones_digit;
    end process;
end Behavioral;