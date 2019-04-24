
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

entity top is
Port(   clk_i: in std_logic;
		btn_i: in std_logic;
		sw_i: in std_logic_vector(1 downto 0);
		disp_sseg_o: out std_logic_vector(6 downto 0);
		disp_digit_o : out std_logic_vector(4-1 downto 0)
		);
end top;

architecture Behavioral of top is
       
	--------------------------------------------------
   component clk_divider is
   generic (DIVIDER : positive :=8000); 
Port 			(CLK_IN  : in std_logic;
				CLK_OUT : out std_logic; 
                PULSE   : out std_logic
				);
end component;
	--------------------------------------------------
component three_bit_up is
Port 			(clk: in std_logic;
				rst: in std_logic;
				q: out std_logic_vector(3 downto 0)
				);
end component;
	--------------------------------------------------
component three_bit_down is
Port 			(clk: in std_logic;
				rst: std_logic;		
				q: out std_logic_vector(3 downto 0)
				);
end component;
	---------------------------------------------------
		component four_bit_up is
	Port 		(clk: in std_logic;
				rst: std_logic;
				q: out std_logic_vector(3 downto 0)
				);
		end component;
	---------------------------------------------------

	component four_bit_down is
	Port 			(clk: in std_logic;
				 rst: std_logic;
				 q  : out std_logic_vector(3 downto 0)
				);
	end component;
	--------------------------------------------------

	component hex_to_sseg is
		port(q_in : in  STD_LOGIC_VECTOR(3 downto 0);
			  q_out: out STD_LOGIC_VECTOR(6 downto 0)
			  );
	end component;
	--------------------------------------------------	
		component mux is
	port(
				a1      : in  std_logic_vector(3 downto 0);
				a2      : in  std_logic_vector(3 downto 0);
				a3      : in  std_logic_vector(3 downto 0);
				a4      : in  std_logic_vector(3 downto 0);
				sel     : in  std_logic_vector(1 downto 0);
				b       : out std_logic_vector(3 downto 0));
	end component;
		---------------------------------------------------
    signal clk_1Hz_s : std_logic;
	signal q_s       : std_logic_vector(3 downto 0);
	signal q_sd      : std_logic_vector(3 downto 0);
	signal q_s4bu	 : std_logic_vector(3 downto 0);
	signal q_s4bd    : std_logic_vector(3 downto 0);
	signal q_dec_out : std_logic_vector(6 downto 0);	
	signal q_mux_out : std_logic_vector(3 downto 0);
  			
begin
    a1: clk_divider generic map(DIVIDER=>8000)
				port map(CLK_IN=>clk_i, CLK_OUT=>clk_1Hz_s);
	a2: three_bit_up port map(clk=>clk_1Hz_s, rst=>btn_i, q=>q_s);
	a3: three_bit_down port map(clk=>clk_1Hz_s, rst=>btn_i, q=>q_sd);
	a4: four_bit_up port map(clk=>clk_1Hz_s, rst=>btn_i, q=>q_s4bu);
	a5: four_bit_down port map(clk=>clk_1Hz_s, rst=>btn_i, q=>q_s4bd);
	a6: mux port map(a1=>q_s,a2=>q_sd,a3=>q_s4bu,a4=>q_s4bd,sel=>sw_i,b=>q_mux_out);
	a7: hex_to_sseg port map(q_in=>q_mux_out, q_out=>q_dec_out);
	disp_sseg_o<=q_dec_out;
	disp_digit_o<="1110";
    
end Behavioral;