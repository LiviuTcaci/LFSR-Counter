LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MainDesignLFSR IS
  PORT (
    CLK: IN std_logic;
    START: IN std_logic;
    MODEM: IN std_logic;
    RESETM: IN std_logic;
    LENLOOP: IN std_logic;
    ANODE : out std_logic_vector(3 downto 0);
    CATODE : out std_logic_vector(6 downto 0)
  );
END ENTITY MainDesignLFSR;

    ARCHITECTURE Structural OF MainDesignLFSR IS
  SIGNAL load_lfsr, enable_display, stoplfsr, clksgn100hz, clksgn1mhz, rstlfsr, stoptocu, qxsgn, csgn: std_logic;
  signal Nsgn, Qsgn, Dsgn :std_logic_vector(4 downto 0);

COMPONENT divisor_frecv1Mhz IS
PORT(
  clockdeffor1mhz: IN std_logic;
  div_clk1mhz: out std_logic
  );
END COMPONENT;

COMPONENT divisor_frecv100hz IS
PORT(
  clockdeffor100hz: IN std_logic;
  div_clk100hz: out std_logic
  );
END COMPONENT;

COMPONENT ControlUnit is
    Port (
        clkCU : in STD_LOGIC;
        RSTCU : in STD_LOGIC;
        STRTCU : in STD_LOGIC;
        STPCU : in STD_LOGIC;
        ENCU : out STD_LOGIC;
        LDCU : out STD_LOGIC;
        RSTCU_lfsr : out STD_LOGIC
    );
end COMPONENT;
COMPONENT ButtonHandler IS
  PORT (
    clk: IN std_logic;
    reset: IN std_logic;
    button: IN std_logic;
    looplenghtout: OUT std_logic_vector(4 DOWNTO 0)
  );
END COMPONENT;


COMPONENT LFSR is
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
end COMPONENT;

COMPONENT SELECTIONS is
    Port (
        N : in std_logic_vector(4 downto 0);
        MODE : in std_logic;
        QX : out std_logic;
        C : out std_logic
    );
end COMPONENT;

COMPONENT C_gate IS
  PORT (
    mode: IN std_logic;
    n: IN std_logic_vector(4 DOWNTO 0);
    c: IN std_logic;
    d_output: OUT std_logic_vector(4 DOWNTO 0)
  );
END COMPONENT;

COMPONENT Display is
    Port (
        CLK_AF : in std_logic;
        Q : in std_logic_vector(4 downto 0);
        EN : in std_logic;
        ANODE : out std_logic_vector(3 downto 0);
        SEVEN_SEG : out std_logic_vector(6 downto 0)
    );
end COMPONENT;

BEGIN
    freq_div100hz: divisor_frecv1Mhz
    port map (
        clockdeffor1mhz => CLK,
        div_clk1mhz => clksgn100hz
     );

    freq_div1mhz: divisor_frecv100hz
    port map (
    clockdeffor100hz => CLK,
      div_clk100hz => clksgn1mhz
        );


    -- Instantiate control unit
    CU_inst: ControlUnit
    PORT MAP (
     clkCU =>clksgn100hz,
       RSTCU => RESETM,
       STRTCU => START,
       STPCU => stoptocu,
       ENCU => enable_display,
       LDCU => load_lfsr,
       RSTCU_lfsr => rstlfsr
    );

    BottonH_inst: ButtonHandler
    port map (
    clk => clksgn100hz,
        reset => RESETM,
        button => LENLOOP,
        looplenghtout => Nsgn
            );

  -- Instantiate LFSR
  LFSR_inst: LFSR
    PORT MAP (
      CLK => clksgn100hz,
           RESET => rstlfsr,
           LOAD => load_lfsr,
           MODE => MODEM,
           C => csgn,
           QX => qxsgn,
           D => Dsgn,
           N => Nsgn,
           Q => Qsgn,
           STOP => stoptocu
    );
    
    SELECTIONS_inst: SELECTIONS
    port map (
        N => Nsgn,
        MODE => MODEM,
        QX => qxsgn,
        C => csgn
    );

C_gate_inst: C_gate
  PORT map(
    mode => MODEM,
    n => Nsgn,
    c => csgn,
    d_output => Dsgn
    );

Display_inst: Display
    Port map (
        CLK_AF => clksgn1mhz,
        Q => Qsgn,
        EN => enable_display,
        ANODE => ANODE,
        SEVEN_SEG => CATODE
    );
END ARCHITECTURE Structural;