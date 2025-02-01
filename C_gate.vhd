LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
ENTITY C_gate IS
  PORT (
    mode: IN std_logic;
    n: IN std_logic_vector(4 DOWNTO 0);
    c: IN std_logic;
    d_output: OUT std_logic_vector(4 DOWNTO 0)
  );
END ENTITY C_gate;
ARCHITECTURE Behavioral OF C_gate IS
  TYPE rom_16x4_type IS ARRAY (0 TO 15) OF std_logic_vector(3 DOWNTO 0);
  TYPE rom_32x5_type IS ARRAY (0 TO 31) OF std_logic_vector(4 DOWNTO 0);
  -- ROM for 4-bit LFSR
  CONSTANT rom_16x4: rom_16x4_type := (
    "0000", -- 0
    "0000", -- 1
    "0101", -- 2
    "0110", -- 3
    "1101", -- 4
    "0010", -- 5
    "1010", -- 6
    "1000", -- 7
    "1001", -- 8
    "1001", -- 9
    "1011", -- 10
    "0011", -- 11
    "0111", -- 12
    "0111", -- 13
    "0100", -- 14
    "1111"  -- 15
  );
  -- ROM for 5-bit LFSR
  CONSTANT rom_32x5: rom_32x5_type := (
    "00000", "11111", "10101", "10110", -- 0 to 3
    "01000", "11011", "11011", "11000", -- 4 to 7
    "10001", "10001", "00010", "00010", -- 8 to 11
    "10011", "11101", "01111", "01111", -- 12 to 15
    "00101", "00101", "11100", "11100", -- 16 to 19
    "10010", "01010", "10000", "10000", -- 20 to 23
    "00110", "11001", "01101", "10101", -- 24 to 27
    "01001", "10111", "10100", "11110"  -- 28 to 31
  );
  SIGNAL d_4bit: std_logic_vector(3 DOWNTO 0);
  SIGNAL d_5bit: std_logic_vector(4 DOWNTO 0);
  SIGNAL n_4bit: std_logic_vector(3 DOWNTO 0);
BEGIN
  n_4bit <= n(3 DOWNTO 0);
  -- Get D output for 4-bit LFSR
  d_4bit <= rom_16x4(to_integer(unsigned(n_4bit)));
  -- Get D output for 5-bit LFSR
  d_5bit <= rom_32x5(to_integer(unsigned(n)));
  -- Select D output based on mode
  PROCESS (mode, d_4bit, d_5bit, c)
  BEGIN
    IF mode = '0' THEN
      d_output <= "0" & d_4bit;
    ELSE
      d_output <= d_5bit;
    END IF;
    IF c = '0' THEN
      d_output <= (OTHERS => '0');
    END IF;
  END PROCESS;
END ARCHITECTURE Behavioral;