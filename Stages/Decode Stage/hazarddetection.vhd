----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:18:38 12/17/2022 
-- Design Name: 
-- Module Name:    hazarddetection - Behavioral 
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

entity hazarddetection is
    Port ( rs : in  STD_LOGIC_VECTOR (3 downto 0);
           rt : in  STD_LOGIC_VECTOR (3 downto 0);
           rd : in  STD_LOGIC_VECTOR (3 downto 0);
           dmemread : in  STD_LOGIC; --memory read signal from execute 
           pcwrite : out  STD_LOGIC:= '0'; --used to freeze pc --
           if2dwrite : out  STD_LOGIC:= '0'; -- used to freeze fetch/decode stage --
           signalswrite : out  STD_LOGIC:= '0');
end hazarddetection;

architecture Behavioral of hazarddetection is

begin
process(rs,rt,rd,dmemread)
begin
if (dmemread = '1') and (rs=rd or rt=rd) then --there is a hazard
	pcwrite <= '1'; -- PC is suspended "no signals will be passed"
	if2dwrite <= '1'; -- the fetch/decode state is suspended "no signals will be passed"
	signalswrite <= '1'; --write signal is suspended 
else
	pcwrite <= '0';
	if2dwrite <= '0';
	signalswrite <= '0';
end if;
end process;

end Behavioral;

