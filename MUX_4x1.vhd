library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4x1 is
    Port (
        A, B, C, D : in std_logic_vector(3 downto 0);
        S : in std_logic_vector(1 downto 0);
        Y : out std_logic_vector(3 downto 0)
    );
end MUX_4x1;

architecture Behavioral of MUX_4x1 is
begin
    process (A, B, C, D, S)
    begin
        case S is
            when "00" =>
                Y <= A;
            when "01" =>
                Y <= B;
            when "10" =>
                Y <= C;
            when "11" =>
                Y <= D;
            when others =>
                Y <= (others => '0');
        end case;
    end process;
end Behavioral;