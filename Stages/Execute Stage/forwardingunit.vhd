----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:42 12/17/2022 
-- Design Name: 
-- Module Name:    forwardingunit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity forwardingunit is
    Port ( rs : in  STD_LOGIC_VECTOR (3 downto 0);
           rt : in  STD_LOGIC_VECTOR (3 downto 0);
			  opcode : in STD_LOGIC_VECTOR (5 downto 0 );
           exrd : in  STD_LOGIC_VECTOR (3 downto 0);
           memrd : in  STD_LOGIC_VECTOR (3 downto 0);
           exregwrite : in  STD_LOGIC;
           memregwrite : in  STD_LOGIC;
			  forwardst : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0));
end forwardingunit;

architecture Behavioral of forwardingunit is

begin
process(rs,rt,exrd,memrd,exregwrite,memregwrite)
begin
--st value--
if (exregwrite='1' and rt=exrd) then  --ex dst is rt for store inst--
	forwardst <= "10";
elsif (memregwrite='1' and rt=memrd) then --mem dst is rt for store inst--
	forwardst <= "01";
else
	forwardst <= "00"; --nothing--
end if;
--ex hazard--
if (exregwrite='1' and rs=exrd) then --ex dst is rs for alu first operand --
	forwardA <= "10";
elsif (memregwrite='1' and rs=memrd) then --mem dst is rs for alu first operand --
	forwardA <= "01";
else
	forwardA <= "00"; --nothing--
end if;
if (exregwrite='1' and rt=exrd and opcode = "000000") then --ex dst is rt for alu second operand --
	forwardB <= "10";
elsif (memregwrite='1' and rt=memrd and opcode = "000000") then --mem dst is rt for alu second operand --
	forwardB <= "01";
else
	forwardB <= "00"; --nothing--
end if;
end process;

end Behavioral;

