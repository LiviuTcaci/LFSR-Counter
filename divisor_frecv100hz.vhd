Library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY divisor_frecv100hz IS
PORT(
	clockdeffor100hz: IN std_logic;
	div_clk100hz: out std_logic
	);
END divisor_frecv100hz;

--divizor de frecventa de La 100 Mhz La 100hz de
ARCHITECTURE TypeArchitecture OF divisor_frecv100hz IS
signal tmp:std_logic_vector (19 downto 0):=(others =>'0');
BEGIN
process (clockdeffor100hz)
begin
	if (rising_edge(clockdeffor100hz)) then
		if tmp =("11110100001000111111") then tmp <="00000000000000000000";
			elsif (tmp <= "01111010000100011111") then
				tmp <= tmp +1;
				div_clk100hz <='0';
			else div_clk100hz <= '1';
				tmp <= tmp +1;
	end if;
	end if;
end process;
END TypeArchitecture;