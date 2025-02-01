LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
ENTITY ButtonHandler IS
  PORT (
    clk: IN std_logic;
    reset: IN std_logic;
    button: IN std_logic; --give loop lenghloop
    looplenghtout: OUT std_logic_vector(4 DOWNTO 0)
  );
END ENTITY ButtonHandler;
ARCHITECTURE Behavioral OF ButtonHandler IS
  SIGNAL count: integer := 0;
  SIGNAL button_state, button_prev: std_logic := '0';
  SIGNAL debounce_counter: integer := 0;
  SIGNAL debounce_limit: integer := 1000000; -- Adjust this value based on your clock frequency and desired debounce time
BEGIN
  PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF reset = '1' THEN
        count <= 0;
        button_state <= '0';
        button_prev <= '0';
        debounce_counter <= 0;
      ELSE
        button_prev <= button_state;
        button_state <= button;
        IF button_state = '1' AND button_prev = '0' THEN
          debounce_counter <= debounce_limit;
          count <= count + 1;
          IF count > 31 THEN
            count <= 1;
          END IF;
        ELSIF debounce_counter > 0 THEN
          debounce_counter <= debounce_counter - 1;
        END IF;
      END IF;
    END IF;
  END PROCESS;
  looplenghtout <= std_logic_vector(to_unsigned(count, looplenghtout'length));
END ARCHITECTURE Behavioral;