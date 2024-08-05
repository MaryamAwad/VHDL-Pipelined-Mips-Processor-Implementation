----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:28:51 12/05/2022 
-- Design Name: 
-- Module Name:    wb_stagecode - Behavioral 
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

entity wb_stagecode is
port (clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  memdatain : in  STD_LOGIC_VECTOR (23 downto 0);
           pcwbin : in  STD_LOGIC_VECTOR (23 downto 0);
           memtoregin : in  STD_LOGIC;
			  regwritein : in STD_LOGIC;
			  branchin : in STD_LOGIC;
			  dstin : in STD_LOGIC_VECTOR (3 downto 0);
           aluresultin : in  STD_LOGIC_VECTOR (23 downto 0);
			  -- output--
			  pcwbout : out STD_LOGIC_VECTOR (23 downto 0);
			  wbdata : out  STD_LOGIC_VECTOR (23 downto 0);
			  dstout : out STD_LOGIC_VECTOR (3 downto 0);
			  branchout : out STD_LOGIC;
			  regwriteout : out STD_LOGIC);
end wb_stagecode;

architecture Behavioral of wb_stagecode is

begin
with memtoregin select
wbdata <= aluresultin when '0', --write the alu result for R-type inst--
			 memdatain when others; -- write from data memory in the load inst-- 
pcwbout <= pcwbin;
branchout <= branchin;
regwriteout <= regwritein;
dstout <= dstin;
end Behavioral;

