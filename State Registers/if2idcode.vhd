----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:01 12/05/2022 
-- Design Name: 
-- Module Name:    if2idcode - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
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

entity if2idcode is
port(
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  if2dwrite : in STD_LOGIC; -- hazard detection signal of the state
			  PC_IN	: in	STD_LOGIC_VECTOR(23 downto 0);
	        INST_IN	: in	STD_LOGIC_VECTOR(23 downto 0);
	        PC_OUT	: out	STD_LOGIC_VECTOR(23 downto 0);
	        INST_OUT	: out	STD_LOGIC_VECTOR(23 downto 0));
end if2idcode;

architecture Behavioral of if2idcode is

begin

process(clk,rst)
		begin
			if rst = '1' then
				PC_OUT	<= x"000000";
				INST_OUT	<= x"000000";
			elsif rising_edge(CLK) and rst = '0' and if2dwrite = '0' then
				PC_OUT	<= PC_IN;
				INST_OUT <= INST_IN;
			end if;
		end process; 

end Behavioral;

