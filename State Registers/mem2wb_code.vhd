----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:18:55 12/05/2022 
-- Design Name: 
-- Module Name:    mem2wb_code - Behavioral 
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

entity mem2wb_code is

port (  	  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  memdatain : in  STD_LOGIC_VECTOR (23 downto 0);
           pcmemin : in  STD_LOGIC_VECTOR (23 downto 0);
           memtoregin : in  STD_LOGIC;
			  regwritein : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dstin : in STD_LOGIC_VECTOR (3 downto 0);
           aluresultin : in  STD_LOGIC_VECTOR (23 downto 0);
				---- output ----
			  memdataout : out  STD_LOGIC_VECTOR (23 downto 0);
           pcmemout : out  STD_LOGIC_VECTOR (23 downto 0);
           memtoregout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC;
			  branchout : out STD_LOGIC;
			  dstout : out STD_LOGIC_VECTOR (3 downto 0);
           aluresultout : out  STD_LOGIC_VECTOR (23 downto 0));

end mem2wb_code;

architecture Behavioral of mem2wb_code is

begin

process (clk,rst)
begin
if rst='1' then
	memdataout <= x"000000";
	pcmemout <= x"000000";
	memtoregout <= '0';
	regwriteout <= '0';
	dstout <= x"0";
	aluresultout <= x"000000";
	branchout <= '0';
elsif rising_edge(clk) and rst = '0' then
	memdataout <= memdatain;
	pcmemout <= pcmemin;
	memtoregout <= memtoregin;
	regwriteout <= regwritein;
	dstout <= dstin;
	aluresultout <= aluresultin;
	branchout <= branchin;
end if;
end process;

end Behavioral;

