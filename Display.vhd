library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Display is
    Port (
        CLK_AF : in std_logic;
        Q : in std_logic_vector(4 downto 0);
        EN : in std_logic;
        ANODE : out std_logic_vector(3 downto 0);
        SEVEN_SEG : out std_logic_vector(6 downto 0)
    );
end Display;
architecture Behavioral of Display is
    component BIN_BCD is
        Port (
            bin_number : in std_logic_vector(4 downto 0);
            bcd_number : out std_logic_vector(7 downto 0)
        );
    end component;
    component MUX_4x1 is
        Port (
            A, B, C, D : in std_logic_vector(3 downto 0);
            S : in std_logic_vector(1 downto 0);
            Y : out std_logic_vector(3 downto 0)
        );
    end component;
    component D_7SEG is
        Port (
            digit : in std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;
    component DECODER_2x4 is
        Port (
            A, B : in std_logic;
            Y : out std_logic_vector(3 downto 0)
        );
    end component;
    signal bcd_number : std_logic_vector(7 downto 0);
    signal mux_out : std_logic_vector(3 downto 0);
    signal seven_seg_out : std_logic_vector(6 downto 0);
    signal anode_out : std_logic_vector(3 downto 0);
    signal counter : std_logic_vector(1 downto 0);
begin
    -- BIN_BCD component instantiation
    BIN_BCD_inst: BIN_BCD
        Port Map (
            bin_number => Q,
            bcd_number => bcd_number
        );
    -- MUX_4x1 component instantiation
    MUX_4x1_inst: MUX_4x1
        Port Map (
            A => bcd_number(3 downto 0),
            B => bcd_number(7 downto 4),
            C => "0000",
            D => "0000",
            S => counter,
            Y => mux_out
        );
    -- D_7SEG component instantiation
    D_7SEG_inst: D_7SEG
        Port Map (
            digit => mux_out,
            seg => seven_seg_out
        );
    -- DECODER_2x4 component instantiation
    DECODER_2x4_inst: DECODER_2x4
        Port Map (
            A => counter(0),
            B => counter(1),
            Y => anode_out
        );
    process (CLK_AF)
    begin
        if rising_edge(CLK_AF) and (EN = '1') then
            counter <= counter + 1;
        end if;
    end process;
    ANODE <= anode_out;
    SEVEN_SEG <= seven_seg_out;
end Behavioral;