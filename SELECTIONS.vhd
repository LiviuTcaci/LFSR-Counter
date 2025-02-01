library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity SELECTIONS is
    Port (
        N : in std_logic_vector(4 downto 0);
        MODE : in std_logic;
        QX : out std_logic;
        C : out std_logic
    );
end SELECTIONS;
architecture Behavioral of SELECTIONS is
    signal N_4bit : std_logic_vector(3 downto 0);
    signal QX_16, QX_32 : std_logic;
    signal C_4, C_5 : std_logic;
begin
    -- Assign the 4 MSBs of N to N_4bit
    N_4bit <= N(3 downto 0);
    -- MUX_16 and MUX_32 for QX
    with N_4bit select
        QX_16 <= '1' when "0100" | "1000" | "1100" | "1111",
                 '0' when others;
    with N select
        QX_32 <= '1' when "00101" | "01010" | "01110" | "10000" | "10010" | "10110" | "11011" | "11111",
                 '0' when others;
    -- MUX_QX
    QX <= QX_16 when MODE = '0' else QX_32;
    -- COMP_4 and COMP_5 for C
    C_4 <= '1' when N_4bit /= "1111" else '0';
    C_5 <= '1' when N /= "11111" else '0';
    -- MUX_C
    C <= C_4 when MODE = '0' else C_5;
end Behavioral;