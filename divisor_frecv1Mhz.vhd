Library ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
ENTITY divisor_frecv1Mhz IS
PORT(
	clockdeffor1mhz: IN std_logic;
	div_clk1mhz: out std_logic
	);
END divisor_frecv1Mhz;

--divizor de frecventa de La 100 Mhz La 1 Mhz de
ARCHITECTURE TypeArchitecture OF divisor_frecv1Mhz IS
signal tmp:std_logic_vector (6 downto 0):=(others =>'0');
BEGIN
process (clockdeffor1mhz)
begin
	if (rising_edge(clockdeffor1mhz)) then
		if tmp =("1100011") then tmp <="0000000";
			elsif (tmp <= "0110001") then
				tmp <= tmp +1;
				div_clk1mhz <='0';
			else div_clk1mhz <= '1';
				tmp <= tmp +1;
	end if;
	end if;
end process;
END TypeArchitecture;