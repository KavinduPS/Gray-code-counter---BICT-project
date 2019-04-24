
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hex_to_sseg is
port(q_in: in STD_LOGIC_VECTOR(3 downto 0);
	  q_out: out STD_LOGIC_VECTOR(6 downto 0)
	  );
end hex_to_sseg;

architecture Behavioral of hex_to_sseg is

begin
	
	with q_in select
	q_out<= "0000001" when "0000", --0
			"1001111" when "0001", --1
			"0010010" when "0011", --2
			"0000110" when "0010", --3
			"1001100" when "0110", --4
			"0100100" when "0111", --5
			"0100000" when "0101", --6
			"0001111" when "0100", --7
			"0000000" when "1100", --8
			"0000100" when "1101", --9
			"0001000" when "1111", --a
			"1100000" when "1110", --b
			"0110001" when "1010", --c
			"1000010" when "1011", --d
			"0110000" when "1001", --e
			"0111000" when "1000", --f
			"1111111" when others; --nic

end Behavioral;