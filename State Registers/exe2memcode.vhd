----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:52:45 12/05/2022 
-- Design Name: 
-- Module Name:    exe2memcode - Behavioral 
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

entity exe2memcode is
port (	  aluresult : in  STD_LOGIC_VECTOR (23 downto 0);
           pcexe : in  STD_LOGIC_VECTOR (23 downto 0);
			  st_value : in STD_LOGIC_VECTOR (23 downto 0);
           dstin : in  STD_LOGIC_VECTOR (3 downto 0);
           memreadin : in  STD_LOGIC;
           memwritein : in  STD_LOGIC;
			  branchin : in  STD_LOGIC;
			  regwritein : in  STD_LOGIC;
			  memtoregin : in  STD_LOGIC;
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ---output---
			  aluresultout: out STD_LOGIC_VECTOR (23 downto 0);
			  st_valueout : out  STD_LOGIC_VECTOR (23 downto 0);
			  memtoregout : out  STD_LOGIC;
			  pcexeout : out  STD_LOGIC_VECTOR (23 downto 0);
			  dstout : out  STD_LOGIC_VECTOR (3 downto 0);
           memreadout : out  STD_LOGIC;
			  branchout : out  STD_LOGIC;
           memwriteout : out  STD_LOGIC;
			  regwriteout : out STD_LOGIC
			  );
end exe2memcode;

architecture Behavioral of exe2memcode is

begin
process(clk,rst)
begin
if rst='1' then
	aluresultout <= x"000000";
	memtoregout <= '0';
	pcexeout <= x"000000";
	dstout <= x"0";
	memreadout <= '0';
	memwriteout <= '0';
	regwriteout <= '0';
	branchout <= '0';
	st_valueout <= x"000000";
elsif rising_edge(clk) and rst = '0' then
	aluresultout <= aluresult;
	memtoregout <= memtoregin;
	branchout <= branchin;
	pcexeout <= pcexe;
	dstout <= dstin;
	memreadout <= memreadin;
	memwriteout <= memwritein;
	regwriteout <= regwritein;
	st_valueout <= st_value;
end if;
end process;

end Behavioral;

