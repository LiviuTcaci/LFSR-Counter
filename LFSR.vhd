library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity LFSR is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           LOAD : in  STD_LOGIC;
           MODE : in  STD_LOGIC;
           C : in  STD_LOGIC;
           QX : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (4 downto 0);
           N : in  STD_LOGIC_VECTOR (4 downto 0);
           Q : out  STD_LOGIC_VECTOR (4 downto 0);
           STOP : out  STD_LOGIC);
end LFSR;
architecture Behavioral of LFSR is
    signal LFSR_Register : STD_LOGIC_VECTOR(4 downto 0);
    signal END_CICLE : INTEGER := 0;
    signal SHIFT_RIGHT : STD_LOGIC;
begin
    -- 5-bit Register
    process (CLK, RESET)
    begin
        if RESET = '1' then
            LFSR_Register <= (others => '0');
        elsif rising_edge(CLK) then
            if LOAD = '1' then
                LFSR_Register <= D;
            else
                -- Shift right
                LFSR_Register <= '0' & LFSR_Register(4 downto 1);
                LFSR_Register(0) <= SHIFT_RIGHT;
            end if;
        end if;
    end process;
    -- END_CICLE Counter
    process (CLK, RESET)
    begin
        if RESET = '1' then
            END_CICLE <= 0;
        elsif rising_edge(CLK) then
            if END_CICLE = N then
                STOP <= '1';
            else
                STOP <= '0';
                END_CICLE <= END_CICLE + 1;
            end if;
        end if;
    end process;
    -- SHIFT_RIGHT Logic
    SHIFT_RIGHT <= (QX and C) or ((not QX) and LFSR_Register(0));
    -- Output assignment
    Q <= LFSR_Register when MODE = '0' else "0" & LFSR_Register(3 downto 0);
end Behavioral;