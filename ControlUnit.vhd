library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ControlUnit is
    Port (
        clkCU : in STD_LOGIC;
        RSTCU : in STD_LOGIC;
        STRTCU : in STD_LOGIC;
        STPCU : in STD_LOGIC;
        ENCU : out STD_LOGIC;
        LDCU : out STD_LOGIC;
        RSTCU_lfsr : out STD_LOGIC
    );
end ControlUnit;
architecture behavioral of ControlUnit is
    -- Define the states
    type state_type is (state_A, state_B, state_C, state_D);
    signal current_state, next_state: state_type;
begin
    -- State transition process
    process(clkCU, RSTCU)
    begin
        if RSTCU = '1' then
            current_state <= state_A;
        elsif rising_edge(clkCU) then
            current_state <= next_state;
        end if;
    end process;
    -- Next state logic process
    process(current_state, STRTCU, STPCU)
    begin
        case current_state is
            when state_A =>
                if STRTCU = '1' then
                    next_state <= state_B;
                else
                    next_state <= state_A;
                end if;

            when state_B =>
                next_state <= state_C;

            when state_C =>
                if STPCU = '1' then
                    next_state <= state_D;
                else
                    next_state <= state_C;
                end if;

            when state_D =>
                next_state <= state_A;

            when others =>
                next_state <= state_A;
        end case;
    end process;
    -- Output logic process
    process(current_state)
    begin
        case current_state is
            when state_A =>
                ENCU <= '0';
                LDCU <= '0';
                RSTCU_lfsr <= '0';
            when state_B =>
                ENCU <= '0';
                LDCU <= '1';
                RSTCU_lfsr <= '0';
            when state_C =>
                ENCU <= '1';
                LDCU <= '0';
                RSTCU_lfsr <= '0';
            when state_D =>
                ENCU <= '0';
                LDCU <= '0';
                RSTCU_lfsr <= '1';
            when others =>
                ENCU <= '0';
                LDCU <= '0';
                RSTCU_lfsr <= '0';
        end case;
    end process;
end behavioral;