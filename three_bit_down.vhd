
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity three_bit_down is
Port 			(clk: in std_logic;
				 rst: in std_logic;
				 q  : out std_logic_vector(3 downto 0)
				);
end three_bit_down;

architecture Behavioral of three_bit_down is

signal counter: std_logic_vector(3 downto 0);
signal d      : std_logic_vector(3 downto 0);

begin
	
	--s
	process(clk,rst,d)
	begin
	if rst='0' then
	counter<="0000";
	elsif (clk'event and clk='1') then
		if counter = "0000" then
			counter<="0100";
		else
			counter<=d;	
	end if;
	end if;
	end process;
	
	--k
	process(counter)
	begin
	d(3) <= '0';
	d(2) <= (counter(2) and (not counter(1))) or (counter(2) and  counter(1) and counter(0)) or (counter(3) and counter(1) and (not counter(0)));
	d(1) <= ((not counter(3)) and counter(2) and counter(0)) or (counter(3) and (not counter(2)) and counter(0)) or (counter(1) and (not counter(0)));
	d(0) <= ((not counter(3)) and (not counter(2)) and counter(1)) or ((not counter(3)) and counter(2) and (not counter(1))) or (counter(3) and counter(2) and counter(1)) or (counter(3) and (not counter(2)) and (not counter(1)));
	end process;
	q<= counter;

end Behavioral;
